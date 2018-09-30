//
//  EYHomeViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/23.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYHomeViewController.h"
#import "EYRootViewController.h"
#import "EYHomeTitleView.h"
#import "EYHomeItemView.h"
#import "EYHomeItemModel.h"
#import "EYHomeCityViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AppDelegate.h"
#import "EYHomeBackView.h"
#import "EYHomeBackItemModel.h"

@interface EYHomeViewController () <EYHomeTitleViewDelegate, EYHomeBackViewDelegate, UIScrollViewDelegate>

@property (assign, nonatomic, readwrite) EYHomeViewControllerButtonType type;

// 后面的背景 view
@property (weak, nonatomic) EYHomeBackView *backView;

// 主页的滚动视图
@property (weak, nonatomic) UIScrollView *scrollView;

// 上滑的 view, 用来恢复 scrollView 的位置
@property (weak, nonatomic) UIView *upSwipeView;

// 3个 view 视图
@property (strong, nonatomic) NSMutableArray <EYHomeItemView *> *itemViewArrayM;

// 同城
@property (weak, nonatomic) UIView *homeCityView;

// 数据数组
@property (strong, nonatomic) NSMutableArray *itemArrayM;

@property (strong, nonatomic) NSMutableArray *modelArrayM;
@end

@implementation EYHomeViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];

    // 模拟网络数据
    [self loadNetData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // 隐藏电池
    [UIApplication sharedApplication].statusBarHidden = YES;

    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.rootViewController.scrollView.scrollEnabled = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.rootViewController.scrollView.scrollEnabled = NO;
}

- (void)setupUI {
    [self.view clipsCornerRadius:UIRectCornerAllCorners cornerRadii:5.0];
    [self.view addSubview:[self getSystemVolumSlider]];

    self.view.backgroundColor = [UIColor blackColor];
    // 1.底层的 view
    EYHomeBackView *backView = [EYHomeBackView homeBackView];
    backView.frame = CGRectMake(0, 0, EYScreenWidth, EYBackViewHeight);
    backView.delegate = self;
    backView.backgroundColor = [UIColor blackColor];
    [self.view insertSubview:backView atIndex:0];
    self.backView = backView;

    self.naviBar.hidden = NO;
    // 2.titleView
    EYHomeTitleView * titleView = [EYHomeTitleView homeTitleView];
    titleView.delegate = self;
    [self.naviBar addSubview:titleView];

    // 3.scrollView
    self.scrollView.hidden = NO;

    // 4.同城 view
    self.homeCityView.hidden = YES;
}

- (void)loadNetData {
    NSString *jsonName = @"Items.json";
    NSArray *jsonArray = jsonName.ey_loadLocalFile;

    if (jsonArray.count < 3) {
        return;
    }

    for (int i = 0; i < jsonArray.count; i++) {
        NSDictionary * dictionary = jsonArray[i];
        [self.itemArrayM addObject:[EYHomeItemModel modelWithDictionary:dictionary]];
    }
}

#pragma mark - Private Methods


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - EYHomeTitleViewDelegate
- (void)homeTitleView:(EYHomeTitleView *)view didSelectedButton:(EYHomeTitleViewButtonType)buttonType {
    switch (buttonType) {
        case EYHomeTitleViewButtonTypeSearch: {
            [self search];
            break;
        }case EYHomeTitleViewButtonTypeMore: {
            [self more];
            break;
        }case EYHomeTitleViewButtonTypeRecommend: {
            [self recommend];
            break;
        }case EYHomeTitleViewButtonTypeCity: {
            [self city];
            break;
        }
        default:
            break;
    }
}

- (void)search {
    EYLog(@"搜索");
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.rootViewController.scrollView setContentOffset:CGPointZero animated:YES];
}

- (void)recommend {
    EYLog(@"推荐");
    self.scrollView.hidden = NO;
    self.homeCityView.hidden = YES;
    self.type = EYHomeViewControllerButtonTypeRecommend;
    [self changTabbarBackgroundColor:[UIColor clearColor]];
}

- (void)city {
    EYLog(@"同城");
    self.scrollView.hidden = YES;
    self.homeCityView.hidden = NO;
    self.type = EYHomeViewControllerButtonTypeCity;
    [self changTabbarBackgroundColor:[UIColor blackColor]];
}

- (void)changTabbarBackgroundColor:(UIColor *)color {
    [EYNotificationCenter postNotificationName:EYTabbarShouldChangeColorNotification object:nil userInfo:@{@"color" : color}];
}

- (void)more {
    CGFloat naviBarY = self.naviBar.mj_y;
    EYLog(@"更多");
    if (naviBarY == EYStatusBarHeight) {// scrollView向下滚动
        [self changeFrameWithPOP:self.naviBar offsetY:EYBackViewHeight];
        [self changeFrameWithPOP:self.scrollView offsetY:EYBackViewHeight];
        self.upSwipeView.hidden = NO;
        for (EYHomeItemView *view in self.itemViewArrayM) {
            view.homeInfoView.hidden = YES;
            view.homeSharedView.hidden = YES;
        }

        [self.backView showWithArray:self.modelArrayM];
    } else {// scrollView恢复原始位置
        [self changeFrameWithPOP:self.naviBar offsetY:-EYBackViewHeight];
        [self changeFrameWithPOP:self.scrollView offsetY:-EYBackViewHeight];
        self.upSwipeView.hidden = YES;
        for (EYHomeItemView *view in self.itemViewArrayM) {
            view.homeInfoView.hidden = NO;
            view.homeSharedView.hidden = NO;
        }
        [self.backView close];
    }
}

- (void)changeFrameWithPOP:(UIView *)view offsetY:(CGFloat)y {
    POPBasicAnimation * anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.fromValue = @(view.centerY);
    anim.toValue = @(view.centerY + y);
    anim.duration = 0.5;
    [view pop_addAnimation:anim forKey:nil];
}

#pragma mark - EYHomeBackViewDelegate
- (void)homeBackViewDidSelectedModel:(EYHomeBackItemModel *)model {
    EYLog(@"----1111--%@-", model);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    EYLog(@"scrollView滚动到顶部了");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // EYLog(@"scrollView滚动了");
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView  {// 开始拖拽
    // EYLog(@"scrollView将会开始拖拽--状态为");

    CGFloat y = [scrollView.panGestureRecognizer translationInView:scrollView.superview].y;
    CGFloat offsetY = scrollView.contentOffset.y;

    if (y > 0 && offsetY == 0.0) {
        EYLog(@"开始拖拽--可以刷新界面了--");
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {// 结束拖拽
    CGFloat y = scrollView.contentOffset.y;
    EYLog(@"scrollView已经结束拖拽--状态为,结束的位置为:%f", y);

//    if (y == 0.0) {
//        EYLog(@"可以刷新界面了--");
//    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {//结束拖拽后立即开始减速
    // EYLog(@"scrollView将会开始减速位置为:%f", scrollView.contentOffset.y);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {// 滚动停止了
    int index = scrollView.contentOffset.y / EYScreenHeight;

    EYLog(@"scrollView已经结束减速:%d--位置为:%f", index, scrollView.contentOffset.y);

    CGFloat y = [scrollView.panGestureRecognizer translationInView:scrollView.superview].y;

    if (y < 0 && index == self.itemViewArrayM.count - 1) {// 最后一个
        [self.itemViewArrayM insertObject:self.itemViewArrayM.firstObject atIndex:self.itemViewArrayM.count];
        [self.itemViewArrayM removeFirstObject];

        for (int i = 0; i < self.itemViewArrayM.count; i++) {
            EYHomeItemView *itemView = self.itemViewArrayM[i];
            itemView.frame = CGRectMake(0, EYScreenHeight * i, EYScreenWidth, EYScreenHeight);
        }
        [scrollView setContentOffset:CGPointMake(0, EYScreenHeight) animated:NO];
    }

    if (y > 0 && index == 0) {
        [self.itemViewArrayM insertObject:self.itemViewArrayM.lastObject atIndex:0];
        [self.itemViewArrayM removeLastObject];

        for (int i = 0; i < self.itemViewArrayM.count; i++) {
            EYHomeItemView *itemView = self.itemViewArrayM[i];
            itemView.frame = CGRectMake(0, EYScreenHeight * i, EYScreenWidth, EYScreenHeight);
        }
        [scrollView setContentOffset:CGPointMake(0, EYScreenHeight) animated:NO];
    }
}


#pragma mark - 懒加载
- (NSMutableArray *)itemArrayM {
    if (nil == _itemArrayM) {
        _itemArrayM = [NSMutableArray array];
    }
    return _itemArrayM;
}

- (NSMutableArray *)itemViewArrayM {
    if (nil == _itemViewArrayM) {
        _itemViewArrayM = [NSMutableArray array];
    }
    return _itemViewArrayM;
}

- (UIScrollView *)scrollView {
    if (nil == _scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:EYScreenBounds];
        scrollView.layer.cornerRadius = 5.0;
        scrollView.contentSize = CGSizeMake(EYScreenWidth, EYScreenHeight * 3);
        if (@available(iOS 11.0, *)) {
            scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        [self.view insertSubview:scrollView belowSubview:self.naviBar];
        self.scrollView = scrollView;

        for (int i = 0; i < 3; i++) {
            EYHomeItemView *itemView = [EYHomeItemView homeItemView];
            itemView.frame = CGRectMake(0, EYScreenHeight * i, EYScreenWidth, EYScreenHeight);
            itemView.backgroundColor = EYRandomColor;
            [scrollView addSubview:itemView];
            [self.itemViewArrayM addObject:itemView];
        }
    }
    return _scrollView;
}

- (UIView *)upSwipeView {
    if (nil == _upSwipeView) {
        // 创建蒙层view
        UIView * swipeView = [[UIView alloc] initWithFrame:CGRectMake(0, EYBackViewHeight, EYScreenWidth, EYScreenHeight - EYBackViewHeight - EYTabBarHeight)];
        swipeView.backgroundColor = [UIColor clearColor];
        [self.view insertSubview:swipeView belowSubview:self.naviBar];
        _upSwipeView = swipeView;

        // 滑动手势
        UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(more)];
        upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
        [swipeView addGestureRecognizer:upSwipe];
    }
    return _upSwipeView;
}

- (UIView *)homeCityView {
    if (nil == _homeCityView) {
        EYHomeCityViewController *homeCityViewController = [[EYHomeCityViewController alloc] init];
        UIView *homeCityView = homeCityViewController.view;
        [self.view insertSubview:homeCityView belowSubview:self.naviBar];
        _homeCityView = homeCityView;
        [self addChildViewController:homeCityViewController];
    }
    return _homeCityView;
}

- (NSMutableArray *)modelArrayM {
    if (nil == _modelArrayM) {
        _modelArrayM = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            EYHomeBackItemModel * model = [[EYHomeBackItemModel alloc] init];
            [_modelArrayM addObject:model];
        }
    }
    return _modelArrayM;
}

#pragma mark - 音量控制
/*
 * 获取系统音量滑块
 */
- (UIView *)getSystemVolumSlider{
    UIView * view = nil;
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    for (UIView *newView in volumeView.subviews) {
        if ([newView.class.description isEqualToString:@"MPVolumeSlider"]){
            newView.frame = CGRectMake(-300, -300, 1, 1);
            view = newView;
            break;
        }
    }
    return view;
}

@end
