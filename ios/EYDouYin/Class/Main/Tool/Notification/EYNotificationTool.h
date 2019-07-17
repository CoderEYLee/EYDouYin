//
//  EYNotificationTool.h
//  EYDouYin
//
//  Created by 李二洋 on 2019/5/29.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EYNotificationTool : NSObject

#pragma mark - 微信登录授权回调的通知
+ (void)ey_addTTThirdAuthorizationNotificationObserver:(id)observer selector:(SEL)aSelector;

+ (void)ey_postTTThirdAuthorizationNotificationUserInfo:(nullable NSDictionary *)aUserInfo;

+ (void)ey_removeTTThirdAuthorizationNotificationObserver:(id)observer;

#pragma mark - 用户登陆成功
+ (void)ey_addTTLoginSuccessNotificationObserver:(id)observer selector:(SEL)aSelector;

+ (void)ey_postTTLoginSuccessNotificationUserInfo:(nullable NSDictionary *)aUserInfo;

+ (void)ey_removeTTLoginSuccessNotificationObserver:(id)observer;

#pragma mark - 作者修改个人信息
+ (void)ey_addTTUpdateUserInfoNotificationObserver:(id)observer selector:(SEL)aSelector;

+ (void)ey_postTTUpdateUserInfoNotificationUserInfo:(nullable NSDictionary *)aUserInfo;

+ (void)ey_removeTTUpdateUserInfoNotificationObserver:(id)observer;

#pragma mark - 处理多手势响应的通知
+ (void)ey_addTTMultiRegestureSubNotificationObserver:(id)observer selector:(SEL)aSelector;

+ (void)ey_postTTMultiRegestureSubNotificationUserInfo:(nullable NSDictionary *)aUserInfo;

+ (void)ey_removeTTMultiRegestureSubNotificationObserver:(id)observer;

#pragma mark - 上传视频进度的通知
+ (void)ey_addTTSendVideoProgressNotificationObserver:(id)observer selector:(SEL)aSelector;

+ (void)ey_postTTSendVideoProgressNotificationUserInfo:(nullable NSDictionary *)aUserInfo;

+ (void)ey_removeTTSendVideoProgressNotificationObserver:(id)observer;

#pragma mark - 用户关注和取消操作成功的通知
+ (void)ey_addTTUserFocusAndCancelNotificationObserver:(id)observer selector:(SEL)aSelector;

+ (void)ey_postTTUserFocusAndCancelNotificationUserInfo:(nullable NSDictionary *)aUserInfo;

+ (void)ey_removeTTUserFocusAndCancelNotificationObserver:(id)observer;

#pragma mark - 用户拉黑和取消拉黑成功的通知
+ (void)ey_addTTUserBlackAndCancelNotificationObserver:(id)observer selector:(SEL)aSelector;

+ (void)ey_postTTUserBlackAndCancelNotificationUserInfo:(nullable NSDictionary *)aUserInfo;

+ (void)ey_removeTTUserBlackAndCancelNotificationObserver:(id)observer;

#pragma mark - 用户点赞和取消点赞成功的通知
+ (void)ey_addTTPickStepOnNotificationObserver:(id)observer selector:(SEL)aSelector;

+ (void)ey_postTTPickStepOnNotificationUserInfo:(nullable NSDictionary *)aUserInfo;

+ (void)ey_removeTTPickStepOnNotificationObserver:(id)observer;

#pragma mark - 小红点提示的通知
+ (void)ey_addTTRedTipsNotificationObserver:(id)observer selector:(SEL)aSelector;

+ (void)ey_postTTRedTipsNotificationUserInfo:(nullable NSDictionary *)aUserInfo;

+ (void)ey_removeTTRedTipsNotificationObserver:(id)observer;

#pragma mark - FFmpeg 转码视频的通知
+ (void)ey_addTTCompressNotificationObserver:(id)observer selector:(SEL)aSelector;

+ (void)ey_postTTCompressNotificationUserInfo:(nullable NSDictionary *)aUserInfo;

+ (void)ey_removeTTCompressNotificationObserver:(id)observer;

#pragma mark - 取消所有注册的通知
+ (void)ey_removeAllNotificationObserver:(id)observer;


@end

NS_ASSUME_NONNULL_END
