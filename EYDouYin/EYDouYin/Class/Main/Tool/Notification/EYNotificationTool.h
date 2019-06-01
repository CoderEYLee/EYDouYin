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

#pragma mark - 首页左滑成功触发的通知
+ (void)ey_addEYScrollLeftPushNotificationObserver:(id)observer selector:(SEL)aSelector;

+ (void)ey_postEYScrollLeftPushNotificationUserInfo:(nullable NSDictionary *)aUserInfo;

+ (void)ey_removeEYScrollLeftPushNotificationObserver:(id)observer;

@end

NS_ASSUME_NONNULL_END
