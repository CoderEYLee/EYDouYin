//
//  TTFFmpegManager.h
//  CLVideo
//
//  Created by 李二洋 on 2019/7/6.
//  Copyright © 2019 TaoTie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTFFmpegManager : NSObject

+ (instancetype)manager;

/**
 选择手机相册中的视频
 
 @param parameters 限制的参数()
 */
- (void)selectVideoWithParameters:(NSDictionary *)parameters;

// 设置总时长
+ (void)setDuration:(long long)time;

// 设置当前时间
+ (void)setCurrentTime:(long long)time;

// 转换停止
+ (void)stopRuning:(int)ret;

@end

NS_ASSUME_NONNULL_END
