//
//  AppDelegate.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/22.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "AppDelegate.h"
#import "EYRootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 1.创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    // 2.设置根控制器
    self.window.rootViewController = [[EYRootViewController alloc] init];
    
    // 3.显示窗口
    [self.window makeKeyAndVisible];

    EYLog(@"1111111--->程序启动了");

//    [NSThread sleepForTimeInterval:3];

    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    EYLog(@"222222222--->启动/后台回来");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    EYLog(@"333333333333--->程序准备进入后台");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    EYLog(@"444444444444--->程序已经进入后台");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    EYLog(@"555555555555--->程序将会进入前台");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    EYLog(@"6666666666666--->程序被杀了");
}

@end
