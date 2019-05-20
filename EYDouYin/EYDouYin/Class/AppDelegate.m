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
//#import <AVKit/AVKit.h>

@interface AppDelegate ()

@property (weak, nonatomic, readwrite) EYRootViewController *rootViewController;

@end

@implementation AppDelegate

#pragma mark - Life Cycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 1.键盘设置
    [self setupKeyboard];

    // 2.SVProgressHUD
    [self setupSVProgressHUD];

    // 3.语言
    [self setupLanguage];

    // 4.设置导航条
    [self setupGKNavigationBar];

    // 5.Bugly
    [self setupBugly];

    // 6.iflyMSC
    [self setupIflyMSC];

    // 7.SDWebImage
    [self setupSDWebImage];

//    // [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];

    // 8.设置启动页面
    [self launchViewController];

    //启动图时间
    sleep(2);

    EYLog(@"AppDelegate--1111111--->程序启动了");
    
//    [self openAnimation];

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

#pragma mark - 程序启动设置
// 1.键盘设置
- (void)setupKeyboard {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.shouldResignOnTouchOutside = YES; // 点击背景收起键盘，默认NO
    manager.enableAutoToolbar = NO; // IQKeyboardManager提供的键盘上面默认会有“前一个”“后一个”“完成”这样的辅助按钮。如果你不需要，可以将这个enableAutoToolbar属性设置为NO，这样就不会显示了。默认YES
}

// 2.SVProgressHUD
- (void)setupSVProgressHUD {
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];//后面的大背景是透明色
//    [SVProgressHUD setInfoImage:[UIImage imageNamed:@""]];//提示的图片
//    [SVProgressHUD setImageViewSize:CGSizeMake(0, -1)];//提示的图片大小
    [SVProgressHUD setBackgroundColor:EYColorRGBHexAlpha(0x000000, 0.5)];// 弹出框背景颜色
    [SVProgressHUD setCornerRadius:5.0];
    [SVProgressHUD setForegroundColor:EYColorWhite];//进度&文字颜色
    [SVProgressHUD setFont:EYSizeFont14];//字体
    [SVProgressHUD setRingThickness:3.0];// 进度条的宽度
}

// 3.语言
- (void)setupLanguage {
    [EYLanguageTool setDefaultAppLanguage];
}

// 4.设置导航条
- (void)setupGKNavigationBar {
    GKNavigationBarConfigure *configure =  [GKNavigationBarConfigure sharedInstance];
    configure.backgroundColor = EYColorBlue;
    configure.titleColor = EYColorWhite;
    configure.titleFont = EYSizeFont17;
    configure.backStyle = GKNavigationBarBackStyleWhite;
}

// 5.Bugly
- (void)setupBugly {
//    [Bugly startWithAppId:Bugly_APP_ID];
}

// 6.iflyMSC
- (void)setupIflyMSC {
//    [IFlyDebugLog setShowLog:NO];//关闭log
//    [IFlySpeechUtility createUtility:[NSString stringWithFormat:@"appid=%@",IflyMSC_APP_ID]];
}

// 7.SDWebImage
- (void)setupSDWebImage {
    SDImageCacheConfig *imageCacheConfig = [SDImageCacheConfig defaultCacheConfig];
    //1.图片磁盘最大过期时间
    imageCacheConfig.maxDiskAge = 60 * 60 * 24 * 7;
    //2.图片磁盘最大占用 100M
    imageCacheConfig.maxDiskSize = 1024 * 1024 * 100;
    // 最大缓存个数
    imageCacheConfig.maxMemoryCount = 20;
    // 最大内存消耗 50M
    imageCacheConfig.maxMemoryCost = 1024 * 1024 * 50;
}

// 8.设置启动页面
- (void)launchViewController {

    self.window = [[UIWindow alloc] initWithFrame:EYScreenBounds];
    self.window.backgroundColor = EYColor2A2B33;
    
    EYRootViewController *rootVC= [[EYRootViewController alloc] init];
    EYNavigationController *navi = [[EYNavigationController alloc] initWithRootViewController:rootVC];
    navi.gk_openScrollLeftPush = YES;
    
    self.window.rootViewController = navi;
    self.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
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

// 开机动画
-(void)openAnimation {
    NSString *gifPath = [[NSBundle mainBundle] pathForResource:@"openAnimation" ofType:@"gif"];
    UIImage *gif = [UIImage sd_imageWithGIFData:[NSData dataWithContentsOfFile:gifPath]];
    UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    gifImageView.contentMode = UIViewContentModeScaleAspectFill;
    gifImageView.image = gif;
    [_window addSubview:gifImageView];

    NSString *lastFramePath = [[NSBundle mainBundle] pathForResource:@"lastFrame" ofType:@"png"];
    UIImage *lastFrame = [UIImage imageWithContentsOfFile:lastFramePath];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        gifImageView.image = lastFrame;

        [UIView animateWithDuration:1.0 animations:^{
            gifImageView.center = self.window.center;
            gifImageView.bounds = CGRectMake(0, 0, kScreenWidth*2, kScreenHeight*2);
            gifImageView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [gifImageView removeFromSuperview];
        }];
    });
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

#pragma mark - Override Methods
#pragma mark - Net Work
#pragma mark - DataSource
#pragma mark - Delegate
#pragma mark - Getters & Setters

@end
