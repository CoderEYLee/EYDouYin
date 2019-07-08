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
 转换&压缩视频
 
 @param inputPath 输入视频路径
 @param outpath 输出视频路径
 @param processBlock 进度回调
 @param completionBlock 结束回调
 */
- (void)converVideoWithInputPath:(NSString *)inputPath
                 outputPath:(NSString *)outpath
               processBlock:(void (^)(float process))processBlock
            completionBlock:(void (^)(NSError *error))completionBlock;

// 设置总时长
+ (void)setDuration:(long long)time;

// 设置当前时间
+ (void)setCurrentTime:(long long)time;

// 转换停止
+ (void)stopRuning:(int)ret;

@end

NS_ASSUME_NONNULL_END
