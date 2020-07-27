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

@property (weak, nonatomic, readonly) EYHomePlayViewController *toptopVC;//上
@property (weak, nonatomic, readonly) EYHomePlayViewController *centerVC;//中
@property (weak, nonatomic, readonly) EYHomePlayViewController *bottomVC;//下
@property (weak, nonatomic, readonly) EYHomePlayViewController *currentVC;//当前

@end
