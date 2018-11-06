//
//  EYSJVideoPlayerViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/10/26.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYSJVideoPlayerViewController.h"

@interface EYSJVideoPlayerViewController ()

@property (strong, nonatomic) SJVideoPlayer *player;

@end

@implementation EYSJVideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    SJVideoPlayer *player = [SJVideoPlayer player];
    player.view.frame = self.view.bounds;
    [self.view addSubview:player.view];
    player.disableAutoRotation = YES;
    player.autoPlay = NO;
    self.player = player;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:@"http://video.chinlab.com/CLXXXYE1539069802307.mp4"]];
    [self.player.playbackController prepareToPlay];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.player play];
    });
}

@end
