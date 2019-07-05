//
//  EYBaseVideoPlayer.h
//  TTEnglish
//
//  Created by 李二洋 on 2019/4/10.
//  Copyright © 2019 TTEnglish. All rights reserved.
//  基于腾讯视频SDK封装的播放器(功能)

#import <Foundation/Foundation.h>
#import <TXLiveSDKTypeDef.h>
#import <TXVodPlayConfig.h>

NS_ASSUME_NONNULL_BEGIN

@class EYBaseVideoPlayer;

@protocol EYBaseVideoPlayerDelegate<NSObject>

@optional
- (void)baseVideoPlayerOnPlayEvent:(EYBaseVideoPlayer *)baseVideoPlayer event:(int)EvtID withParam:(NSDictionary *)param;
- (void)baseVideoPlayerOnNetStatus:(EYBaseVideoPlayer *)baseVideoPlayer withParam:(NSDictionary *)param;

@end

@interface EYBaseVideoPlayer : NSObject

/// 是否循环播放 默认为NO
@property (assign, nonatomic) BOOL loop;

/// startPlay后是否立即播放，默认YES
@property (assign, nonatomic) BOOL isAutoPlay;

/// 播放同一地址的视频，默认NO(默认不对传入的视频播放地址做处理)
@property (assign, nonatomic) BOOL dissablePlaySameVideo;

/// 渲染方式 默认 图像铺满屏幕
@property (assign, nonatomic) TX_Enum_Type_RenderMode renderMode;

/**
 * 设置播放开始时间
 * 在startPlay前设置，修改开始播放的起始位置
 */
@property (assign, nonatomic) CGFloat startTime;

/**
 * 点播配置
 * @see TXVodPlayConfig
 */
@property(nonatomic, copy) TXVodPlayConfig *config;

/**
 添加到视图上

 @param view 父视图
 @param idx 父视图中的层级位置
 */
- (void)setupVideoWidget:(UIView *)view insertIndex:(unsigned int)idx;

/// 是否正在播放
@property (assign, nonatomic, readonly) BOOL isPlaying;

/// 当前播放的URL
@property (copy, nonatomic, readonly) NSString *TX_URLString;

#pragma mark - 播放相关

/**
 开始播放视频
 */
- (void)startPlayWithURLString:(NSString *)TX_URLString;

/**
 暂停播放
 */
- (void)pausePlay;

/**
 恢复播放
 */
- (void)resumePlay;

/**
 停止播放
 */
- (void)stopPlay;

/**
 移除播放(播放出现问题时候使用, 会销毁播放器)
 */
- (void)removePlay;

@property (nonatomic,weak)id <EYBaseVideoPlayerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
