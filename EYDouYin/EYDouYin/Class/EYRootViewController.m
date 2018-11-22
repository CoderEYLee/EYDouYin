//
//  EYRootViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/22.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYRootViewController.h"
#import "EYFindViewController.h"
#import "EYTabBarController.h"
#import "EYNavigationController.h"
#import "EYHomeWorksViewController.h"
#import "EYScrollView.h"

@interface EYRootViewController () <UIScrollViewDelegate, GKViewControllerPushDelegate, EYTabBarControllerDelegate, UITabBarControllerDelegate>

@property (weak, nonatomic, readwrite) EYScrollView *scrollView;

@property (assign, nonatomic) EYTabBarViewType indexType;

@end

@implementation EYRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];

    self.gk_pushDelegate = self;
}

- (void)setupUI {
    self.gk_navigationBar.hidden = YES;
    //左面view
    EYFindViewController *findViewController = [[EYFindViewController alloc] init];
    findViewController.view.frame = EYScreenBounds;
    EYNavigationController *findNaviController = [[EYNavigationController alloc] initWithRootViewController:findViewController];
    [self.scrollView addSubview:findNaviController.view];
    [self addChildViewController:findNaviController];
    
    //主 view
    EYTabBarController * tabbarController = [[EYTabBarController alloc] init];
    tabbarController.view.frame = CGRectMake(EYScreenWidth, 0, EYScreenWidth, EYScreenHeight);
    tabbarController.delegate = self;
    [self.scrollView addSubview:tabbarController.view];
    [self addChildViewController:tabbarController];

    self.scrollView.contentSize = CGSizeMake(EYScreenWidth * self.childViewControllers.count, EYScreenHeight);
    //默认展示主view
    [self.scrollView setContentOffset:CGPointMake(EYScreenWidth, 0)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // 设置左滑push代理
    self.gk_pushDelegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    // 清空左滑push代理
    self.gk_pushDelegate = nil;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {//控制EYTabBarController的方向
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - 懒加载
- (UIScrollView *)scrollView {
    if (nil == _scrollView) {
        EYScrollView * scrollView = [[EYScrollView alloc] initWithFrame:EYScreenBounds];
        if (@available(iOS 11.0, *)) {
            scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.bounces = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        [self.view addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}

#pragma mark - GKViewControllerPushDelegate
- (void)pushToNextViewController {
    if (self.indexType == EYTabBarViewTypeHome) {
        EYHomeWorksViewController * vc = [[EYHomeWorksViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - EYTabBarControllerDelegate
- (void)tabBarControllerDidSelectedIndex:(EYTabBarViewType)index {
    self.indexType = index;
    if (index == EYTabBarViewTypeHome) {
        self.scrollView.scrollEnabled = YES;
    } else if (index == EYTabBarViewTypePlus) {

    } else {
        self.scrollView.scrollEnabled = NO;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    EYLog(@"底部的 scrollView已经结束拖拽--");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat offsetX = scrollView.contentOffset.x;
//     EYLog(@"底部的 scrollView已经滚动了--scrollView 的偏移位置%f", offsetX);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (!EYSCREENSIZE_IS_IPhoneX_All) {
        [UIApplication sharedApplication].statusBarHidden = NO;
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    // EYLog(@"底部的 scrollView将会开始减速==%@", NSStringFromCGPoint(scrollView.contentOffset));
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
     EYLog(@"底部的 scrollView已经结束减速--%@", NSStringFromCGPoint(scrollView.contentOffset));
    CGFloat x = scrollView.contentOffset.x;
    if (x == EYScreenWidth) {
        if (!EYSCREENSIZE_IS_IPhoneX_All) {
            [UIApplication sharedApplication].statusBarHidden = YES;
        }
    } else {

    }
}

@end
