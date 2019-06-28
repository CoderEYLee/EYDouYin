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
+ (void)tt_addTTThirdAuthorizationNotificationObserver:(id)observer selector:(SEL)aSelector;

+ (void)tt_postTTThirdAuthorizationNotificationUserInfo:(nullable NSDictionary *)aUserInfo;

+ (void)tt_removeTTThirdAuthorizationNotificationObserver:(id)observer;

#pragma mark - 用户登陆成功
+ (void)tt_addTTLoginSuccessNotificationObserver:(id)observer selector:(SEL)aSelector;

+ (void)tt_postTTLoginSuccessNotificationUserInfo:(nullable NSDictionary *)aUserInfo;

+ (void)tt_removeTTLoginSuccessNotificationObserver:(id)observer;

#pragma mark - 作者修改个人信息
+ (void)tt_addTTUpdateUserInfoNotificationObserver:(id)observer selector:(SEL)aSelector;

+ (void)tt_postTTUpdateUserInfoNotificationUserInfo:(nullable NSDictionary *)aUserInfo;

+ (void)tt_removeTTUpdateUserInfoNotificationObserver:(id)observer;

#pragma mark - 处理多手势响应的通知
+ (void)tt_addTTMultiRegestureSubNotificationObserver:(id)observer selector:(SEL)aSelector;

+ (void)tt_postTTMultiRegestureSubNotificationUserInfo:(nullable NSDictionary *)aUserInfo;

+ (void)tt_removeTTMultiRegestureSubNotificationObserver:(id)observer;

#pragma mark - 上传视频进度的通知
+ (void)tt_addTTSendVideoProgressNotificationObserver:(id)observer selector:(SEL)aSelector;

+ (void)tt_postTTSendVideoProgressNotificationUserInfo:(nullable NSDictionary *)aUserInfo;

+ (void)tt_removeTTSendVideoProgressNotificationObserver:(id)observer;

#pragma mark - 用户关注和取消操作成功的通知
+ (void)tt_addTTUserFocusAndCancelNotificationObserver:(id)observer selector:(SEL)aSelector;

+ (void)tt_postTTUserFocusAndCancelNotificationUserInfo:(nullable NSDictionary *)aUserInfo;

+ (void)tt_removeTTUserFocusAndCancelNotificationObserver:(id)observer;

#pragma mark - 用户拉黑和取消拉黑成功的通知
+ (void)tt_addTTUserBlackAndCancelNotificationObserver:(id)observer selector:(SEL)aSelector;

+ (void)tt_postTTUserBlackAndCancelNotificationUserInfo:(nullable NSDictionary *)aUserInfo;

+ (void)tt_removeTTUserBlackAndCancelNotificationObserver:(id)observer;

#pragma mark - 用户点赞和取消点赞成功的通知
+ (void)tt_addTTPickStepOnNotificationObserver:(id)observer selector:(SEL)aSelector;

+ (void)tt_postTTPickStepOnNotificationUserInfo:(nullable NSDictionary *)aUserInfo;

+ (void)tt_removeTTPickStepOnNotificationObserver:(id)observer;

#pragma mark - 用户字幕显示调整
//+ (void)tt_addTTSubtitleStateNotificationObserver:(id)observer selector:(SEL)aSelector;
//
//+ (void)tt_postTTSubtitleStateNotificationUserInfo:(nullable NSDictionary *)aUserInfo;
//
//+ (void)tt_removeTTSubtitleStateNotificationObserver:(id)observer;

#pragma mark - 小红点提示的通知
+ (void)tt_addTTRedTipsNotificationObserver:(id)observer selector:(SEL)aSelector;

+ (void)tt_postTTRedTipsNotificationUserInfo:(nullable NSDictionary *)aUserInfo;

+ (void)tt_removeTTRedTipsNotificationObserver:(id)observer;

#pragma mark - 取消所有注册的通知
+ (void)tt_removeAllNotificationObserver:(id)observer;


@end

NS_ASSUME_NONNULL_END
