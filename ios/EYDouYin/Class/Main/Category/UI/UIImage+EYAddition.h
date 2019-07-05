//
//  UIImage+EYAddition.h
//  CategoryDemo
//
//  Created by lieryang on 2017/5/5.
//  Copyright © 2017年 lieryang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (EYAddition)

/**
 返回制定大小的圆形图片

 @param size 大小(已最短的边为正方形的边)
 @param backgroundColor 裁剪掉的背景颜色
 @param lineColor 线的颜色
 @return 处理后的图片(正方形)
 */
- (UIImage *)changImageWithSize:(CGSize)size withBackgroundColor:(UIColor *)backgroundColor withLineColor:(UIColor *)lineColor;

@end
