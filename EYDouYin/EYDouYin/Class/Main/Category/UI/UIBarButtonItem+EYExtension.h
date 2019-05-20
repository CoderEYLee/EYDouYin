//
//  UIBarButtonItem+EYExtension.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/12.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (EYExtension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

@end
