//
//  UIScreen+EYAddition.m
//
//  Created by lieryang on 16/5/17.
//  Copyright © 2016年 lieryang. All rights reserved.
//

#import "UIScreen+EYAddition.h"

@implementation UIScreen (EYAddition)

+ (CGFloat)ey_screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)ey_screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)ey_scale {
    return [UIScreen mainScreen].scale;
}

@end
