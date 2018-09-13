//
//  EYTabBarController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/22.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYTabBarController.h"
#import "EYHomeViewController.h"
#import "EYLikeViewController.h"
#import "EYSendViewController.h"
#import "EYMessageViewController.h"
#import "EYMeViewController.h"
#import "EYNavigationController.h"
#import "EYTabBarView.h"
#import "EYRootViewController.h"

@interface EYTabBarController () <EYTabBarViewDelegate>

@end

@implementation EYTabBarController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViewController];
    [self setupTabBar];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    for (UIView * subView in self.tabBar.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {//移除最上层的UITabBarButton(界面出现之后才会取到)
            [subView removeFromSuperview];
        }
    }
}

#pragma mark - 初始化 UI
- (void)setupViewController {
    NSString * jsonName = @"TabBar.json";
    NSArray *array = jsonName.ey_loadLocalFile;
    
    for (NSDictionary * dictionary in array) {
        UIViewController * viewController = [[NSClassFromString(dictionary[@"className"]) alloc] init];
        if ([dictionary[@"needNavi"] boolValue]) {
            [self addChildViewController:[[EYNavigationController alloc] initWithRootViewController:viewController]];
        } else {
            [self addChildViewController:viewController];
        }
    }
}

- (void)setupTabBar {
    // 1.设置 tabbar
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    
    // 2.创建自定义的 view 添加到 tabBar
    EYTabBarView * tabBarView = [EYTabBarView tabBarView];
    tabBarView.frame = CGRectMake(0, 0, EYScreenWidth, EYTabBarHeight);
    tabBarView.delegate = self;
    
    //添加到tabBar上, 但是系统的UITabBarButton会覆盖到tabBarView的上层,需要移除掉
    [self.tabBar addSubview:tabBarView];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft;
}

#pragma mark - EYTabBarViewDelegate
- (void)tabBarView:(EYTabBarView *)tabBarView didSelectedIndex:(NSInteger)index {
    EYLog(@"当前点击的 index--%ld", index);
    EYNavigationController * homeNaviViewController = self.viewControllers.firstObject;
    EYHomeViewController *homeViewController = (EYHomeViewController *)homeNaviViewController.viewControllers.firstObject;
    EYRootViewController * rootViewController = (EYRootViewController *)EYKeyWindowRootViewController;
    if (index == EYTabBarViewTypeHome) {
        if (homeViewController.type == EYHomeViewControllerButtonTypeRecommend) {
            tabBarView.backgroundColor = [UIColor clearColor];
        } else {
            tabBarView.backgroundColor = [UIColor blackColor];
        }
        rootViewController.scrollView.scrollEnabled = YES;
    } else {//禁止滚动
        tabBarView.backgroundColor = [UIColor blackColor];
        rootViewController.scrollView.scrollEnabled = NO;
    }
    
    if (index == EYTabBarViewTypePlus) {//弹出发布界面
        [self presentViewController:[[EYSendViewController alloc] init] animated:YES completion:nil];
    } else {
        self.selectedIndex = index;
    }
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
