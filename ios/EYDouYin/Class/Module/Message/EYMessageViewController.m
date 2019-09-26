//
//  EYMessageViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/23.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYMessageViewController.h"

@interface EYMessageViewController ()

@end

@implementation EYMessageViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    EYLog(@"EYMessageViewController--viewDidLoad");
    
    //1. 初始化界面
    [self setupUI];
}

//1. 初始化界面
- (void)setupUI {
    self.gk_navLineHidden = YES;
    self.view.backgroundColor = EYColorRandom;
    
    XRCarouselView *carouselView = [[XRCarouselView alloc] initWithFrame:CGRectMake(0, 100, EYScreenWidth, 300)];
    carouselView.placeholderImage = [UIImage imageNamed:@"common_placeholder"];
    carouselView.time = 1;
    carouselView.imageArray = @[@"https:/videoali.chinlab.com/screenshot/45441559010378.jpg", @"https:/videoali.chinlab.com/screenshot/45441558422766.jpg"];
    carouselView.backgroundColor = EYColorRandom;
    [self.view addSubview:carouselView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        carouselView.imageArray = @[@"https:/videoali.chinlab.com/screenshot/45441559010378.jpg", @"https:/videoali.chinlab.com/screenshot/45441558422766.jpg", @"https:/videoali.chinlab.com/screenshot/45441558421673.jpg", @"https:/videoali.chinlab.com/screenshot/45441558421328.jpg"];
    });
    
    //2.底部 view
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, EYScreenHeight - EYTabBarHomeIndicatorHeight, EYScreenWidth, EYTabBarHomeIndicatorHeight)];
    bottomView.backgroundColor = EYColorBlack;
    [self.view addSubview:bottomView];
}

@end
