//
//  EYBlueView.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/26.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYBlueView.h"

@interface EYBlueView()

@end

@implementation EYBlueView

+ (instancetype)blueView {
    // 方式一
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:[self alloc] options:nil] lastObject];
    // 方式二
    // return [[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] instantiateWithOwner:nil options:nil].firstObject;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView * view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([EYBlueView class]) owner:self options:nil].firstObject;
        view.frame = self.bounds;
        [self addSubview:view];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        //加载为普通的 view
        UIView *view = [[UINib nibWithNibName:NSStringFromClass([EYBlueView class]) bundle:nil] instantiateWithOwner:self options:nil].firstObject;
        //设置位置(一定要设置)
        view.frame = self.bounds;
        //添加到自己身上
        [self addSubview:view];
    }
    return self;
}

@end
