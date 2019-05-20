//
//  UIView+EYCornerRadius.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/9/25.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "UIView+EYCornerRadius.h"

@implementation UIView (EYCornerRadius)

- (__kindof UIView *)clipsCornerRadius:(UIRectCorner)corners cornerRadii:(CGFloat)radius {
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];

    //创建layer层
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = bezierPath.CGPath;

    //赋值给layer层
    self.layer.mask = shapeLayer;

    return self;
}

@end
