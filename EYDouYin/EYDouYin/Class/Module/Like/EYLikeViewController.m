//
//  EYLikeViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/23.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYLikeViewController.h"

@interface EYLikeViewController ()

@end

@implementation EYLikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 初始化界面
    [self setupUI];
}

//1. 初始化界面
- (void)setupUI {
    //1.导航
    self.gk_navBackgroundColor = EYColorGray;
    
    //2.滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, EYStatusBarAndNaviBarHeight, EYScreenWidth, EYScreenHeight - EYStatusBarAndNaviBarHeight - EYTabBarHomeIndicatorHeight)];
    scrollView.backgroundColor = EYColorRandom;
    scrollView.contentSize = CGSizeMake(EYScreenWidth * 2, EYScreenHeight);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    //3.底部 view
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, EYScreenHeight - EYTabBarHomeIndicatorHeight, EYScreenWidth, EYTabBarHomeIndicatorHeight)];
    bottomView.backgroundColor = EYColorBlue;
    [self.view addSubview:bottomView];
}

@end
