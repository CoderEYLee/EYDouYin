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
#import "EYMeViewController.h"

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
//    [self.currentPlayViewController pausePlay];
    
    EYMeViewController *vc = [[EYMeViewController alloc] init];
    vc.jumpType = EYJumpTypeHomeToMe;
    [self.navigationController pushViewController:vc animated:YES];
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

- (void)dealloc {
    // 清空左滑代理
    self.gk_pushDelegate = nil;
}

@end
