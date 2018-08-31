//
//  EYHomeSharedView.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/31.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYHomeSharedView.h"

@interface EYHomeSharedView()

// 待定使用
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@end

@implementation EYHomeSharedView

#pragma mark - 初始化方法
+ (instancetype)homeSharedView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:[self alloc] options:nil] lastObject];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView * view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].firstObject;
        view.frame = self.bounds;
        [self addSubview:view];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIView *view = [[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] instantiateWithOwner:self options:nil].firstObject;
        view.frame = self.bounds;
        [self addSubview:view];
    }
    return self;
}

#pragma mark - 点击方法
- (IBAction)tapButton:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeSharedView:didSeletedButton:)]) {
        [self.delegate homeSharedView:self didSeletedButton:sender.tag];
    }
}

@end
