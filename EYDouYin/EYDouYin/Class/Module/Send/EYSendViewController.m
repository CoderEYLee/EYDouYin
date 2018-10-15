//
//  EYSendViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/23.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYSendViewController.h"
#import "ZFPlayer.h"
#import "ZFAVPlayerManager.h"
#import "EYZFPlayerControlView.h"

@interface EYSendViewController ()


@property (nonatomic, strong) ZFPlayerController *player;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) EYZFPlayerControlView *controlView;

@end

@implementation EYSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = EYRandomColor;
    EYLog(@"EYSendViewController--viewDidLoad");
    
    UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    closeButton.backgroundColor = EYRandomColor;
    [closeButton addTarget:self action:@selector(tapCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];

    // 默认方式加载多语言
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    label.backgroundColor = EYRandomColor;
    label.text = [NSString stringWithFormat:EYLocalized(@"测试"), @"123"];
    [self.view addSubview:label];

    [self setupVideoView];
}

- (void)tapCloseButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
//    self.controlView.portraitControlView.backgroundColor = [UIColor whiteColor];
    //    self.player.currentPlayerManager
    //    [self.player.currentPlayerManager play];
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
