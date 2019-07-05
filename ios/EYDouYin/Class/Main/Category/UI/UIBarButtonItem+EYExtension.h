//
//  UIBarButtonItem+EYExtension.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/12.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (EYExtension)

/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)ey_itemWithTarget:(id)target action:(SEL)action image:(NSString *)image;

@end
