//
//  NSAttributedString+EYAdditon.m
//
//  Created by lieryang on 16/4/26.
//  Copyright © 2016年 lieryang. All rights reserved.
//

#import "NSAttributedString+EYAdditon.h"

@implementation NSAttributedString (EYAdditon)

+ (instancetype)ey_imageTextWithImage:(UIImage *)image imageWH:(CGFloat)imageWH title:(NSString *)title fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor spacing:(CGFloat)spacing {
    
    // 文本字典
    NSDictionary *titleDict = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize],
                                NSForegroundColorAttributeName: titleColor};
    NSDictionary *spacingDict = @{NSFontAttributeName: [UIFont systemFontOfSize:spacing]};
    
    // 图片文本
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = image;
    attachment.bounds = CGRectMake(0, 0, imageWH, imageWH);
    NSAttributedString *imageText = [NSAttributedString attributedStringWithAttachment:attachment];
    
    // 换行文本
    NSAttributedString *lineText = [[NSAttributedString alloc] initWithString:@"\n\n" attributes:spacingDict];
    
    // 按钮文字
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:title attributes:titleDict];
    
    // 合并文字
    NSMutableAttributedString *attM = [[NSMutableAttributedString alloc] initWithAttributedString:imageText];
    [attM appendAttributedString:lineText];
    [attM appendAttributedString:text];
    
    return attM.copy;
}

@end
