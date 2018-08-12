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
        UIViewController * viewController = [[NSClassFromString(dictionary[@"className"]) alloc] init];
        if ([dictionary[@"needNavi"] boolValue]) {
            [self addChildViewController:[[EYNavigationController alloc] initWithRootViewController:viewController]];
        } else {
            [self addChildViewController:viewController];
        }
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

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

#pragma mark - EYTabBarViewDelegate
- (void)tabBarView:(EYTabBarView *)tabBarView didSelectedIndex:(NSInteger)index
{
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
