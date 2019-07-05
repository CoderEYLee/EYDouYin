//
//  EYFollowFriendViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/5/30.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYFollowFriendViewController.h"

@interface EYFollowFriendViewController ()

@end

@implementation EYFollowFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 初始化界面
    [self setupUI];
}

//1. 初始化界面
- (void)setupUI {
    self.gk_navigationBar.hidden = YES;
    self.view.backgroundColor = EYColorGreen;
}

@end
