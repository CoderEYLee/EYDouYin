
//
//  EYAliViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/9/12.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYAliViewController.h"
#import "EYBaseAliVideoPlayer.h"

@interface EYAliViewController ()

@property (strong, nonatomic) EYBaseAliVideoPlayer *aliVideoPlayer;

@end

@implementation EYAliViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 初始化界面
    [self setupUI];
}

//1. 初始化界面
- (void)setupUI {
    //1.1初始化播放器
    EYBaseAliVideoPlayer *aliVideoPlayer = [[EYBaseAliVideoPlayer alloc] init];
    aliVideoPlayer.playerView = self.view;
    AVPUrlSource *urlSource = [[AVPUrlSource alloc] urlWithString:@"http://video.chinlab.com/CLXXXYE1539069802307.mp4"];
    [aliVideoPlayer setUrlSource:urlSource];
    
    //1.2 准备
    [aliVideoPlayer prepare];
    [aliVideoPlayer start];
    
    self.aliVideoPlayer = aliVideoPlayer;
}

- (void)dealloc {
    [self.aliVideoPlayer destroy];
}

@end
