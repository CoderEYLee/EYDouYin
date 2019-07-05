//
//  EYHomeViewController.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/23.
//  Copyright © 2018年 李二洋. All rights reserved.
//  首页总控制器

#import "EYBaseViewController.h"
#import "EYHomePlayViewController.h"

@interface EYHomeViewController : EYBaseViewController

// 当前屏幕所属的控制器
@property (weak, nonatomic, readonly) EYHomePlayViewController *currentPlayViewController;

@end
