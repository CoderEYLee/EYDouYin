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

@interface EYRootViewController () <UIScrollViewDelegate, GKViewControllerPushDelegate, EYTabBarControllerDelegate, UITabBarControllerDelegate>

@property (assign, nonatomic) EYTabBarViewType selecetdIndex;

@end

@implementation EYRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置左滑代理
    self.gk_pushDelegate = self;
    
    // 2.初始化界面
    [self setupUI];
}

// 初始化界面
- (void)setupUI {
    self.gk_navigationBar.hidden = YES;
    
    EYTabBarController *tabbarController = [[EYTabBarController alloc] init];
    tabbarController.view.frame = self.view.bounds;
    tabbarController.delegate = self;
    [self addChildViewController:tabbarController];
    [self.view addSubview:tabbarController.view];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {//控制EYTabBarController的方向
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - 懒加载

#pragma mark - GKViewControllerPushDelegate
- (void)pushToNextViewController {
    if (self.selecetdIndex == EYTabBarViewTypeHome) {
        EYHomeWorksViewController *vc = [[EYHomeWorksViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - EYTabBarControllerDelegate
- (void)tabBarControllerDidSelectedIndex:(EYTabBarViewType)index {
    
    if (index == EYTabBarViewTypeHome) {
        self.selecetdIndex = index;
    } else if (index == EYTabBarViewTypePlus) {
        
    } else {
        self.selecetdIndex = index;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // EYLog(@"底部的 scrollView已经结束拖拽--");
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
    //EYLog(@"底部的 scrollView已经结束减速--%@", NSStringFromCGPoint(scrollView.contentOffset));
    CGFloat x = scrollView.contentOffset.x;
    if (x == EYScreenWidth) {
        if (!EYSCREENSIZE_IS_IPhoneX_All) {
            [UIApplication sharedApplication].statusBarHidden = YES;
        }
    } else {

    }
}

- (void)dealloc {
    // 清空左滑代理
    self.gk_pushDelegate = nil;
}

@end
