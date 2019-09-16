//
//  EYBaseAliVideoPlayer.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/9/2.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYBaseAliVideoPlayer.h"

@interface EYBaseAliVideoPlayer() <AVPDelegate>

@property (strong, nonatomic) AliPlayer *aliPlayer;

@end

@implementation EYBaseAliVideoPlayer

- (instancetype)init {
    self = [super init];
    if (self) {
        //1. 初始化播放器
        [self setupPlayer];
        
        //2.添加通知
        [self addNotification];
    }
    return self;
}

//2.初始化播放器
- (void)setupPlayer {
    // 初始化
    _aliPlayer = [[AliPlayer alloc] init];
    // 设置渲染模式
    _aliPlayer.scalingMode = AVP_SCALINGMODE_SCALEASPECTFILL;
    // 开启硬件加速
    _aliPlayer.enableHardwareDecoder = YES;
    // 设置代理
    _aliPlayer.delegate = self;
    // 循环播放
    _aliPlayer.loop = YES;
    
    _aliPlayer.autoPlay = YES;
    
    // 缓存配置
    AVPCacheConfig *cacheConfig = [[AVPCacheConfig alloc] init];
    cacheConfig.path = TTTXVodPlayConfigPath.insertTempPathString;
    cacheConfig.maxDuration = 100;
    cacheConfig.maxSizeMB = 200;
    cacheConfig.enable = YES;
    [_aliPlayer setCacheConfig:cacheConfig];
    
    AVPConfig *config = [[AVPConfig alloc] init];
    config.clearShowWhenStop = YES;
    [_aliPlayer setConfig:config];
    
    [_aliPlayer setEnableLog:NO];
}

// 添加通知
- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
}

#pragma mark - Notification
//程序已经变成活跃状态
- (void)appDidBecomeActive:(NSNotification *)noti {
    EYLog(@"AliPlayer:程序已经变成活跃状态");
}

//程序将会失去活跃状态
- (void)appWillResignActive:(NSNotification *)noti {
    EYLog(@"AliPlayer:程序将会失去活跃状态");
}

#pragma mark - 公开事件
//
///**
// @brief 初始化播放器
// @param traceID 用于跟踪debug信息
// */
//- (instancetype)init:(NSString*)traceID;
//
/**
 @brief 使用url方式来播放视频
 @param source AVPUrlSource的输入类型
 @see AVPUrlSource
 */
- (void)setUrlSource:(AVPUrlSource*)source {
    [self.aliPlayer setUrlSource:source];
}

///**
// @brief 用vid和sts来播放视频，sts可参考：https://help.aliyun.com/document_detail/28756.html?spm=a2c4g.11186623.4.4.6f554c07q7B7aS
// @param source AVPVidStsSource的输入类型
// @see AVPVidStsSource
// */
//- (void)setStsSource:(AVPVidStsSource*)source;
//
///**
// @brief 用vid和MPS信息来播放视频。可参考：https://help.aliyun.com/document_detail/53522.html?spm=5176.doc53534.2.5.mhSfOh
// @param source AVPVidMpsSource的输入类型
// @see AVPVidMpsSource
// */
//- (void)setMpsSource:(AVPVidMpsSource*)source;
//
///**
// @brief 使用vid+playauth方式播放。可参考：https://help.aliyun.com/document_detail/57294.html
// @param source AVPVidAuthSource的输入类型
// @see AVPVidAuthSource
// */
//- (void)setAuthSource:(AVPVidAuthSource*)source;

/**
 @brief 播放准备，异步
 */
-(void)prepare {
    [self.aliPlayer prepare];
}

/**
 @brief 开始播放
 */
-(void)start {
    [self.aliPlayer start];
}

/**
 @brief 暂停播放
 */
-(void)pause {
    [self.aliPlayer pause];
}

///**
// @brief 刷新view，例如view size变化时。
// */
//-(void)redraw;
//
///**
// @brief 重置播放
// */
//-(void)reset;

/**
 @brief 停止播放
 */
-(void)stop {
   [self.aliPlayer stop];
}

/**
 @brief 销毁播放器
 */
-(void)destroy {
    [self.aliPlayer destroy];
}

/**
 @brief 跳转到指定的播放位置
 @param time 新的播放位置
 @param seekMode seek模式
 @see AVPSeekMode
 */
-(void)seekToTime:(int64_t)time seekMode:(AVPSeekMode)seekMode {
    [self.aliPlayer seekToTime:time seekMode:seekMode];
}

/**
 @brief 截图 AVPImage: mac平台返回NSImage，iOS平台返回UIImage
 */
-(void)snapShot {
    [self.aliPlayer snapShot];
}

///**
// @brief 根据trackIndex，切换清晰度
// @param trackIndex 选择清晰度的index，SELECT_AVPTRACK_TYPE_VIDEO_AUTO代表自适应码率
// */
//-(void)selectTrack:(int)trackIndex;
//
///**
// @brief 获取媒体信息，包括track信息
// */
//-(AVPMediaInfo*) getMediaInfo;
//
///**
// @brief 获取当前播放track
// @param type track类型
// @see AVPTrackType
// */
//-(AVPTrackInfo*) getCurrentTrack:(AVPTrackType)type;
//
///**
// @brief 设置缩略图URL
// @param URL 缩略图URL
// */
//-(void) setThumbnailUrl:(NSString *)URL;
//
///**
// @brief 获取指定位置的缩略图
// @param positionMs 代表在哪个指定位置的缩略图
// */
//-(void)getThumbnail:(int64_t)positionMs;
//
///**
// @brief 用于跟踪debug信息
// @param traceID 指定和其他客户端连接可跟踪的id
// */
//- (void) setTraceID:(NSString*)traceID;
//
//
///**
// @brief 设置转换播放的url的回调函数，一般用于p2p中的url地址转换
// @param callback 回调函数指针
// */
//- (void) setPlayUrlConvertCallback:(PlayURLConverCallback)callback;

/**
 @brief 播放器设置
 @param config AVPConfig类型
 @see AVPConfig
 */
-(void)setConfig:(AVPConfig*)config {
    [self.aliPlayer setConfig:config];
}

/**
 @brief 获取播放器设置
 @see AVPConfig
 */
-(AVPConfig*) getConfig {
    return [self.aliPlayer getConfig];
}

/**
 @brief 设置缓存配置
 @param cacheConfig 缓存配置。{@link AVPCacheConfig}。
 @return 设置成功返回YES
 */
-(BOOL)setCacheConfig:(AVPCacheConfig *)cacheConfig {
    return [self.aliPlayer setCacheConfig:cacheConfig];
}

///**
// @brief 根据url获取缓存的文件名。如果有自定义的规则，请实现delegate {@link onGetCacheNameByURL}。
// @brief 如果没有实现delegate，将会采用默认逻辑生成文件名。
// @param URL URL
// * @return 最终缓存的文件名（不包括后缀。缓存文件的后缀名统一为.alv）。
// */
//-(NSString *) getCacheFilePath:(NSString *)URL;
//
///**
// @brief 根据url获取缓存的文件名。如果有自定义的规则，请实现delegate {@link onCacheNameByVidCallback}。
// @brief 如果没有实现delegate，将会采用默认逻辑生成文件名。
// @param vid        视频id
// @param format     视频格式
// @param definition 视频清晰度
// @return 最终缓存的文件名（不包括后缀。缓存文件的后缀名统一为.alv）。
// */
//-(NSString *) getCacheFilePath:(NSString *)vid format:(NSString *)format definition:(NSString *)definition;
//
///**
// @brief 根据url获取缓存的文件名。如果有自定义的规则，请实现delegate {@link onCacheNameByVidCallback}。
// @brief 如果没有实现delegate，将会采用默认逻辑生成文件名。
// @param vid        视频id
// @param format     视频格式
// @param definition 视频清晰度
// @param previewTime 试看时长
// @return 最终缓存的文件名（不包括后缀。缓存文件的后缀名统一为.alv）。
// */
//-(NSString *) getCacheFilePath:(NSString *)vid format:(NSString *)format definition:(NSString *)definition previewTime:(int)previewTime;
//
///**
// @brief 重新加载。比如网络超时时，可以重新加载。
// */
//-(void) reload;
//
///**
// @brief 获取SDK版本号信息
// */
//+ (NSString*) getSDKVersion;
//
///**
// @brief 初始化播放器组件。这些组件是可裁剪的。App可删除相应动态库，去掉初始化组件代码，实现裁剪。
// */
//+ (void) initPlayerComponent:(NSString *)functionName function:(void*)function;

- (void)setMuted:(BOOL)muted {
    [self.aliPlayer setMuted:muted];
}

- (BOOL)isMuted {
    return self.aliPlayer.isMuted;
}

- (void)setRate:(float)rate {
    [self.aliPlayer setRate:rate];
}

//
///**
// @brief 是否开启硬件解码，支持KVO
// */
//@property(nonatomic) BOOL enableHardwareDecoder;
//
///**
// @brief 设置是否循环播放，支持KVO
// */
//@property(nonatomic, getter=isLoop) BOOL loop;
//
///**
// @brief 设置是否自动播放，支持KVO
// */
//@property(nonatomic, getter=isAutoPlay) BOOL autoPlay;
//
///**
// @brief 是否打开log输出
// @see 使用setLogCallbackInfo
// */
//@property(nonatomic) BOOL enableLog;
//
///**
// @brief 渲染镜像模式，支持KVO
// @see AVPMirrorMode
// */
//@property(nonatomic) AVPMirrorMode mirrorMode;
//
///**
// @brief 渲染旋转模式，支持KVO
// @see AVPRotateMode
// */
//@property(nonatomic) AVPRotateMode rotateMode;
//
///**
// @brief 渲染填充模式，支持KVO
// @see AVPScalingMode
// */
//@property(nonatomic) AVPScalingMode scalingMode;

- (void)setPlayerView:(UIView *)playerView {
    _playerView = playerView;
    
    self.aliPlayer.playerView = playerView;
}

- (int)width {
    return self.aliPlayer.width;
}

- (int)height {
    return self.aliPlayer.height;
}

- (int)rotation {
    return self.aliPlayer.rotation;
}

///**
// @brief 获取/设置播放器的音量，支持KVO
// */
//@property (nonatomic, assign) float volume;
//
///**
// @brief 获取视频的长度，支持KVO
// */
//@property (nonatomic, readonly) int64_t duration;
//
///**
// @brief 获取当前播放位置，支持KVO
// */
//@property (nonatomic, readonly) int64_t currentPosition;
//
///**
// @brief 获取已经缓存的位置，支持KVO
// */
//@property (nonatomic, readonly) int64_t bufferedPosition;
//
///**
// @brief 设置代理，参考AVPDelegate
// @see AVPDelegate
// */
//@property (nonatomic, weak) id<AVPDelegate> delegate;
//
///**
// @brief 设置日志打印回调block，异步
// @param logLevel log输出级别
// @param callbackBlock log回调block，可以为nil
// */
//+(void) setLogCallbackInfo:(AVPLogLevel)logLevel callbackBlock:(void (^)(AVPLogLevel logLevel,NSString* strLog))block;


#pragma mark - AVPDelegate
/**
 @brief 播放器事件回调
 @param player 播放器player指针
 @param eventType 播放器事件类型
 @see AVPEventType
 */
-(void)onPlayerEvent:(AliPlayer*)player eventType:(AVPEventType)eventType {
    switch (eventType) {
        case AVPEventPrepareDone: {/**@brief 准备完成事件*/
            EYLog(@"准备完成事件");
            break;
        }
        case AVPEventAutoPlayStart: {/**@brief 自动启播事件*/
            EYLog(@"自动启播事件");
            break;
        }
        case AVPEventFirstRenderedStart: {/**@brief 首帧显示时间*/
            EYLog(@"首帧显示时间");
            break;
        }
        case AVPEventCompletion: {/**@brief 播放完成事件*/
            EYLog(@"播放完成事件");
            break;
        }
        case AVPEventLoadingStart: {/**@brief 缓冲开始事件*/
            EYLog(@"缓冲开始事件");
            break;
        }
        case AVPEventLoadingEnd: {/**@brief 缓冲完成事件*/
            EYLog(@"缓冲完成事件");
            break;
        }
        case AVPEventSeekEnd: {/**@brief 跳转完成事件*/
            EYLog(@"跳转完成事件");
            break;
        }
        case AVPEventLoopingStart: {/**@brief 循环播放开始事件*/
            EYLog(@"循环播放开始事件");
            break;
        }
        default:
            break;
    }
}

/**
 @brief 播放器事件回调
 @param player 播放器player指针
 @param eventWithString 播放器事件类型
 @param description 播放器事件说明
 @see AVPEventType
 */
-(void)onPlayerEvent:(AliPlayer*)player eventWithString:(AVPEventWithString)eventWithString description:(NSString *)description {
    // EYLog(@"播放器事件回调: 播放器事件类型:%lu, description:%@", eventWithString, description);
}

/**
 @brief 错误代理回调
 @param player 播放器player指针
 @param errorModel 播放器错误描述，参考AVPErrorModel
 @see AVPErrorModel
 */
- (void)onError:(AliPlayer*)player errorModel:(AVPErrorModel *)errorModel {
    // EYLog(@"onError:%@, errorModel:%@", player, errorModel);
}

/**
 @brief 视频大小变化回调
 @param player 播放器player指针
 @param width 视频宽度
 @param height 视频高度
 @param rotation 视频旋转角度
 */
- (void)onVideoSizeChanged:(AliPlayer*)player width:(int)width height:(int)height rotation:(int)rotation {
    // EYLog(@"视频大小改变:%@, 宽:%d, 高:%d, 视频旋转角度:%d", player, width, height, rotation);
}

/**
 @brief 视频当前播放位置回调
 @param player 播放器player指针
 @param position 视频当前播放位置
 */
- (void)onCurrentPositionUpdate:(AliPlayer*)player position:(int64_t)position {
    int64_t duration = player.duration;
    EYLog(@"视频当前播放位置回调:位置:%lld 进度:%f", position, (position * 1.0 / duration));
}

/**
 @brief 视频缓存位置回调
 @param player 播放器player指针
 @param position 视频当前缓存位置
 */
- (void)onBufferedPositionUpdate:(AliPlayer*)player position:(int64_t)position {
    // EYLog(@"视频缓存位置回调:位置:%lld", position);
}

/**
 @brief 视频缓冲进度回调
 @param player 播放器player指针
 @param progress 缓存进度0-100
 */
- (void)onLoadingProgress:(AliPlayer*)player progress:(float)progress {
    // EYLog(@"视频缓冲进度回调:progress:%f", progress);
}

/**
 @brief 获取track信息回调
 @param player 播放器player指针
 @param info track流信息数组
 @see AVPTrackInfo
 */
- (void)onTrackReady:(AliPlayer*)player info:(NSArray<AVPTrackInfo*>*)info {
    // EYLog(@"获取track信息回调 info:%@", info);
}

/**
 @brief track切换完成回调
 @param player 播放器player指针
 @param info 切换后的信息 参考AVPTrackInfo
 @see AVPTrackInfo
 */
- (void)onTrackChanged:(AliPlayer*)player info:(AVPTrackInfo*)info {
    EYLog(@"track切换完成回调:%@, info:%@", player, info);
}

/**
 @brief 字幕显示回调
 @param player 播放器player指针
 @param index 字幕显示的索引号
 @param subtitle 字幕显示的字符串
 */
- (void)onSubtitleShow:(AliPlayer*)player index:(int)index subtitle:(NSString *)subtitle {
    EYLog(@"字幕显示回调: index:%d subtitle:%@", index, subtitle);
}

/**
 @brief 字幕隐藏回调
 @param player 播放器player指针
 @param index 字幕显示的索引号
 */
- (void)onSubtitleHide:(AliPlayer*)player index:(int)index {
    EYLog(@"字幕隐藏回调: index:%d", index);
}

/**
 @brief 获取缩略图成功回调
 @param positionMs 指定的缩略图位置
 @param fromPos 此缩略图的开始位置
 @param toPos 此缩略图的结束位置
 @param image 缩图略图像指针,对于mac是NSImage，iOS平台是UIImage指针
 */
- (void)onGetThumbnailSuc:(int64_t)positionMs fromPos:(int64_t)fromPos toPos:(int64_t)toPos image:(id)image {
    // EYLog(@"获取缩略图成功回调:%lld, fromPos:%lld, toPos:%lld image:%@", positionMs, fromPos, toPos, image);
}

/**
 @brief 获取缩略图失败回调
 @param positionMs 指定的缩略图位置
 */
- (void)onGetThumbnailFailed:(int64_t)positionMs {
    //EYLog(@"获取缩略图失败回调:%lld", positionMs);
}

/**
 @brief 播放器状态改变回调
 @param player 播放器player指针
 @param oldStatus 老的播放器状态 参考AVPStatus
 @param newStatus 新的播放器状态 参考AVPStatus
 @see AVPStatus
 */
- (void)onPlayerStatusChanged:(AliPlayer*)player oldStatus:(AVPStatus)oldStatus newStatus:(AVPStatus)newStatus {
    switch (newStatus) {
        case AVPStatusIdle: {/** @brief 空转，闲时，静态 */
            EYLog(@"空转，闲时，静态");
            break;
        }
        case AVPStatusInitialzed: {/** @brief 初始化完成 */
            EYLog(@"初始化完成");
            break;
        }
        case AVPStatusPrepared: {/** @brief 准备完成 */
            EYLog(@"首帧显示时间");
            break;
        }
        case AVPStatusStarted: {/** @brief 正在播放 */
            EYLog(@"正在播放");
            break;
        }
        case AVPStatusPaused: {/** @brief 播放暂停 */
            EYLog(@"播放暂停");
            break;
        }
        case AVPStatusStopped: {/** @brief 播放停止 */
            EYLog(@"播放停止");
            break;
        }
        case AVPStatusCompletion: {/** @brief 播放完成 */
            EYLog(@"播放完成");
            break;
        }
        case AVPStatusError: {/** @brief 播放错误 */
            EYLog(@"播放错误");
            break;
        }
        default:
            break;
    }
}

/**
 @brief 获取截图回调
 @param player 播放器player指针
 @param image 图像
 @see AVPImage
 */
- (void)onCaptureScreen:(AliPlayer*)player image:(AVPImage*)image {
    // EYLog(@"获取截图回调:%@ oldStatus:%@", player, image);
}

- (void)dealloc {
    [self.aliPlayer destroy];
}

@end
