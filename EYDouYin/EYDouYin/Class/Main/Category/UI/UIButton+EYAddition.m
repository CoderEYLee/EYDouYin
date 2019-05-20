//
//  UIButton+EYAddition.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/11/6.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "UIButton+EYAddition.h"

@implementation UIButton (EYAddition)

- (void)changButtonWithLineColor:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth {
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;

    width = width < height ? width : height;

    //设置圆角的半径
    self.layer.cornerRadius = width * 0.5;

    //切割超出圆角范围的子视图
    self.layer.masksToBounds = YES;

    //设置边框的颜色
    self.layer.borderColor = lineColor.CGColor;

    //设置边框的粗细
    self.layer.borderWidth = lineWidth;
}

@end
