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

@interface EYHomeViewController () <EYHomeTitleViewDelegate, UIScrollViewDelegate>

@property (assign, nonatomic, readwrite) EYHomeViewControllerButtonType type;

// 主页的滚动视图
@property (weak, nonatomic) UIScrollView *scrollView;
// 上一个
@property (weak, nonatomic) EYHomeItemView * previousHomeItemView;
// 当前的
@property (weak, nonatomic) EYHomeItemView * currentHomeItemView;
// 下一个
@property (weak, nonatomic) EYHomeItemView * nextHomeItemView;

@property (assign, nonatomic) CGFloat beginDraggingY;
@property (assign, nonatomic) BOOL isLookNext; //是否看的是下一个(向上拖拽)

// 同城
@property (weak, nonatomic) UIView *homeCityView;

// 数据数组
@property (strong, nonatomic) NSMutableArray *itemArrayM;

@end

@implementation EYHomeViewController

NSString *const EYHomeViewControllerSystemVolumeDidChangeNotification=@"AVSystemController_SystemVolumeDidChangeNotification";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];

    // 模拟网络数据
    [self loadNetData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [UIApplication sharedApplication].statusBarHidden = YES;
    EYRootViewController * rootViewController = (EYRootViewController *)EYKeyWindowRootViewController;
    rootViewController.scrollView.scrollEnabled = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [UIApplication sharedApplication].statusBarHidden = NO;

    EYRootViewController * rootViewController = (EYRootViewController *)EYKeyWindowRootViewController;
    rootViewController.scrollView.scrollEnabled = NO;
}

- (void)setupUI {
    self.naviBar.hidden = NO;
    // 1.titleView
    EYHomeTitleView * titleView = [EYHomeTitleView homeTitleView];
    titleView.delegate = self;
    [self.naviBar addSubview:titleView];

    // 2.scrollView
    [self previousHomeItemView];
    [self currentHomeItemView];
    [self nextHomeItemView];

    // 3.同城 view
    EYHomeCityViewController *homeCityViewController = [[EYHomeCityViewController alloc] init];
    UIView *homeCityView = homeCityViewController.view;
    homeCityView.hidden = YES;
    [self.view insertSubview:homeCityView atIndex:0];
    self.homeCityView = homeCityView;
    [self addChildViewController:homeCityViewController];

    // 4.声音控制(隐藏视图)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeChange:) name:EYHomeViewControllerSystemVolumeDidChangeNotification object:nil];
    [self.view addSubview:[self getSystemVolumSlider]];
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

- (void)volumeChange:(NSNotification*)notifi{
    NSString * style = [notifi.userInfo objectForKey:@"AVSystemController_AudioCategoryNotificationParameter"];
    CGFloat value = [[notifi.userInfo objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"] doubleValue];
    if ([style isEqualToString:@"Audio/Video"]){
        NSLog(@"音量改变 当前值:%f",value);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    EYTestViewController * vc= [[EYTestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Life Cycle
#pragma mark - Public Methods
#pragma mark - Private Methods
- (void)search {
    EYLog(@"搜索");
    EYRootViewController * rootViewController = (EYRootViewController *)EYKeyWindowRootViewController;
    [rootViewController.scrollView setContentOffset:CGPointZero animated:YES];
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
    EYLog(@"更多");
}

// 计算下一个
- (void)changeThreeItemViewFrameNext {
    CGFloat previousY = self.previousHomeItemView.frame.origin.y;
    if (previousY == 0) {
        self.currentHomeItemView.frame = CGRectMake(0, 0, EYScreenWidth, EYScreenHeight);
        self.nextHomeItemView.frame = CGRectMake(0, EYScreenHeight, EYScreenWidth, EYScreenHeight);
        self.previousHomeItemView.frame = CGRectMake(0, EYScreenHeight * 2, EYScreenWidth, EYScreenHeight);
    } else if (previousY == EYScreenHeight * 2) {
        self.nextHomeItemView.frame = CGRectMake(0, 0, EYScreenWidth, EYScreenHeight);
        self.previousHomeItemView.frame = CGRectMake(0, EYScreenHeight, EYScreenWidth, EYScreenHeight);
        self.currentHomeItemView.frame = CGRectMake(0, EYScreenHeight * 2, EYScreenWidth, EYScreenHeight);
    } else {
        self.previousHomeItemView.frame = CGRectMake(0, 0, EYScreenWidth, EYScreenHeight);
        self.currentHomeItemView.frame = CGRectMake(0, EYScreenHeight, EYScreenWidth, EYScreenHeight);
        self.nextHomeItemView.frame = CGRectMake(0, EYScreenHeight * 2, EYScreenWidth, EYScreenHeight);
    }
}

// 计算上一个
- (void)changeThreeItemViewFramePrevious {
    CGFloat previousY = self.previousHomeItemView.frame.origin.y;
    if (previousY == 0) {
        self.nextHomeItemView.frame = CGRectMake(0, 0, EYScreenWidth, EYScreenHeight);
        self.previousHomeItemView.frame = CGRectMake(0, EYScreenHeight, EYScreenWidth, EYScreenHeight);
        self.currentHomeItemView.frame = CGRectMake(0, EYScreenHeight * 2, EYScreenWidth, EYScreenHeight);
    } else if (previousY == EYScreenHeight * 2) {
        self.previousHomeItemView.frame = CGRectMake(0, 0, EYScreenWidth, EYScreenHeight);
        self.currentHomeItemView.frame = CGRectMake(0, EYScreenHeight, EYScreenWidth, EYScreenHeight);
        self.nextHomeItemView.frame = CGRectMake(0, EYScreenHeight * 2, EYScreenWidth, EYScreenHeight);
    } else {
        self.currentHomeItemView.frame = CGRectMake(0, 0, EYScreenWidth, EYScreenHeight);
        self.nextHomeItemView.frame = CGRectMake(0, EYScreenHeight, EYScreenWidth, EYScreenHeight);
        self.previousHomeItemView.frame = CGRectMake(0, EYScreenHeight * 2, EYScreenWidth, EYScreenHeight);
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
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

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    EYLog(@"scrollView滚动到顶部了");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    EYLog(@"scrollView滚动了");
    if (scrollView.contentOffset.y < self.beginDraggingY ){
        NSLog(@"向下拖拽");
        self.isLookNext = NO;
    } else if (scrollView.contentOffset.y > self.beginDraggingY ){
        NSLog(@"向上拖拽");
        self.isLookNext = YES;
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {// 开始拖拽
    EYLog(@"scrollView将会开始拖拽");
    //全局变量记录滑动前的contentOffset
    self.beginDraggingY = scrollView.contentOffset.y;//判断上下滑动时
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {// 结束拖拽
    EYLog(@"scrollView已经结束拖拽");
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {//结束拖拽后立即开始减速
    EYLog(@"scrollView将会开始减速");
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {// 滚动停止了
    int index = scrollView.contentOffset.y / EYScreenHeight;

    EYLog(@"scrollView已经结束减速:%d", index);

    if (index == 2 && self.isLookNext) {// 最后一个
        [self changeThreeItemViewFrameNext];
        [scrollView setContentOffset:CGPointMake(0, EYScreenHeight) animated:NO];
    }

    if (index == 0 && !self.isLookNext) {
        [self changeThreeItemViewFramePrevious];
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

- (UIScrollView *)scrollView {
    if (nil == _scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:EYScreenBounds];
        scrollView.contentSize = CGSizeMake(EYScreenWidth, EYScreenHeight * 3);
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        [self.view insertSubview:scrollView atIndex:0];
        self.scrollView = scrollView;
    }
    return _scrollView;
}

- (EYHomeItemView *)previousHomeItemView {
    if (nil == _previousHomeItemView) {
        EYHomeItemView * itemView = [EYHomeItemView homeItemView];
        itemView.frame = CGRectMake(0, 0, EYScreenWidth, EYScreenHeight);
        itemView.backgroundColor = [UIColor redColor];
        [self.scrollView addSubview:itemView];
        _previousHomeItemView = itemView;
    }
    return _previousHomeItemView;
}

- (EYHomeItemView *)currentHomeItemView {
    if (nil == _currentHomeItemView) {
        EYHomeItemView * itemView = [EYHomeItemView homeItemView];
        itemView.frame = CGRectMake(0, EYScreenHeight, EYScreenWidth, EYScreenHeight);
        itemView.backgroundColor = [UIColor greenColor];
        [self.scrollView addSubview:itemView];
        _currentHomeItemView = itemView;
    }
    return _currentHomeItemView;
}

- (EYHomeItemView *)nextHomeItemView {
    if (nil == _nextHomeItemView) {
        EYHomeItemView * itemView = [EYHomeItemView homeItemView];
        itemView.frame = CGRectMake(0, EYScreenHeight * 2, EYScreenWidth, EYScreenHeight);
        itemView.backgroundColor = [UIColor blueColor];
        [self.scrollView addSubview:itemView];
        _nextHomeItemView = itemView;
    }
    return _nextHomeItemView;
}

#pragma mark - 音量控制
/*
 *获取系统音量滑块
 */
- (UIView *)getSystemVolumSlider{
    UIView * view = nil;
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    for (UIView *newView in volumeView.subviews) {
        if ([newView.class.description isEqualToString:@"MPVolumeSlider"]){
            newView.hidden = YES;
            view = newView;
            break;
        }
    }
    return view;
}

- (void)dealloc {
    [EYNotificationCenter removeObserver:self];
}

@end
