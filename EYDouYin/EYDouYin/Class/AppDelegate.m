//
//  AppDelegate.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/22.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "AppDelegate.h"
#import "EYNavigationController.h"
#import <AFNetworkActivityIndicatorManager.h>
#import <AVKit/AVKit.h>

@interface AppDelegate ()

@property (weak, nonatomic, readwrite) EYRootViewController *rootViewController;

@end

@implementation AppDelegate

#pragma mark - Life Cycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    EYRootViewController *rootVC= [[EYRootViewController alloc] init];
    self.window.rootViewController = [[EYNavigationController alloc] initWithRootViewController:rootVC];
    self.rootViewController = rootVC;

    [NSThread sleepForTimeInterval:2];

    EYLog(@"1111111--->程序启动了");

    [self setUpAppLanguage];

    [self handleAFNetConnect];

    [self openAnimation];

    [self.window makeKeyAndVisible];

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

#pragma mark - Public Methods
#pragma mark - Private Methods
// 初始化 app 语言环境
- (void)setUpAppLanguage {
    if ([EYUserDefaults stringForKey:EYAppLanguage].length == 0) {
        NSString * language = NSLocale.preferredLanguages.firstObject;
        if (![language hasPrefix:@"en"]) {
            language = @"zh-Hans";
        }
        [EYUserDefaults setObject:language forKey:EYAppLanguage];
    }
}
// AFN 的网络监控
- (void)handleAFNetConnect {
    // 开启网络指示器
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];

    // 基准网站
    NSURL *url = [NSURL URLWithString:@"http://baidu.com"];

    // 监听结果回调
    // AFHTTPSessionManager : AFURLSessionManager : NSObject
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];

    NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusNotReachable: {
                [operationQueue setSuspended:YES]; //暂停所有的网络请求
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                [operationQueue setSuspended:NO];   //恢复所有的网络请求
                NSLog(@"有网络");
                break;
            }
            default: break;
        }
    }];

    // 开始监听
    [manager.reachabilityManager startMonitoring];
}

-(void)openAnimation {
    NSBundle *bundle = [NSBundle mainBundle];
    if(bundle != nil) {
        NSString *moviePath = [bundle pathForResource:@"OpenAnimation" ofType:@"mp4"];
        if (moviePath) {
            AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
            playerViewController.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:moviePath]];
            playerViewController.videoGravity = AVLayerVideoGravityResizeAspect;

            playerViewController.view.userInteractionEnabled = NO;
            playerViewController.showsPlaybackControls = NO;

            UIViewController *lastRootVC = self.window.rootViewController;
            [EYNotificationCenter addObserverForName:AVPlayerItemDidPlayToEndTimeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
                self.window.rootViewController = lastRootVC;
            }];

            self.window.rootViewController = playerViewController;

            // 播放
            [playerViewController.player play];
        }
    }
}

#pragma mark - Override Methods
#pragma mark - Net Work
#pragma mark - DataSource
#pragma mark - Delegate
#pragma mark - Getters & Setters

@end
