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
    self.view.backgroundColor = EYRandomColor;
    EYLog(@"EYSendViewController--viewDidLoad");
    
    UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    closeButton.backgroundColor = EYRandomColor;
    [closeButton addTarget:self action:@selector(tapCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];

    // 默认方式加载多语言
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    label.backgroundColor = EYRandomColor;
    label.text = [NSString stringWithFormat:EYLocalized(@"测试%@"), @"123"];
    [self.view addSubview:label];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)tapCloseButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
