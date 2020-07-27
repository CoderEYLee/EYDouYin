//
//  NumberTransformationView.m
//  NumberTransformationViewDemo
//
//  Created by mac on 17/3/21.
//  Copyright © 2017年 jason.wang. All rights reserved.
//

#import "NumberTransformationView.h"
#import "TextTransformationLayer.h"

@interface NumberTransformationView ()
{
    NSMutableArray<TextTransformationLayer *> *_scrollLayers;
}

@end

@implementation NumberTransformationView
CGFloat kAnimationNumberLabel_eachWidth;


- (instancetype)initWithFrame:(CGRect)frame font:(UIFont *)font {
    if (self = [super initWithFrame:frame]) {
        _font = font;
        _scrollLayers = [NSMutableArray array];
        _textMargin = 0;
        _contentEdgeInsets = UIEdgeInsetsZero;
        self.layer.masksToBounds = YES;
        //根据font 计算单个数字的宽度
        kAnimationNumberLabel_eachWidth = [@"2" boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 0) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.width;
    }
    return self;
}

//设置显示的数字
- (void)setNumberValue:(NSNumber *)numberValue {
    [self configScrollLayers:numberValue];
    _numberValue = numberValue;
}

- (void)configScrollLayers:(NSNumber *)numberValue {
    CGFloat lastX = 0;
    //先根据对齐方式 , 计算最低位数字的x值
    if (_alignment == NSTextAlignmentRight) {
        lastX = self.frame.size.width - kAnimationNumberLabel_eachWidth - _contentEdgeInsets.right;
    } else if (_alignment == NSTextAlignmentLeft) {
        lastX = (kAnimationNumberLabel_eachWidth + _textMargin) * (numberValue.description.length - 1) + _contentEdgeInsets.left;
    } else if (_alignment == NSTextAlignmentCenter) {
        lastX = self.frame.size.width / 2.0 + (kAnimationNumberLabel_eachWidth * numberValue.description.length + _textMargin * (numberValue.description.length - 1)) / 2.0 - kAnimationNumberLabel_eachWidth;
    }
    
    //如果之前数字的位数大于新数字的位数 , 将多余的layer移除 , 复用剩下的layer
    for (NSInteger i = numberValue.description.length; i<_scrollLayers.count; i++) {
        [_scrollLayers[i] removeFromSuperlayer];
        [_scrollLayers removeObjectAtIndex:i];
        i--;
    }
    
    //如果之前的数字的位数小于新数字的位数 , 添加新的layer .
    for (NSInteger i = _scrollLayers.count; i<numberValue.description.length; i++) {
        TextTransformationLayer *textLayer = [TextTransformationLayer layer];
        textLayer.frame = CGRectMake(lastX - i * kAnimationNumberLabel_eachWidth, 0, kAnimationNumberLabel_eachWidth, self.bounds.size.height);
       
        [textLayer setTextArray:@[@".",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"] font:_font textColor:_textColor selectText:nil];
        [_scrollLayers addObject:textLayer];
        
        [self.layer addSublayer:textLayer];
        
    }
    
    //遍历layer 进行赋值和计算frame
    for (NSInteger i = 0; i<_scrollLayers.count; i++) {
        TextTransformationLayer *layer = _scrollLayers[i];
        layer.frame = CGRectMake(lastX - i * kAnimationNumberLabel_eachWidth - _textMargin * i, 0, kAnimationNumberLabel_eachWidth, self.bounds.size.height);
        
        //如果是0到9或者9到0 , 不进行动画展示
        BOOL animated;
        NSString *newStr = [numberValue.description substringWithRange:NSMakeRange(_scrollLayers.count - i - 1, 1)];

        if (i<_numberValue.description.length) {
            NSString *curStr = [_numberValue.description substringWithRange:NSMakeRange(_numberValue.description.length - i - 1, 1)];
            animated = (abs(newStr.intValue - curStr.intValue) < 9);
        } else {
            animated = NO;
        }
        
        animated = (animated && layer.selectText);
        [layer setSelectText:newStr animated:animated];;
    }
}

@end
