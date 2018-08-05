//
//  EYTabBar.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/4.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYTabBar.h"

@interface EYTabBar() <UITabBarDelegate>

@end

@implementation EYTabBar

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.delegate = self;//写这句话没有用,UITabBarController 里面 有 tabBar, 这样只有UITabBarController才能是tabBar的代理
    }
    return self;
}

@end
