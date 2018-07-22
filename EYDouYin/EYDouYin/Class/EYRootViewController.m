//
//  EYRootViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/22.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYRootViewController.h"
#import "EYFindViewController.h"
#import "EYTabBarController.h"

@interface EYRootViewController ()

@end

@implementation EYRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:EYScreenBounds];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    
    //左面view
    EYFindViewController * findViewController = [[EYFindViewController alloc] init];
    findViewController.view.frame = CGRectMake(0, 0, EYScreenWidth, EYScreenHeight);
    [scrollView addSubview:findViewController.view];
    
    //主 view
    EYTabBarController * tabbarController = [[EYTabBarController alloc] init];
    tabbarController.view.frame = CGRectMake(EYScreenWidth, 0, EYScreenWidth, EYScreenHeight);
    [scrollView addSubview:tabbarController.view];
    
    scrollView.contentSize = CGSizeMake(EYScreenWidth * 2, EYScreenHeight);
    [self.view addSubview:scrollView];
}

@end
