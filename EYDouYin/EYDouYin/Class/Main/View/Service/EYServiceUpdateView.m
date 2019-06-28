//
//  EYServiceUpdateView.m
//  TTEnglish
//
//  Created by 李二洋 on 2019/1/30.
//  Copyright © 2019 TTEnglish. All rights reserved.
//

#import "EYServiceUpdateView.h"
#import "EYTabBarController.h"

@implementation EYServiceUpdateView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = EYColor2A2B33;
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, EYScreenHeight * 0.5-100, EYScreenWidth, 100)];
        tipLabel.text = EYLocalized(@"tt_placeholder_14");
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.numberOfLines = 0;
        tipLabel.textColor = EYColorWhite;
        tipLabel.font = EYSizeFont18;
        [self addSubview:tipLabel];

        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(EYScreenWidth * 0.5 - 50, CGRectGetMaxY(tipLabel.frame), 100, 50)];
        button.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        button.backgroundColor = EYColorWhite0_1;
        button.layer.cornerRadius = 3.0;
        [button setTitle:EYLocalized(@"tt_0115_0") forState:UIControlStateNormal];
        [button sizeToFit];
        [button addTarget:self action:@selector(tapReloadButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    return self;
}

- (void)tapReloadButton:(UIButton *)button {
    [self removeFromSuperview];

    EYKeyWindow.rootViewController = [[EYTabBarController alloc] init];
}

@end
