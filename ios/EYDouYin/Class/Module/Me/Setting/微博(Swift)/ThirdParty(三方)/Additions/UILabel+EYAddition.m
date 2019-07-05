//
//  UILabel+EYAddition.m
//
//  Created by lieryang on 16/4/21.
//  Copyright © 2016年 lieryang. All rights reserved.
//

#import "UILabel+EYAddition.h"

@implementation UILabel (EYAddition)

+ (instancetype)ey_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color {
    UILabel *label = [[self alloc] init];
    
    label.text = text;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = color;
    label.numberOfLines = 0;
    
    [label sizeToFit];
    
    return label;
}

@end
