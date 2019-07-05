//
//  EYProgressHUD.h
//  EYDouYin
//
//  Created by 李二洋 on 2019/6/13.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SVProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface EYProgressHUD : UIView

#pragma mark - 设置
+ (void)setMinimumDismissTimeInterval:(NSTimeInterval)interval;
+ (void)setDefaultMaskType:(SVProgressHUDMaskType)maskType;
+ (void)setInfoImage:(nonnull UIImage*)image;
+ (void)setImageViewSize:(CGSize)size;
+ (void)setBackgroundColor:(nonnull UIColor*)color;
+ (void)setCornerRadius:(CGFloat)cornerRadius;
+ (void)setForegroundColor:(nonnull UIColor*)color;
+ (void)setFont:(nonnull UIFont*)font;
+ (void)setRingThickness:(CGFloat)ringThickness;

#pragma mark - 只有提示文字 默认能交互
/**
 只有提示文字 默认能交互
 
 @param status 提示文字
 */
+ (void)showInfoWithStatus:(nullable NSString *)status;

#pragma mark - 转圈等待框 + 提示文字  默认不能交互, 消失后能交互

/**
 转圈等待框 + 提示文字  默认不能交互, delay(s)之后消失 能交互
 
 @param status 提示文字
 */
+ (void)showWithStatus:(nullable NSString *)status dismissWithDelay:(NSTimeInterval)delay;

#pragma mark - 转圈进度(0.0~1.0) + 提示文字 默认不能交互, 进度大于 1.0 后 开启交互

/**
 转圈进度(0.0~1.0) + 提示文字 默认不能交互, 进度大于 1.0 后 开启交互
 
 @param progress 转圈进度(0.0~1.0) 大于 1.0 后 消失
 */
+ (void)showProgress:(float)progress;
+ (void)showProgress:(float)progress status:(nullable NSString*)status;
+ (void)dismiss;
+ (void)dismissWithDelay:(NSTimeInterval)delay;

@end

NS_ASSUME_NONNULL_END
