//
//  EYProgressHUD.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/6/13.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYProgressHUD.h"

@implementation EYProgressHUD

#pragma mark - 设置
+ (void)setMinimumDismissTimeInterval:(NSTimeInterval)interval {
    [SVProgressHUD setMinimumDismissTimeInterval:interval];
}

+ (void)setDefaultMaskType:(SVProgressHUDMaskType)maskType {
    [SVProgressHUD setDefaultMaskType:maskType];
}

+ (void)setInfoImage:(UIImage *)image {
    [SVProgressHUD setInfoImage:image];
}

+ (void)setImageViewSize:(CGSize)size {
    [SVProgressHUD setImageViewSize:size];
}

+ (void)setBackgroundColor:(UIColor *)color {
    [SVProgressHUD setBackgroundColor:color];
}

+ (void)setCornerRadius:(CGFloat)cornerRadius {
    [SVProgressHUD setCornerRadius:cornerRadius];
}

+ (void)setForegroundColor:(UIColor *)color {
    [SVProgressHUD setForegroundColor:color];
}

+ (void)setFont:(UIFont *)font {
    [SVProgressHUD setFont:font];
}

+ (void)setRingThickness:(CGFloat)ringThickness {
    [SVProgressHUD setRingThickness:ringThickness];
}

#pragma mark - 只有提示文字 默认能交互
+ (void)showInfoWithStatus:(NSString *)status {
    [SVProgressHUD dismiss];
    [SVProgressHUD showInfoWithStatus:status];
}

#pragma mark - 转圈等待框 + 提示文字  默认不能交互, 消失后能交互

+ (void)showWithStatus:(NSString *)status dismissWithDelay:(NSTimeInterval)delay {
    [SVProgressHUD dismiss];
    //1.关闭交互
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    //2.转圈显示
    [SVProgressHUD showWithStatus:status];
    //3.消失
    [SVProgressHUD dismissWithDelay:delay completion:^{
        //4.开启交互
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    }];
}

#pragma mark - 转圈进度(0.0~1.0) + 提示文字 默认不能交互, 进度大于 1.0 后 开启交互
+ (void)showProgress:(float)progress {
    [self showProgress:progress status:nil];
}

+ (void)showProgress:(float)progress status:(nullable NSString*)status {
    //1.关闭交互
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    //2.进度显示
    [SVProgressHUD showProgress:progress status:status];
    if (progress >= 1.0) {
        //3.开启交互
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        //4.消失
        [SVProgressHUD dismiss];
    }
}

+ (void)dismiss {
    //1.开启交互
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    //2.消失
    [SVProgressHUD dismiss];
}

+ (void)dismissWithDelay:(NSTimeInterval)delay {
    //1.消失
    [SVProgressHUD dismissWithDelay:delay completion:^{
        //2.开启交互
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    }];
}

@end
