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

#define EYScrollViewWidthScale 0.0

@interface EYRootViewController () <UIScrollViewDelegate>

@property (weak, nonatomic, readwrite) UIScrollView * scrollView;

@property (weak, nonatomic) UIView * homeWorksView;


@end

@implementation EYRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    //左面view
    EYFindViewController * findViewController = [[EYFindViewController alloc] init];
    findViewController.view.frame = EYScreenBounds;
    EYNavigationController *findNaviController = [[EYNavigationController alloc] initWithRootViewController:findViewController];
    [self.scrollView addSubview:findNaviController.view];
    [self addChildViewController:findNaviController];
    
    //主 view
    EYTabBarController * tabbarController = [[EYTabBarController alloc] init];
    tabbarController.view.frame = CGRectMake(EYScreenWidth, 0, EYScreenWidth, EYScreenHeight);
    [self.scrollView addSubview:tabbarController.view];
    [self addChildViewController:tabbarController];

    self.scrollView.contentSize = CGSizeMake(EYScreenWidth * (2 + EYScrollViewWidthScale), EYScreenHeight);
    //默认展示主view
    [self.scrollView setContentOffset:CGPointMake(EYScreenWidth, 0)];

    EYHomeWorksViewController * homeWorksViewController = [[EYHomeWorksViewController alloc] init];
    UIView * homeWorksView = homeWorksViewController.view;
    homeWorksView.frame = CGRectMake(EYScreenWidth, 0, EYScreenWidth, EYScreenHeight);
    [self.view addSubview:homeWorksView];
    [self addChildViewController:homeWorksViewController];
    self.homeWorksView = homeWorksView;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {//控制EYTabBarController的方向
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - 懒加载
- (UIScrollView *)scrollView {
    if (nil == _scrollView) {
        UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:EYScreenBounds];
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

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat minOffsetX = EYScreenWidth * EYScrollViewWidthScale  * 0.5;
    CGFloat offsetX = scrollView.contentOffset.x - EYScreenWidth;
    EYLog(@"底部的 scrollView已经结束拖拽--scrollView 的偏移位置%f最小偏移大小%f", offsetX, minOffsetX);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
     EYLog(@"底部的 scrollView已经滚动了--scrollView 的偏移位置%f", offsetX);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    // EYLog(@"底部的 scrollView将会开始减速==%@", NSStringFromCGPoint(scrollView.contentOffset));
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
     EYLog(@"底部的 scrollView已经结束减速--%@", NSStringFromCGPoint(scrollView.contentOffset));
    CGFloat x = scrollView.contentOffset.x;
    if (x == EYScreenWidth) {
        [UIApplication sharedApplication].statusBarHidden = YES;
    } else {

    }
}

@end
