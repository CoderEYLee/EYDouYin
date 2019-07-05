//
//  EYFindViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/22.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYFindViewController.h"
#import "EYRootViewController.h"
#import "AppDelegate.h"

@interface EYFindViewController ()

@end

@implementation EYFindViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupUI];
    EYLog(@"EYFindViewController--viewDidLoad");
}

- (void)setupUI {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem ey_itemWithTarget:self action:@selector(scan) image:@"find_scan"];
    //右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ey_itemWithTarget:self action:@selector(right) image:@"common_arrow_right"];
    //中间文字
    UILabel * label = [[UILabel alloc] init];
    label.text = @"发现";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:18.0];
    self.navigationItem.titleView = label;
    
    //下部的滚动视图
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, EYScreenWidth, EYScreenHeight - EYStatusBarAndNaviBarHeight)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.backgroundColor = EYColorRandom;
    scrollView.contentSize = CGSizeMake(EYScreenWidth, 1000);
    [self.view addSubview:scrollView];
}

#pragma mark - Public Methods
#pragma mark - Private Methods
- (void)scan {
    EYTestViewController * vc = [[EYTestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)right {
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [appDelegate.rootViewController.scrollView setContentOffset:CGPointMake(EYScreenWidth, 0) animated:YES];
}

#pragma mark - Override Methods
#pragma mark - Net Work
#pragma mark - DataSource
#pragma mark - Delegate
#pragma mark - Getters & Setters

@end
