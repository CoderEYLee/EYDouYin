//
//  EYSendViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/23.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYSendViewController.h"

@interface EYSendViewController ()

@end

@implementation EYSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 初始化界面
    [self setupUI];
}

//1. 初始化界面
- (void)setupUI {
    self.gk_navigationBar.hidden = YES;
    self.view.backgroundColor = EYColorRandom;
    
    UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    closeButton.backgroundColor = EYColorRandom;
    [closeButton addTarget:self action:@selector(tapCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    
    // 默认方式加载多语言
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    label.backgroundColor = EYColorRandom;
    label.text = [NSString stringWithFormat:EYLocalized(@"测试"), @"123"];
    [self.view addSubview:label];
}

- (void)tapCloseButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
