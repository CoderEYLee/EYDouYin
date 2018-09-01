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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel * label = [[UILabel alloc] init];
    label.text = @"这是一个测试界面";
    [label sizeToFit];
    label.center = self.view.center;
    [self.view addSubview:label];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];

    [self.navigationController popViewControllerAnimated:YES];
}

@end
