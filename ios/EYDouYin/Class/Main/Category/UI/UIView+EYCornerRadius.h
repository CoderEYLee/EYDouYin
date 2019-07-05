//
//  UIView+EYCornerRadius.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/9/25.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (EYCornerRadius)

- (__kindof UIView *)clipsCornerRadius:(UIRectCorner)corners cornerRadii:(CGFloat)radius;

@end
