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
    player.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:@"http://video.chinlab.com/CLXXXYE1539069802307.mp4"]];
    player.disableAutoRotation = YES;
    self.player = player;
}

@end
