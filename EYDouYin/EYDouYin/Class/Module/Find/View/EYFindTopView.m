//
//  EYFindTopView.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/12.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYFindTopView.h"

@implementation EYFindTopView

+ (instancetype)findTopView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([EYFindTopView class]) owner:nil options:nil] lastObject];
}

- (IBAction)tapScanButton:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(findTopView:didTapButton:)]) {
        [self.delegate findTopView:self didTapButton:EYFindTopViewButtonScan];
    }
}

- (IBAction)tapRightButton:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(findTopView:didTapButton:)]) {
        [self.delegate findTopView:self didTapButton:EYFindTopViewButtonRight];
    }
}

@end
