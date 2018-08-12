//
//  EYFindViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/22.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYFindViewController.h"
#import "EYFindTopView.h"

@interface EYFindViewController ()

@end

@implementation EYFindViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
//    [self setupUI];
    EYLog(@"EYFindViewController--viewDidLoad");
}

- (void)setupUI
{
    EYFindTopView * topView = [EYFindTopView findTopView];
    topView.frame = CGRectMake(0, 20, EYScreenWidth, 44);
    [self.view addSubview:topView];
}

@end
