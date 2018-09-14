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
// 3个 view 视图
@property (strong, nonatomic) NSMutableArray <EYHomeItemView *> *itemViewArrayM;

@property (assign, nonatomic) CGFloat beginDraggingY;
@property (assign, nonatomic) BOOL isLookNext; //是否看的是下一个(向上拖拽)

// 同城
@property (weak, nonatomic) UIView *homeCityView;

// 数据数组
@property (strong, nonatomic) NSMutableArray *itemArrayM;

@end

@implementation EYHomeViewController

NSString *const EYHomeViewControllerSystemVolumeDidChangeNotification=@"AVSystemController_SystemVolumeDidChangeNotification";

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];

    [self setupNotification];

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
    self.scrollView.hidden = NO;

    // 3.同城 view
    self.homeCityView.hidden = YES;

    // 4.声音控制(隐藏视图)
    [self.view addSubview:[self getSystemVolumSlider]];
}

- (void)setupNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeChange:) name:EYHomeViewControllerSystemVolumeDidChangeNotification object:nil];
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

    if (self.isLookNext && index == self.itemViewArrayM.count - 1) {// 最后一个
        [self.itemViewArrayM insertObject:self.itemViewArrayM.firstObject atIndex:self.itemViewArrayM.count];
        [self.itemViewArrayM removeFirstObject];

        for (int i = 0; i < self.itemViewArrayM.count; i++) {
            EYHomeItemView *itemView = self.itemViewArrayM[i];
            itemView.frame = CGRectMake(0, EYScreenHeight * i, EYScreenWidth, EYScreenHeight);
        }
        [scrollView setContentOffset:CGPointMake(0, EYScreenHeight) animated:NO];
    }

    if (!self.isLookNext && index == 0) {
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
        scrollView.contentSize = CGSizeMake(EYScreenWidth, EYScreenHeight * 3);
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
