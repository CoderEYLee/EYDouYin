//
//  EYTabBarController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/22.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYTabBarController.h"
#import "EYHomeViewController.h"
#import "EYFollowViewController.h"
#import "EYSendViewController.h"
#import "EYMessageViewController.h"
#import "EYMeViewController.h"
#import "EYNavigationController.h"
#import "EYRootViewController.h"

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
    NSArray *array = @"TabBar.json".ey_loadLocalJSONFile;

    NSMutableArray *arrayM = [NSMutableArray array];

    for (NSDictionary * dictionary in array) {
        UIViewController *viewController = [[NSClassFromString(dictionary[@"className"]) alloc] init];
        if ([dictionary[@"needNavi"] boolValue]) {
            [arrayM addObject:[[EYNavigationController alloc] initWithRootViewController:viewController]];
        } else {
            [arrayM addObject:viewController];
        }
    }

    self.viewControllers = arrayM;
}

- (void)setupTabBar {
    // 1.设置 tabbar
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundColor:EYColorClear];

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
        [self presentViewController:[[EYSendViewController alloc] init] animated:YES completion:nil];
        return NO;
    }
    
    // 选中对应下标
    self.selectedIndex = selectedIndex;
    
    //返回状态
    return YES;
    
//
//    if (EYSCREENSIZE_IS_IPhoneX_All) {
//        if (selectedIndex == EYTabBarViewTypePlus) {//弹出发布界面
//            [self presentViewController:[[EYSendViewController alloc] init] animated:YES completion:nil];
//        } else {
//            self.selectedIndex = selectedIndex;
//        }
//    } else {
//        EYNavigationController * homeNavi = self.viewControllers.firstObject;
//        EYHomeViewController *homeVC = (EYHomeViewController *)homeNavi.viewControllers.firstObject;
//
//        if (selectedIndex == EYTabBarViewTypeHome) {
//            if (!EYSCREENSIZE_IS_IPhoneX_All) {
//                if (homeVC.type == EYHomeViewControllerButtonTypeRecommend) {
//                    tabBarView.backgroundColor = [UIColor clearColor];
//                } else {
//                    tabBarView.backgroundColor = [UIColor blackColor];
//                }
//            }
//            self.selectedIndex = selectedIndex;
//        } else if (selectedIndex == EYTabBarViewTypePlus) {//弹出发布界面
//            [self presentViewController:[[EYSendViewController alloc] init] animated:YES completion:nil];
//        } else {//禁止滚动
//            tabBarView.backgroundColor = [UIColor blackColor];
//            self.selectedIndex = selectedIndex;
//            [UIApplication sharedApplication].statusBarHidden = NO;
//        }
//    }
//
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
