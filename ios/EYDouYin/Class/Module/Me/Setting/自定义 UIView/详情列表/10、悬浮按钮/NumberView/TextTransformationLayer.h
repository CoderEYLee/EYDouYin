//
//  TextTransformationLayer.h
//  NumberTransformationViewDemo
//
//  Created by mac on 17/3/21.
//  Copyright © 2017年 jason.wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextTransformationLayer : CAScrollLayer


/**
 设置layer属性

 @param textArr 要滚动显示的string数组
 @param font string的字体
 @param textColor 颜色
 @param selectText 当前显示的text
 */
- (void)setTextArray:(NSArray<NSString *> *)textArr
                font:(UIFont *)font
           textColor:(UIColor *)textColor
          selectText:(NSString *)selectText;

////当前显示的text , setter方法 -- setSelectText:animated:YES
@property (nonatomic, copy) NSString *selectText;


/**
 改变选中文字

 @param selectText 要选中的文字
 @param animated 是否需要动画显示
 */
- (void)setSelectText:(NSString *)selectText animated:(BOOL)animated;

@end
