//
//  NumberTransformationView.h
//  NumberTransformationViewDemo
//
//  Created by mac on 17/3/21.
//  Copyright © 2017年 jason.wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumberTransformationView : UIView


/**
 创建

 @param frame frame
 @param font font , 用于确定每个数字占用的宽度
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame font:(UIFont *)font;

////当前显示的数字
@property (nonatomic, copy) NSNumber *numberValue;

@property (nonatomic , strong) UIFont *font;

@property (nonatomic , strong) UIColor *textColor;

////对齐方式 , 目前支持left , center 和 right
@property (nonatomic , assign) NSTextAlignment alignment;

////单个数字之间的间隔 , default:0
@property (nonatomic , assign) CGFloat textMargin;

////内容边距 , default , UIEdgeInsetsZero
@property (nonatomic , assign) UIEdgeInsets contentEdgeInsets;

@end
