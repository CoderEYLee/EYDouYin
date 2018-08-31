//
//  EYHomeTitleView.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/31.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYHomeTitleView.h"

@implementation EYHomeTitleView

#pragma mark - 初始化方法
+ (instancetype)homeTitleView {
    EYHomeTitleView * view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    view.frame = CGRectMake(0, EYStatusBarHeight, EYScreenWidth, EYStatusBarAndNaviBarHeight - EYStatusBarHeight);
    return view;
}

#pragma mark - 点击方法

- (IBAction)tapButton:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeTitleView:didSelectedButton:)]) {
        [self.delegate homeTitleView:self didSelectedButton:sender.tag];
    }
}

@end
