//
//  EYHomePlayViewController.h
//  EYDouYin
//
//  Created by 李二洋 on 2019/5/31.
//  Copyright © 2019 李二洋. All rights reserved.
//  视频流中每一个界面控制器

#import "EYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EYHomePlayViewController : EYBaseViewController

// 视频模型
@property (strong, nonatomic) EYVideoModel *videoModel;

/// startPlay后是否立即播放，默认NO
@property (assign, nonatomic) BOOL isAutoPlay;

///开始播放视频
//- (void)startPlayWithURLString:(NSString *)TX_URLString;

///暂停播放
- (void)pausePlay;

///恢复播放
- (void)resumePlay;

///停止播放
- (void)stopPlay;

///移除播放
- (void)removePlay;

///是否正在播放
@property (assign, nonatomic, readonly) BOOL isPlaying;

@end

NS_ASSUME_NONNULL_END
