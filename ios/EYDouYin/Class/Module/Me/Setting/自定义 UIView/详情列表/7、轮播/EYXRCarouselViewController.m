//
//  EYXRCarouselViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/10/28.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYXRCarouselViewController.h"

@interface EYXRCarouselViewController ()

@end

@implementation EYXRCarouselViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 初始化界面
    [self setupUI];
}

//1. 初始化界面
- (void)setupUI {
    self.view.backgroundColor = EYColorRandom;
    
    XRCarouselView *carouselView = [[XRCarouselView alloc] initWithFrame:CGRectMake(0, self.gk_navigationBar.height, EYScreenWidth, 300)];
    carouselView.placeholderImage = [UIImage imageNamed:@"common_placeholder"];
    carouselView.time = 1;
    carouselView.imageArray = @[@"https:/videoali.chinlab.com/screenshot/45441559010378.jpg", @"https:/videoali.chinlab.com/screenshot/45441558422766.jpg"];
    carouselView.backgroundColor = EYColorRandom;
    [self.view addSubview:carouselView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        carouselView.imageArray = @[@"https:/videoali.chinlab.com/screenshot/45441559010378.jpg", @"https:/videoali.chinlab.com/screenshot/45441558422766.jpg", @"https:/videoali.chinlab.com/screenshot/45441558421673.jpg", @"https:/videoali.chinlab.com/screenshot/45441558421328.jpg"];
    });
}

@end
