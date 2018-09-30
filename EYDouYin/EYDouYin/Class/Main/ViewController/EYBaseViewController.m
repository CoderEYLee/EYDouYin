//
//  EYBaseViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/22.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYBaseViewController.h"

@interface EYBaseViewController ()

@end

@implementation EYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // EYLog(@"%@--viewDidLoad", self);
    [self setupNaviBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // EYLog(@"%@--viewWillAppear", self);
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    // EYLog(@"%@--viewWillLayoutSubviews", self);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    // EYLog(@"%@--viewDidLayoutSubviews", self);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // EYLog(@"%@--viewDidAppear", self);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // EYLog(@"%@--viewWillDisappear", self);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    // EYLog(@"%@--viewDidDisappear", self);
}

- (void)dealloc {
    EYLog(@"%@--dealloc", self);
}

- (void)setupNaviBar {
    self.gk_navigationBar.hidden = YES;
    
    UINavigationBar * naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, EYScreenWidth, 44)];
    [naviBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [naviBar setShadowImage:[UIImage new]];
    [self.view addSubview:naviBar];
    self.naviBar = naviBar;
}

#pragma mark - 旋转方向
-(BOOL)shouldAutorotate {
    return YES;//默认支持旋转
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;//默认只是竖屏
}

@end
