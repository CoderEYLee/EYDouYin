//
//  EYZFPlayerViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/10/26.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYZFPlayerViewController.h"
#import "ZFPlayer.h"
#import "ZFAVPlayerManager.h"
#import "EYZFPlayerControlView.h"

@interface EYZFPlayerViewController ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) EYZFPlayerControlView *controlView;
@property (nonatomic, strong) ZFPlayerController *player;

@end

@implementation EYZFPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupVideoView];
}

- (void)setupVideoView {
    /// 播放器相关
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.containerView];
    self.player.assetURL = [NSURL URLWithString:@"http://video.chinlab.com/CLXXXYE1539069802307.mp4"];
    self.player.allowOrentitaionRotation = NO;
    self.controlView.portraitControlView.topToolView.hidden = YES;
    self.controlView.portraitControlView.playOrPauseBtn.hidden = YES;
    self.controlView.portraitControlView.currentTimeLabel.hidden = YES;
    self.controlView.portraitControlView.totalTimeLabel.hidden = YES;
    self.player.controlView = self.controlView;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, EYScreenWidth, EYScreenHeight)];
        _containerView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_containerView];
    }
    return _containerView;
}

- (EYZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [[EYZFPlayerControlView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _controlView.fastViewAnimated = YES;
    }
    return _controlView;
}

@end
