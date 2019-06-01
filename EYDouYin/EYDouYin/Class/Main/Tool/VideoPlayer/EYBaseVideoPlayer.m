//
//  EYBaseVideoPlayer.m
//  TTEnglish
//
//  Created by 李二洋 on 2019/4/10.
//  Copyright © 2019 TTEnglish. All rights reserved.
//

#import "EYBaseVideoPlayer.h"
#import <TXLiteAVSDK_Player/TXLiveBase.h>


@interface EYBaseVideoPlayer() <TXVodPlayListener>

// 腾讯SDK播放器
@property (nonatomic, strong) TXVodPlayer *txVodPlayer;
// 当前播放的URL
@property (copy, nonatomic, readwrite) NSString *TX_URLString;

@end

@implementation EYBaseVideoPlayer

- (void)setIsAutoPlay:(BOOL)isAutoPlay {
    _isAutoPlay = isAutoPlay;
    self.txVodPlayer.isAutoPlay = _isAutoPlay;
}

- (void)setLoop:(BOOL)loop {
    _loop = loop;
    self.txVodPlayer.loop = loop;
}

- (void)setRenderMode:(TX_Enum_Type_RenderMode)renderMode {
    _renderMode = renderMode;
    [self.txVodPlayer setRenderMode:renderMode];
}

- (void)setStartTime:(CGFloat)startTime {
    _startTime = startTime;
    [self.txVodPlayer setStartTime:startTime];
}

- (void)setConfig:(TXVodPlayConfig *)config {
    _config = config;
    self.txVodPlayer.config = config;
}

- (BOOL)isPlaying {
    return self.txVodPlayer.isPlaying;
}

- (void)setupVideoWidget:(UIView *)view insertIndex:(unsigned int)idx {
    [self.txVodPlayer setupVideoWidget:view insertIndex:idx];
}

#pragma mark - 播放相关

/**
 开始播放视频
 */
- (void)startPlayWithURLString:(NSString *)TX_URLString {
    if (self.dissablePlaySameVideo) {//不允许播放相同的视频地址
        NSString *lastTX_URLString = self.TX_URLString;
        if ([lastTX_URLString isEqualToString:TX_URLString]) {
            EYLog(@"不允许播放相同的视频地址%@" , lastTX_URLString);
            return;
        }
    }
    // 停止播放
    [self.txVodPlayer stopPlay];

    self.TX_URLString = TX_URLString;

    int result = [self.txVodPlayer startPlay:TX_URLString];
    if (result == 0) {
        EYLog(@"开始播放成功==%@" , TX_URLString);
    } else {
        EYLog(@"开始播放失败==%@", TX_URLString);
    }
}

/**
 暂停播放
 */
- (void)pausePlay {
    if (self.txVodPlayer.isPlaying) {
        EYLog(@"暂停播放==%@", self.TX_URLString);
        [self.txVodPlayer pause];
    }
}

/**
 恢复播放
 */
- (void)resumePlay {
    if (self.txVodPlayer.isPlaying == NO) {
        EYLog(@"恢复播放==%@", self.TX_URLString);
        [self.txVodPlayer resume];
    }
}

/**
 停止播放
 */
- (void)stopPlay {
    if (self.TX_URLString.length == 0) {
        EYLog(@"视频地址为空,不需要停止播放");
        return;
    }
    
    int result = [self.txVodPlayer stopPlay];
    
    self.TX_URLString = nil;
    if (result == 0) {
        EYLog(@"停止播放成功==%@", self.TX_URLString);
    } else {
        EYLog(@"停止播放失败==%@", self.TX_URLString);
    }
}

/**
 移除播放(播放出现问题时候使用, 会销毁播放器)
 */
- (void)removePlay {
    [self.txVodPlayer removeVideoWidget];
    self.TX_URLString = nil;
    self.delegate = nil;
}

#pragma mark - TXVodPlayListener
/**
 * 点播事件通知
 *
 * @param player 点播对象
 * @param EvtID 参见TXLiveSDKTypeDef.h
 * @param param 参见TXLiveSDKTypeDef.h
 * @see TXVodPlayer
 */
-(void) onPlayEvent:(TXVodPlayer *)player event:(int)EvtID withParam:(NSDictionary *)param {
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseVideoPlayerOnPlayEvent:event:withParam:)]) {
        [self.delegate baseVideoPlayerOnPlayEvent:self event:EvtID withParam:param];
    }
    switch (EvtID) {
        case PLAY_EVT_PLAY_LOADING:{// loading

            break;
        }
        case PLAY_EVT_PLAY_BEGIN:{// 开始播放

            break;
        }
        case PLAY_EVT_PLAY_END:{// 播放结束
            
            break;
        }
        case PLAY_ERR_NET_DISCONNECT:{// 失败，多次重连无效

            break;
        }
        case PLAY_EVT_PLAY_PROGRESS:{// 进度

            break;
        }

        default:
            break;
    }
}

/**
 * 网络状态通知
 *
 * @param player 点播对象
 * @param param 参见TXLiveSDKTypeDef.h
 * @see TXVodPlayer
 */
-(void) onNetStatus:(TXVodPlayer *)player withParam:(NSDictionary *)param {
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseVideoPlayerOnNetStatus:withParam:)]) {
        [self.delegate baseVideoPlayerOnNetStatus:self withParam:param];
    }
}

#pragma mark - Private Methods
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupPlayer];
    }
    return self;
}

// 初始化播放器
- (void)setupPlayer {
    // 设置LOG信息
    [TXLiveBase setLogLevel:LOGLEVEL_NULL];
    [TXLiveBase setConsoleEnabled:NO];

    // 初始化
    _txVodPlayer = [[TXVodPlayer alloc] init];
    // 设置渲染模式
    [_txVodPlayer setRenderMode:RENDER_MODE_FILL_EDGE];
    // 开启硬件加速
    _txVodPlayer.enableHWAcceleration = YES;
    // 设置代理
    _txVodPlayer.vodDelegate = self;
    // 循环播放
    _txVodPlayer.loop = NO;
    
    _txVodPlayer.isAutoPlay = YES;
    
    //不禁止 播放相同的地址的视频(允许播放相同的视频)
    _dissablePlaySameVideo = NO;

    //添加通知
    [self addNotification];
}

// 添加通知
- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
}

//程序已经变成活跃状态
- (void)appDidBecomeActive:(NSNotification *)noti {
    EYLog(@"程序已经变成活跃状态");
}

//程序将会失去活跃状态
- (void)appWillResignActive:(NSNotification *)noti {
    EYLog(@"程序将会失去活跃状态");
    [self pausePlay];
}

- (void)dealloc {
    EYLog(@"TXVodPlayer -- dealloc");
}

@end
