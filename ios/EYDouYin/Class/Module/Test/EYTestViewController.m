//
//  EYTestViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/12.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYTestViewController.h"
#import "EYTestView.h"

@interface EYTestViewController ()

@end

@implementation EYTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];
 
    //1. 初始化界面
    [self setupUI];
}
    
//1. 初始化界面
- (void)setupUI {
    self.view.backgroundColor = EYColorRandom;
    
    EYTestView *redView = [[EYTestView alloc] init];
    redView.backgroundColor = EYColorRed;
    EYVideoModel *videoModel = [[EYVideoModel alloc] init];
    videoModel.video_title = @"123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890";
    redView.videoModel = videoModel;
    [self.view addSubview:redView];
}

@end
