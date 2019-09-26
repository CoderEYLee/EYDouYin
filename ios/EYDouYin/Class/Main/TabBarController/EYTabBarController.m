//
//  EYTabBarController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/22.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYTabBarController.h"
#import "EYNavigationController.h"
#import "EYHomeViewController.h"
#import "EYFollowViewController.h"
#import "EYSendViewController.h"
#import "EYMessageViewController.h"
#import "EYMineViewController.h"

@interface EYTabBarController () <EYTabBarViewDelegate>

@end

@implementation EYTabBarController
@dynamic delegate;
#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViewController];
    [self setupTabBar];
}

#pragma mark - 初始化 UI
- (void)setupViewController {
    NSMutableArray *arrayM = [NSMutableArray array];
    
    //0.首页
    EYHomeViewController *homeVC = [[EYHomeViewController alloc] init];
    [arrayM addObject:[[EYNavigationController alloc] initWithRootViewController:homeVC]];
    self.homeVC = homeVC;
    
    //1.关注
    EYFollowViewController *followVC = [[EYFollowViewController alloc] init];
    [arrayM addObject:[[EYNavigationController alloc] initWithRootViewController:followVC]];
    
    //2.占位控制器
    UIViewController *placeholderVC = [[UIViewController alloc] init];
    [arrayM addObject:[[EYNavigationController alloc] initWithRootViewController:placeholderVC]];
        
    //3.消息
    EYMessageViewController *messageVC = [[EYMessageViewController alloc] init];
    [arrayM addObject:[[EYNavigationController alloc] initWithRootViewController:messageVC]];

    //4.我
    EYMineViewController *mineVC = [[EYMineViewController alloc] init];
    [arrayM addObject:[[EYNavigationController alloc] initWithRootViewController:mineVC]];
        
    self.viewControllers = arrayM;
}

- (void)setupTabBar {
    // 1.设置 tabbar
    [self.tabBar setShadowImage:[UIImage new]];
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBar setBackgroundColor:EYColorClear];

    // 2.创建自定义的 view 添加到 tabBar
    EYTabBarView *tabBarView = [EYTabBarView tabBarView];
    tabBarView.delegate = self;
    [self.tabBar addSubview:tabBarView];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - EYTabBarViewDelegate
- (BOOL)tabBarView:(EYTabBarView *)tabBarView shouldSelectedIndex:(NSUInteger)selectedIndex {
    EYLog(@"当前点击的 index--%ld", (long)selectedIndex);
    
    //回调代理
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarControllerDidSelectedIndex:)]) {
        [self.delegate tabBarControllerDidSelectedIndex:selectedIndex];
    }
    
    if (selectedIndex == EYTabBarViewTypePlus) {//弹出发布界面
//        [[TTFFmpegManager manager] addVideoSubtitle];
//        return NO;
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"min_time"] = @(0.5);
        parameters[@"max_time"] = @(600.5);
        [[TTFFmpegManager manager] selectVideoWithParameters:parameters];
//        [self presentViewController:[[EYSendViewController alloc] init] animated:YES completion:nil];
        return NO;
    }
    
    // 选中对应下标
    self.selectedIndex = selectedIndex;
    
    //返回状态
    return YES;
}

#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    EYLog(@"%@--didSelectItem--%@", tabBar, item);
}

- (void)tabBar:(UITabBar *)tabBar willBeginCustomizingItems:(NSArray<UITabBarItem *> *)items {
    EYLog(@"willBeginCustomizingItems--%@", items);
}

- (void)tabBar:(UITabBar *)tabBar didBeginCustomizingItems:(NSArray<UITabBarItem *> *)items {
    EYLog(@"didBeginCustomizingItems--%@", items);
}

- (void)tabBar:(UITabBar *)tabBar willEndCustomizingItems:(NSArray<UITabBarItem *> *)items changed:(BOOL)changed {
    EYLog(@"willEndCustomizingItems--%@", items);
}

- (void)tabBar:(UITabBar *)tabBar didEndCustomizingItems:(NSArray<UITabBarItem *> *)items changed:(BOOL)changed {
    EYLog(@"didEndCustomizingItems--%@", items);
}

@end
