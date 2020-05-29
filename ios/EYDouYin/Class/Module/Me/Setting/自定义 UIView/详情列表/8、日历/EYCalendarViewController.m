//
//  EYCalendarViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2020/5/30.
//  Copyright © 2020 李二洋. All rights reserved.
//

#import "EYCalendarViewController.h"

@interface EYCalendarViewController ()

@end

@implementation EYCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 初始化界面
    [self setupUI];
}

//1. 初始化界面
- (void)setupUI {
    self.gk_navLineHidden = YES;
    self.view.backgroundColor = EYColorRandom;
    
    
}

@end
