//
//  HWTabBar.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/4.
//  Copyright © 2018年 李二洋. All rights reserved.
//  测试使用, 项目不用

#import <UIKit/UIKit.h>

@class HWTabBar;

@protocol HWTabBarDelegate <UITabBarDelegate>
@optional
- (void)tabBarDidClickPlusButton:(HWTabBar *)tabBar;
@end

@interface HWTabBar : UITabBar
@property (nonatomic, weak) id<HWTabBarDelegate> delegate;
@end
