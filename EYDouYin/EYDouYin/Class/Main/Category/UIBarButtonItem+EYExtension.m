//
//  UIBarButtonItem+EYExtension.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/12.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "UIBarButtonItem+EYExtension.h"

@implementation UIBarButtonItem (EYExtension)
/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.adjustsImageWhenHighlighted = NO;
    // 设置尺寸
    button.size = button.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
