//
//  EYHomeWorksViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/9/18.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYHomeWorksViewController.h"

@interface EYHomeWorksViewController ()

@end

@implementation EYHomeWorksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 初始化界面
    [self setupUI];
}

//1. 初始化界面
- (void)setupUI {
    if (!EYSCREENSIZE_IS_IPhoneX_All) {
        [UIApplication sharedApplication].statusBarHidden = NO;
    }
    
    self.view.backgroundColor = EYColorRandom;
}

@end
