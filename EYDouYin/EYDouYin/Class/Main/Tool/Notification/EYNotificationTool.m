//
//  EYNotificationTool.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/5/29.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYNotificationTool.h"

@implementation EYNotificationTool

#pragma mark - 首页左滑成功触发的通知
NSString *const EYScrollLeftPushNotification=@"EYScrollLeftPushNotification";
+ (void)ey_addEYScrollLeftPushNotificationObserver:(id)observer selector:(SEL)aSelector {
    [EYNotificationCenter addObserver:observer selector:aSelector name:EYScrollLeftPushNotification object:nil];
}

+ (void)ey_postEYScrollLeftPushNotificationUserInfo:(NSDictionary *)aUserInfo {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [EYNotificationCenter postNotificationName:EYScrollLeftPushNotification object:nil userInfo:aUserInfo];
    });
}

+ (void)ey_removeEYScrollLeftPushNotificationObserver:(id)observer {
    [EYNotificationCenter removeObserver:observer name:EYScrollLeftPushNotification object:nil];
}

@end
