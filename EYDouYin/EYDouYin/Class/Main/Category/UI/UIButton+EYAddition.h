//
//  UIButton+EYAddition.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/11/6.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (EYAddition)

/**
 处理按钮

 @param lineColor 线的颜色
 @param lineWidth 线的宽度
 */
- (void)changButtonWithLineColor:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth;

@end

NS_ASSUME_NONNULL_END
