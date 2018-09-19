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

@interface EYRootViewController () <UIScrollViewDelegate>

@property (weak, nonatomic, readwrite) UIScrollView * scrollView;

@end

@implementation EYRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:EYScreenBounds];
    scrollView.contentSize = CGSizeMake(EYScreenWidth * 2.2, EYScreenHeight);
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
    self.scrollView = scrollView;
    
    //左面view
    EYFindViewController * findViewController = [[EYFindViewController alloc] init];
    findViewController.view.frame = CGRectMake(0, 0, EYScreenWidth, EYScreenHeight);
    EYNavigationController *findNaviController = [[EYNavigationController alloc] initWithRootViewController:findViewController];
    [scrollView addSubview:findNaviController.view];
    [self addChildViewController:findNaviController];
    
    //主 view
    EYTabBarController * tabbarController = [[EYTabBarController alloc] init];
    tabbarController.view.frame = CGRectMake(EYScreenWidth, 0, EYScreenWidth, EYScreenHeight);
    [scrollView addSubview:tabbarController.view];
    [self addChildViewController:tabbarController];

    //默认展示主view
    [scrollView setContentOffset:CGPointMake(EYScreenWidth, 0)];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {//控制EYTabBarController的方向
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGPoint point = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    CGFloat offsetX = scrollView.contentOffset.x;
    EYLog(@"底部的 scrollView已经结束拖拽--手势的偏移位置%@scrollView 的偏移位置%@", NSStringFromCGPoint(point), NSStringFromCGPoint(scrollView.contentOffset));

    if (offsetX >= EYScreenWidth * 1.1) {
        // UIViewAnimationOptionLayoutSubviews
        // UIViewAnimationOptionAllowUserInteraction
        EYHomeWorksViewController * vc = [[EYHomeWorksViewController alloc] init];
        [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            [self.navigationController pushViewController:vc animated:YES];
        } completion:nil];
    } else {

    }
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
