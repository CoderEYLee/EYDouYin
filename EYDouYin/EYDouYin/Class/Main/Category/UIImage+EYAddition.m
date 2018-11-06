//
//  UIImage+EYAddition.m
//  CategoryDemo
//
//  Created by lieryang on 2017/5/5.
//  Copyright © 2017年 lieryang. All rights reserved.
//

#import "UIImage+EYAddition.h"

@implementation UIImage (EYAddition)

- (UIImage *)changImageWithSize:(CGSize)size withBackgroundColor:(UIColor *)backgroundColor withLineColor:(UIColor *)lineColor {
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    width  = width < height ? width : height;
    height = width < height ? width : height;
    
    CGRect rect = CGRectMake(0, 0, width, height);
    
    //1. 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), YES, 0);
    
    //2. 设置填充颜色
    [backgroundColor setFill];
    UIRectFill(rect);
    
    // 3. 利用 贝赛尔路径 `裁切 效果
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [path addClip];
    
    //4. 绘制图像
    [self drawInRect:rect];
    
    //5. 画圆环
    UIBezierPath * ovalpath = [UIBezierPath bezierPathWithOvalInRect:rect];
    ovalpath.lineWidth = 2.0;
    [ovalpath stroke];
    [lineColor setStroke];
    
    UIImage * result = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    return result;

}

@end
