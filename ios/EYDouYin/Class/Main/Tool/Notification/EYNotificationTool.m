//
//  EYNotificationTool.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/5/29.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYNotificationTool.h"

@implementation EYNotificationTool

#pragma mark - 三方登录授权回调的通知
NSString *const TTThirdAuthorizationNotification = @"TTThirdAuthorizationNotification";
+ (void)ey_addTTThirdAuthorizationNotificationObserver:(id)observer selector:(SEL)aSelector {
    [EYNotificationCenter addObserver:observer selector:aSelector name:TTThirdAuthorizationNotification object:nil];
}

+ (void)ey_postTTThirdAuthorizationNotificationUserInfo:(NSDictionary *)aUserInfo {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [EYNotificationCenter postNotificationName:TTThirdAuthorizationNotification object:nil userInfo:aUserInfo];
    });
}

+ (void)ey_removeTTThirdAuthorizationNotificationObserver:(id)observer {
    [EYNotificationCenter removeObserver:observer name:TTThirdAuthorizationNotification object:nil];
}

#pragma mark - 用户登陆成功
NSString *const TTLoginSuccessNotification = @"TTLoginSuccessNotification";
+ (void)ey_addTTLoginSuccessNotificationObserver:(id)observer selector:(SEL)aSelector {
    [EYNotificationCenter addObserver:observer selector:aSelector name:TTLoginSuccessNotification object:nil];
}

+ (void)ey_postTTLoginSuccessNotificationUserInfo:(NSDictionary *)aUserInfo {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [EYNotificationCenter postNotificationName:TTLoginSuccessNotification object:nil userInfo:aUserInfo];
    });
}

+ (void)ey_removeTTLoginSuccessNotificationObserver:(id)observer {
    [EYNotificationCenter removeObserver:observer name:TTLoginSuccessNotification object:nil];
}

#pragma mark - 作者修改个人信息
NSString *const TTUpdateUserInfoNotification = @"TTUpdateUserInfoNotification";
+ (void)ey_addTTUpdateUserInfoNotificationObserver:(id)observer selector:(SEL)aSelector {
    [EYNotificationCenter addObserver:observer selector:aSelector name:TTUpdateUserInfoNotification object:nil];
}

+ (void)ey_postTTUpdateUserInfoNotificationUserInfo:(NSDictionary *)aUserInfo {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [EYNotificationCenter postNotificationName:TTUpdateUserInfoNotification object:nil userInfo:aUserInfo];
    });
}

+ (void)ey_removeTTUpdateUserInfoNotificationObserver:(id)observer {
    [EYNotificationCenter removeObserver:observer name:TTUpdateUserInfoNotification object:nil];
}

#pragma mark - 处理多手势响应的通知
NSString *const TTMultiRegestureSubNotification = @"TTMultiRegestureSubNotification";
+ (void)ey_addTTMultiRegestureSubNotificationObserver:(id)observer selector:(SEL)aSelector {
    [EYNotificationCenter addObserver:observer selector:aSelector name:TTMultiRegestureSubNotification object:nil];
}

+ (void)ey_postTTMultiRegestureSubNotificationUserInfo:(nullable NSDictionary *)aUserInfo {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [EYNotificationCenter postNotificationName:TTMultiRegestureSubNotification object:nil userInfo:aUserInfo];
    });
}

+ (void)ey_removeTTMultiRegestureSubNotificationObserver:(id)observer {
    [EYNotificationCenter removeObserver:observer name:TTMultiRegestureSubNotification object:nil];
}

#pragma mark - 上传视频进度的通知
NSString *const TTSendVideoProgressNotification = @"TTSendVideoProgressNotification";
+ (void)ey_addTTSendVideoProgressNotificationObserver:(id)observer selector:(SEL)aSelector {
    [EYNotificationCenter addObserver:observer selector:aSelector name:TTSendVideoProgressNotification object:nil];
}

+ (void)ey_postTTSendVideoProgressNotificationUserInfo:(nullable NSDictionary *)aUserInfo {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [EYNotificationCenter postNotificationName:TTSendVideoProgressNotification object:nil userInfo:aUserInfo];
    });
}

+ (void)ey_removeTTSendVideoProgressNotificationObserver:(id)observer {
    [EYNotificationCenter removeObserver:observer name:TTSendVideoProgressNotification object:nil];
}

#pragma mark - 用户关注和取消操作成功的通知
NSString *const TTUserFocusAndCancelNotification = @"TTUserFocusAndCancelNotification";
+ (void)ey_addTTUserFocusAndCancelNotificationObserver:(id)observer selector:(SEL)aSelector {
    [EYNotificationCenter addObserver:observer selector:aSelector name:TTUserFocusAndCancelNotification object:nil];
}

+ (void)ey_postTTUserFocusAndCancelNotificationUserInfo:(nullable NSDictionary *)aUserInfo {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [EYNotificationCenter postNotificationName:TTUserFocusAndCancelNotification object:nil userInfo:aUserInfo];
    });
}

+ (void)ey_removeTTUserFocusAndCancelNotificationObserver:(id)observer {
    [EYNotificationCenter removeObserver:observer name:TTUserFocusAndCancelNotification object:nil];
}

#pragma mark - 用户拉黑和取消拉黑成功的通知
NSString *const TTUserBlackAndCancelNotification = @"TTUserBlackAndCancelNotification";
+ (void)ey_addTTUserBlackAndCancelNotificationObserver:(id)observer selector:(SEL)aSelector {
    [EYNotificationCenter addObserver:observer selector:aSelector name:TTUserBlackAndCancelNotification object:nil];
}

+ (void)ey_postTTUserBlackAndCancelNotificationUserInfo:(nullable NSDictionary *)aUserInfo {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [EYNotificationCenter postNotificationName:TTUserBlackAndCancelNotification object:nil userInfo:aUserInfo];
    });
}

+ (void)ey_removeTTUserBlackAndCancelNotificationObserver:(id)observer {
    [EYNotificationCenter removeObserver:observer name:TTUserBlackAndCancelNotification object:nil];
}

#pragma mark - 用户点赞和取消点赞成功的通知
NSString *const TTPickStepOnNotification = @"TTPickStepOnNotification";
+ (void)ey_addTTPickStepOnNotificationObserver:(id)observer selector:(SEL)aSelector {
    [EYNotificationCenter addObserver:observer selector:aSelector name:TTPickStepOnNotification object:nil];
}

+ (void)ey_postTTPickStepOnNotificationUserInfo:(nullable NSDictionary *)aUserInfo {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [EYNotificationCenter postNotificationName:TTPickStepOnNotification object:nil userInfo:aUserInfo];
    });
}

+ (void)ey_removeTTPickStepOnNotificationObserver:(id)observer {
    [EYNotificationCenter removeObserver:observer name:TTPickStepOnNotification object:nil];
}

#pragma mark - 用户字幕显示调整
//NSString *const TTSubtitleStateNotification = @"TTSubtitleStateNotification";
//+ (void)ey_addTTSubtitleStateNotificationObserver:(id)observer selector:(SEL)aSelector {
//    [EYNotificationCenter addObserver:observer selector:aSelector name:TTSubtitleStateNotification object:nil];
//}
//
//+ (void)ey_postTTSubtitleStateNotificationUserInfo:(nullable NSDictionary *)aUserInfo {
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [EYNotificationCenter postNotificationName:TTSubtitleStateNotification object:nil userInfo:aUserInfo];
//    });
//}
//
//+ (void)ey_removeTTSubtitleStateNotificationObserver:(id)observer {
//    [EYNotificationCenter removeObserver:observer name:TTSubtitleStateNotification object:nil];
//}

#pragma mark - 小红点提示的通知
NSString *const TTRedTipsNotification = @"TTRedTipsNotification";
+ (void)ey_addTTRedTipsNotificationObserver:(id)observer selector:(SEL)aSelector {
    [EYNotificationCenter addObserver:observer selector:aSelector name:TTRedTipsNotification object:nil];
}

+ (void)ey_postTTRedTipsNotificationUserInfo:(NSDictionary *)aUserInfo {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [EYNotificationCenter postNotificationName:TTRedTipsNotification object:nil userInfo:aUserInfo];
    });
}

+ (void)ey_removeTTRedTipsNotificationObserver:(id)observer {
    [EYNotificationCenter removeObserver:observer name:TTRedTipsNotification object:nil];
}

#pragma mark - 取消所有注册的通知
+ (void)ey_removeAllNotificationObserver:(id)observer {
    [EYNotificationCenter removeObserver:observer];
}

@end
