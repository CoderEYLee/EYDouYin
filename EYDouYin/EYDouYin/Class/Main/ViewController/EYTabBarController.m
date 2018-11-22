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
#import "EYRootViewController.h"
#import "EYTabBar.h"

typedef NS_ENUM(NSInteger, EYTabBarStyle) {
    EYTabBarStyleCustomView = 0, //自定义 view 充当 tabBar
    EYTabBarStyleCustomTabBar,//自定义 tabBar 充当 tabBar
};

@interface EYTabBarController () <EYTabBarViewDelegate>

@property (assign, nonatomic) EYTabBarStyle style;

@end

@implementation EYTabBarController
@dynamic delegate;
#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    if (EYSCREENSIZE_IS_IPhoneX_All) {
        self.style = EYTabBarStyleCustomTabBar;
    } else {
        self.style = EYTabBarStyleCustomView;
    }
    
    [self setupViewController];
    [self setupTabBar];
}

#pragma mark - 初始化 UI
- (void)setupViewController {
    NSString * jsonName = @"TabBar.json";
    NSArray *array = jsonName.ey_loadLocalJSONFile;

    NSMutableArray *arrayM = [NSMutableArray array];

    for (NSDictionary * dictionary in array) {
        UIViewController * viewController = [[NSClassFromString(dictionary[@"className"]) alloc] init];
        if (self.style == EYTabBarStyleCustomTabBar) {
            viewController.title = dictionary[@"title"];
        }
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

    if (self.style == EYTabBarStyleCustomView) {
#pragma mark - 方式一
        // 2.创建自定义的 view 添加到 tabBar
        EYTabBarView * tabBarView = [EYTabBarView tabBarView];
        tabBarView.frame = CGRectMake(0, 0, EYScreenWidth, EYTabBarHeight);
        tabBarView.delegate = self;
        [self.tabBar addSubview:tabBarView];
    } else {
#pragma mark - 方式二
        EYTabBar *tabBar = [[EYTabBar alloc] init];
        [self setValue:tabBar forKeyPath:@"tabBar"];
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft;
}

#pragma mark - EYTabBarViewDelegate
- (void)tabBarView:(EYTabBarView *)tabBarView didSelectedIndex:(NSInteger)index {
    EYLog(@"当前点击的 index--%ld", (long)index);

    EYNavigationController * homeNavi = self.viewControllers.firstObject;
    EYHomeViewController *homeVC = (EYHomeViewController *)homeNavi.viewControllers.firstObject;

    if (index == EYTabBarViewTypeHome) {
        if (homeVC.type == EYHomeViewControllerButtonTypeRecommend) {
            tabBarView.backgroundColor = [UIColor clearColor];
        } else {
            tabBarView.backgroundColor = [UIColor blackColor];
        }
        self.selectedIndex = index;
    } else if (index == EYTabBarViewTypePlus) {//弹出发布界面
        [self presentViewController:[[EYSendViewController alloc] init] animated:YES completion:nil];
    } else {//禁止滚动
        tabBarView.backgroundColor = [UIColor blackColor];
        self.selectedIndex = index;
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarControllerDidSelectedIndex:)]) {
        [self.delegate tabBarControllerDidSelectedIndex:index];
    }
}

#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSUInteger index = [tabBar.items indexOfObject:item];
    EYLog(@"%@--didSelectItem--%@--%lu", tabBar, item, index);
    switch (index) {
        case 0: {
            [tabBar setBackgroundColor:[UIColor clearColor]];
        }
            break;
        case 1:
        case 3:
        case 4: {
            [tabBar setBackgroundColor:[UIColor blackColor]];
        }
            break;
        default:
            break;
    }
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
