//
//  EYTestViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/12.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYTestViewController.h"

@interface EYTestViewController ()

@end

@implementation EYTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel * label = [[UILabel alloc] init];
    label.text = @"这是一个测试界面";
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    label.center = self.view.center;
    [self.view addSubview:label];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

@end
