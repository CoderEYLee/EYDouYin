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
#import "EYHomeViewController.h"
#import "EYMineViewController.h"

@interface EYRootViewController () <UIScrollViewDelegate, GKViewControllerPushDelegate, EYTabBarControllerDelegate, UITabBarControllerDelegate>

@property (weak, nonatomic) EYTabBarController *tabBarVC;

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
    
    EYTabBarController *tabBarVC = [[EYTabBarController alloc] init];
    self.tabBarVC = tabBarVC;
    tabBarVC.delegate = self;
    [self addChildViewController:tabBarVC];
    [self.view addSubview:tabBarVC.view];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {//控制EYTabBarController的方向
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - GKViewControllerPushDelegate
- (void)pushToNextViewController {
    if (self.selecetdIndex == EYTabBarViewTypeHome) {
        NSString *user_id = self.tabBarVC.homeVC.currentPlayViewController.videoModel.user_id;
        EYLog(@"123456==%@", user_id);
        
        EYMineViewController *vc = [[EYMineViewController alloc] init];
        vc.jumpType = EYJumpTypeHomeToMe;
        vc.user_id = user_id;
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

- (void)dealloc {
    // 清空左滑代理
    self.gk_pushDelegate = nil;
}

@end
