//
//  EYHomePlayViewController.h
//  EYDouYin
//
//  Created by 李二洋 on 2019/5/31.
//  Copyright © 2019 李二洋. All rights reserved.
//  视频流中每一个界面控制器

#import "EYBaseViewController.h"
#import "EYBaseVideoPlayer.h"
#import "EYVideoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EYHomePlayViewController : EYBaseViewController

@property (strong, nonatomic, readonly) EYBaseVideoPlayer *videoPlayer;
@property (weak, nonatomic, readonly) UIButton *playbutton;

// 视频模型
@property (strong, nonatomic) EYVideoModel *videoModel;

@end

NS_ASSUME_NONNULL_END
