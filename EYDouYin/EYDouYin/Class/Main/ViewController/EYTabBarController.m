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

@interface EYTabBarController () <EYTabBarViewDelegate>

@end

@implementation EYTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [self setupUI];
}

- (void)setupUI
{
    [self setupViewController];
    [self setupTabBar];
}

- (void)setupViewController
{
    NSString * jsonName = @"TabBar.json";
    NSArray *array = jsonName.ey_loadLocalFile;
    
    for (NSDictionary * dictionary in array) {
        [self addChildViewController:[[NSClassFromString(dictionary[@"className"]) alloc] init] title:dictionary[@"title"]];
    }
}

- (void)setupTabBar
{
//    EYTabBar *tabBar = [[EYTabBar alloc] init];
//    tabBar.delegate = self;// ① 不用写
//    tabBar.delegate = nil; // ② 下面那句话会将这句话覆盖掉
//    [self setValue:tabBar forKeyPath:@"tabBar"];//这句话会将 自己的控件 tabBar 的 delegate 设置为自己 相当于①
    //    [[UITabBar appearance] setShadowImage:[UIImage new]];
    //    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    
    // 1.隐藏系统自带的 tabBar
    [[UITabBar appearance] setHidden:YES];
    
    // 2.创建自定义的 view 充当 tabBar
    EYTabBarView * tabBarView = [EYTabBarView tabBarView];
    tabBarView.frame = CGRectMake(0, EYScreenHeight-49, EYScreenWidth, 49);
    tabBarView.delegate = self;
    [self.view addSubview:tabBarView];
}

/**
 添加一个子控制器

 @param childViewController 子控制器
 @param title 标题
 */
- (void)addChildViewController:(UIViewController *)childViewController title:(NSString *)title
{
    // 设置子控制器的文字
    childViewController.tabBarItem.title = title;
    
    childViewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -20);
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [childViewController.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [childViewController.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    EYNavigationController *nav = [[EYNavigationController alloc] initWithRootViewController:childViewController];
    // 添加为子控制器
    [self addChildViewController:nav];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

#pragma mark - EYTabBarViewDelegate
- (void)tabBarView:(EYTabBarView *)tabBarView didSelectedIndex:(NSInteger)index
{
//    NSLog(@"tabBarView--%@--didSelectedIndex--%ld", tabBarView, index);
    NSLog(@"didSelectedIndex--%ld", index);
    if (index == EYTabBarViewTypePlus) {
        [self presentViewController:[[EYSendViewController alloc] init] animated:YES completion:nil];
    } else {
        self.selectedIndex = index;
    }
}

#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    EYLog(@"%@--didSelectItem--%@", tabBar, item);
}

- (void)tabBar:(UITabBar *)tabBar willBeginCustomizingItems:(NSArray<UITabBarItem *> *)items
{
    EYLog(@"willBeginCustomizingItems--%@", items);
}
- (void)tabBar:(UITabBar *)tabBar didBeginCustomizingItems:(NSArray<UITabBarItem *> *)items
{
    EYLog(@"didBeginCustomizingItems--%@", items);
}
- (void)tabBar:(UITabBar *)tabBar willEndCustomizingItems:(NSArray<UITabBarItem *> *)items changed:(BOOL)changed
{
    EYLog(@"willEndCustomizingItems--%@", items);
}
- (void)tabBar:(UITabBar *)tabBar didEndCustomizingItems:(NSArray<UITabBarItem *> *)items changed:(BOOL)changed
{
    EYLog(@"didEndCustomizingItems--%@", items);
}

@end
