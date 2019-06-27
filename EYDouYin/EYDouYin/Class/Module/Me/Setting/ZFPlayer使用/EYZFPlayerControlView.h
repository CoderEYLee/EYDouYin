//
//  EYZFPlayerControlView.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/10/10.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EYZFPortraitControlView.h"
#import "ZFLandScapeControlView.h"
#import "ZFPlayerMediaControl.h"
#import "ZFSpeedLoadingView.h"

NS_ASSUME_NONNULL_BEGIN

@interface EYZFPlayerControlView : UIView <ZFPlayerMediaControl>

/// 竖屏控制层的View
@property (nonatomic, strong, readonly) EYZFPortraitControlView *portraitControlView;
/// 横屏控制层的View
@property (nonatomic, strong, readonly) ZFLandScapeControlView *landScapeControlView;
/// 加载loading
@property (nonatomic, strong, readonly) ZFSpeedLoadingView *activity;
/// 快进快退View
@property (nonatomic, strong, readonly) UIView *fastView;
/// 快进快退进度progress
@property (nonatomic, strong, readonly) ZFSliderView *fastProgressView;
/// 快进快退时间
@property (nonatomic, strong, readonly) UILabel *fastTimeLabel;
/// 快进快退ImageView
@property (nonatomic, strong, readonly) UIImageView *fastImageView;
/// 加载失败按钮
@property (nonatomic, strong, readonly) UIButton *failBtn;
/// 底部播放进度
@property (nonatomic, strong, readonly) ZFSliderView *bottomPgrogress;
/// 封面图
@property (nonatomic, strong, readonly) UIImageView *coverImageView;
/// 占位图，默认是灰色
@property (nonatomic, strong) UIImage *placeholderImage;
/// 快进视图是否显示动画，默认NO。
@property (nonatomic, assign) BOOL fastViewAnimated;

/// 设置标题、封面、全屏模式
- (void)showTitle:(NSString *)title coverURLString:(NSString *)coverUrl fullScreenMode:(ZFFullScreenMode)fullScreenMode;

/// 设置标题、UIImage封面、全屏模式
- (void)showTitle:(NSString *)title coverImage:(UIImage *)image fullScreenMode:(ZFFullScreenMode)fullScreenMode;

/// 重置控制层
- (void)resetControlView;


@end

NS_ASSUME_NONNULL_END
