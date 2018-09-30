//
//  EYHomeBackItemView.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/9/30.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYHomeBackItemView.h"

@implementation EYHomeBackItemView

+ (instancetype)homeBackItemView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];

    if (self.delegate && [self.delegate respondsToSelector:@selector(homeBackItemViewDidClick:)]) {
        [self.delegate homeBackItemViewDidClick:self];
    }
}

@end
