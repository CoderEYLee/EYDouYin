//
//  AppDelegate.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/22.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "AppDelegate.h"
#import "EYLanguageTool.h"
#import "EYNavigationController.h"
#import <AFNetworkActivityIndicatorManager.h>
#import "EYRootViewController.h"
#import <AvoidCrash.h>

//#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h> // Only if you have Flutter Plugins

@interface AppDelegate () <WeiboSDKDelegate>

@end

@implementation AppDelegate

#pragma mark - Life Cycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 1.语言
    [self testMutableArray];

    // 2.设置启动页面
    [self launchViewController];
    
    // 3.初始化其他信息
    [self setupOtherInfo];

    //启动图时间
    sleep(2);

    EYLog(@"AppDelegate--1111111--->程序启动了");

    return YES;
}

//2.1算法测试(可变数组)
- (void)testMutableArray {
    
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    // 暂时没有用到, 微博是用的是网页的授权
    return [WeiboSDK handleOpenURL:url delegate:self];
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

#pragma mark - 程序启动设置
// 1.语言
- (void)setupLanguage {
    [EYLanguageTool setDefaultAppLanguage];
}

// 2.设置启动页面
- (void)launchViewController {
    
    self.window = [[UIWindow alloc] initWithFrame:EYScreenBounds];
    self.window.backgroundColor = EYColorTheme;
    
    EYRootViewController *rootVC= [[EYRootViewController alloc] init];
    EYNavigationController *navi = [[EYNavigationController alloc] initWithRootViewController:rootVC];
    navi.gk_openScrollLeftPush = YES;
    
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
}

//3.初始化其他信息
- (void)setupOtherInfo {
    [self setupAvoidCrash];
    //2.1 键盘
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.shouldResignOnTouchOutside = YES; // 点击背景收起键盘，默认NO
    manager.enableAutoToolbar = NO; // IQKeyboardManager提供的键盘上面默认会有“前一个”“后一个”“完成”这样的辅助按钮。如果你不需要，可以将这个enableAutoToolbar属性设置为NO，这样就不会显示了。默认YES
    
    //2.2 提示框
    [EYProgressHUD setMinimumDismissTimeInterval:1.5];
    [EYProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];//后面的大背景是透明色
    //    [EYProgressHUD setInfoImage:[UIImage imageNamed:@""]];//提示的图片
    //    [EYProgressHUD setImageViewSize:CGSizeMake(0, -1)];//提示的图片大小
    [EYProgressHUD setBackgroundColor:EYColorRGBHexAlpha(0x000000, 0.5)];// 弹出框背景颜色
    [EYProgressHUD setCornerRadius:5.0];
    [EYProgressHUD setForegroundColor:EYColorWhite];//进度&文字颜色
    [EYProgressHUD setFont:EYSizeFont14];//字体
    [EYProgressHUD setRingThickness:3.0];// 进度条的宽度
    
    // 2.3 设置导航条
    [[GKNavigationBarConfigure sharedInstance] setupCustomConfigure:^(GKNavigationBarConfigure *configure) {
        configure.backgroundColor = EYColorClear;
        configure.titleColor = EYColorWhite;
        configure.titleFont = EYSizeFont17;
        configure.backStyle = GKNavigationBarBackStyleWhite;
        configure.gk_navItemRightSpace = 20.0;
        
        configure.gk_translationX = 15;
        configure.gk_translationY = 20;
        configure.gk_scaleX = 0.90;
        configure.gk_scaleY = 0.92;
    }];
    
    // 2.4 Bugly
    // [Bugly startWithAppId:Bugly_APP_ID];
    
    // 2.5 iflyMSC
    //[IFlyDebugLog setShowLog:NO];//关闭log
    //[IFlySpeechUtility createUtility:[NSString stringWithFormat:@"appid=%@",IflyMSC_APP_ID]];
    
    // 2.6 SDWebImage
    SDImageCacheConfig *imageCacheConfig = [SDImageCacheConfig defaultCacheConfig];
    //1.图片磁盘最大过期时间
    imageCacheConfig.maxDiskAge = 60 * 60 * 24 * 7;
    //2.图片磁盘最大占用 100M
    imageCacheConfig.maxDiskSize = 1024 * 1024 * 100;
    // 最大缓存个数
    imageCacheConfig.maxMemoryCount = 20;
    // 最大内存消耗 50M
    imageCacheConfig.maxMemoryCost = 1024 * 1024 * 50;
    
    // 2.7 腾讯播放器 设置LOG信息
    [TXLiveBase setLogLevel:LOGLEVEL_NULL];
    [TXLiveBase setConsoleEnabled:NO];
    
    // 2.8Flutter初始化
//    self.flutterEngine = [[FlutterEngine alloc] initWithName:@"io.flutter" project:nil];
    
    // 2.9滚动条与分割线
    UIScrollView.appearance.showsHorizontalScrollIndicator = NO;
    UIScrollView.appearance.showsVerticalScrollIndicator= NO;
    UITableView.appearance.separatorStyle = UITableViewCellSeparatorStyleNone;
}

///2.1初始化AvoidCrash
- (void)setupAvoidCrash {
    [AvoidCrash makeAllEffective];
    NSArray *noneSelClassStrings = @[@"NSNull", @"NSNumber", @"NSString", @"NSDictionary", @"NSArray"];
    [AvoidCrash setupNoneSelClassStringsArr:noneSelClassStrings];
    
    //监听通知:AvoidCrashNotification, 获取AvoidCrash捕获的崩溃日志的详细信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:AvoidCrashNotification object:nil];
}

#pragma mark - 通知
- (void)dealwithCrashMessage:(NSNotification *)noti {
    NSDictionary *info = noti.userInfo;
    NSString *errorReason = [NSString stringWithFormat:@"【ErrorReason】%@======\n【ErrorPlace】%@======\n【DefaultToDo】%@======【ErrorName】%@======", info[@"errorReason"], info[@"errorPlace"], info[@"defaultToDo"], info[@"errorName"]];
    NSArray *callStack = info[@"callStackSymbols"];
    
    //[[TTBuglyManager manager] reportExceptionWithCategory:3 name:@"App崩溃" reason:errorReason callStack:callStack extraInfo:nil terminateApp:NO];
}

#pragma mark - Private Methods
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
                EYLog(@"有网络");
                break;
            }
            default: break;
        }
    }];

    // 开始监听
    [manager.reachabilityManager startMonitoring];
}

// 收到内存警告
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    EYLog(@"收到内存警告");
    
    //1.取消所有操作
    [[SDWebImageManager sharedManager] cancelAll];
    
    //2.清空缓存（内存）
    [[SDImageCache sharedImageCache] clearMemory];
    
    //3.清空磁盘图片
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        EYLog(@"收到内存警告清理磁盘缓存结束");
    }];
}

#pragma mark - WeiboSDKDelegate

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    EYLog(@"didReceiveWeiboRequest==%@", request);
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    EYLog(@"didReceiveWeiboResponse==%@", response);
}

@end
