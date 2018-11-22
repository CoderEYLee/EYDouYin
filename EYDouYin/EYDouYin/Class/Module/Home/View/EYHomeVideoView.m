//
//  EYHomeVideoView.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/26.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYHomeVideoView.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "EYHomeVideoModel.h"

@interface EYHomeVideoView() <EYHomeSharedViewDelegate>

@property (weak, nonatomic, readwrite) IBOutlet EYHomeInfoView *homeInfoView;
@property (weak, nonatomic, readwrite) IBOutlet EYHomeSharedView *homeSharedView;
@property (weak, nonatomic) IBOutlet UILabel *volumeProgressLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (weak, nonatomic) NSTimer * timer;

@property (strong, nonatomic) SJBaseVideoPlayer *player;

@end

@implementation EYHomeVideoView

NSString *const EYHomeVideoViewSystemVolumeDidChangeNotification=@"AVSystemController_SystemVolumeDidChangeNotification";

#pragma mark - 初始化方法
- (void)awakeFromNib {
    [super awakeFromNib];

    self.homeSharedView.delegate = self;

    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    self.volumeProgressLabel.mj_w = EYScreenWidth * audioSession.outputVolume;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeChange:) name:EYHomeVideoViewSystemVolumeDidChangeNotification object:nil];

    if (EYSCREENSIZE_IS_IPhoneX_All) {
        self.bottomConstraint.constant = 0;
    } else {
        self.bottomConstraint.constant = 49;
    }
}

+ (instancetype)homeItemView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
        self.frame = frame;
    }
    return self;
}

#pragma mark - 音量控制
- (void)volumeChange:(NSNotification*)notifi{
    NSString * style = notifi.userInfo[@"AVSystemController_AudioCategoryNotificationParameter"];
    if ([style isEqualToString:@"Audio/Video"]){
        double value = [notifi.userInfo[@"AVSystemController_AudioVolumeNotificationParameter"] doubleValue];
        self.volumeProgressLabel.hidden = NO;
        self.volumeProgressLabel.mj_w = EYScreenWidth * value;

        if (self.timer) {
            [self.timer invalidate];
        }

        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 block:^(NSTimer * _Nonnull timer) {
            self.volumeProgressLabel.hidden = YES;
            [self.timer invalidate];
        } repeats:NO];
    }
}

#pragma mark - EYHomeSharedViewDelegate
- (void)homeSharedView:(EYHomeSharedView *)view didSeletedButton:(EYHomeSharedViewButtonType)buttonType {
    switch (buttonType) {
        case EYHomeSharedViewButtonTypeHead: {
            EYLog(@"头像");
            break;
        }case EYHomeSharedViewButtonTypelike: {
            EYLog(@"点赞");
            break;
        }case EYHomeSharedViewButtonTypeComments: {
            EYLog(@"评论");
            break;
        }case EYHomeSharedViewButtonTypeShare: {
            EYLog(@"分享");
            break;
        }
        default:
            break;
    }
}

- (void)setVideoModel:(EYHomeVideoModel *)videoModel {
    _videoModel = videoModel;
//    self.homeInfoView.videoModel = videoModel;
//    self.homeSharedView.videoModel = videoModel;
//    self.player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:videoModel.video_url]];
}

#pragma mark - 视频相关的功能
- (void)playVideo {
//    EYLog(@"开始播放视频");
//    [self.player play];
}

- (void)stopVideo {
//    EYLog(@"停止播放视频");
}

- (void)dealloc {
    [EYNotificationCenter removeObserver:self];
}

- (SJBaseVideoPlayer *)player {
    if (nil == _player) {
        SJBaseVideoPlayer *player = [SJBaseVideoPlayer player];
        player.view.frame = EYScreenBounds;
        player.view.userInteractionEnabled = NO;
        [self insertSubview:player.view atIndex:0];
        player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:@""]];
        player.disableAutoRotation = YES;
//        player.autoPlay = NO;
        _player = player;
    }
    return _player;
}

@end
