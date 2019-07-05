//
//  EYRNViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/7/4.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYRNViewController.h"
#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#if RCT_DEV
#import <React/RCTDevLoadingView.h>
#endif

@interface EYRNViewController () <RCTBridgeDelegate>

@end

@implementation EYRNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化界面
    [self setupUI];
}

//1.初始化界面
- (void)setupUI {
    self.view.backgroundColor = EYColorRed;
    RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:nil];
#if RCT_DEV
    [bridge moduleForClass:[RCTDevLoadingView class]];
#endif
    NSDictionary *properties = @{@"name": @"zhangsan"};
    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
                                                     moduleName:@"EYDouYin"
                                              initialProperties:properties];
    
    rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
    self.view = rootView;
}
    
#pragma mark - RCTBridgeDelegate
- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge {
#if DEBUG
    return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
#else
    return [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"jsbundle"];
#endif
}

@end
