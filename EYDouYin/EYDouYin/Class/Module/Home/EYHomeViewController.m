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

// 同城
@property (weak, nonatomic) UIView *homeCityView;

//数据数组
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
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:EYScreenBounds];
    scrollView.contentSize = CGSizeMake(EYScreenWidth, EYScreenHeight * 3);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    [self.view insertSubview:scrollView atIndex:0];
    self.scrollView = scrollView;

    EYHomeCityViewController *homeCityViewController = [[EYHomeCityViewController alloc] init];
    UIView *homeCityView = homeCityViewController.view;
    homeCityView.hidden = YES;
    [self.view insertSubview:homeCityView atIndex:0];
    self.homeCityView = homeCityView;
    [self addChildViewController:homeCityViewController];

    // 声音控制
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeChange:) name:EYHomeViewControllerSystemVolumeDidChangeNotification object:nil];
    [self.view addSubview:[self getSystemVolumSlider]];
}

- (void)loadNetData {
    NSString *jsonName = @"Items.json";
    NSArray *jsonArray = jsonName.ey_loadLocalFile;

    for (int i = 0; i < jsonArray.count; i++) {
        NSDictionary * dictionary = jsonArray[i];
        [self.itemArrayM addObject:[EYHomeItemModel modelWithDictionary:dictionary]];
        EYHomeItemView * itemView = [EYHomeItemView homeItemView];
        itemView.frame = CGRectMake(0, EYScreenHeight * i, EYScreenWidth, EYScreenHeight);
        itemView.backgroundColor = EYRandomColor;
        [self.scrollView addSubview:itemView];
    }

//    for (EYHomeItemModel * model in self.itemArrayM) {
//
//    }
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
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {// 开始拖拽
    EYLog(@"scrollView将会开始拖拽");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {// 结束拖拽
    EYLog(@"scrollView已经结束拖拽");
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {//结束拖拽后立即开始减速
    EYLog(@"scrollView将会开始减速");
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {// 滚动停止了
    EYLog(@"scrollView已经结束减速");
}

#pragma mark - 懒加载
- (NSMutableArray *)itemArrayM {
    if (nil == _itemArrayM) {
        _itemArrayM = [NSMutableArray array];
    }
    return _itemArrayM;
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
