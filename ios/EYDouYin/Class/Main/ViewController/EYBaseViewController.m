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

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // EYLog(@"%@--viewDidLoad", self);
    
    [self setupBaseUI];
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

#pragma mark - Private Methods
/**
 初始化默认界面
 */
- (void)setupBaseUI {
    // 1.设置背景颜色
    self.view.backgroundColor = EYColorTheme;
    
    self.gk_navTitle = self.title;
}

#pragma mark - 旋转方向
-(BOOL)shouldAutorotate {
    return YES;//默认支持旋转
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;//默认只是竖屏
}

- (void)dealloc {
    EYLog(@"%@--dealloc", self);
}

@end
