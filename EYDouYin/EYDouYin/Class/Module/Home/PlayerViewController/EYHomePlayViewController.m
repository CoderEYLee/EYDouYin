//
//  EYHomePlayViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/5/31.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYHomePlayViewController.h"
#import "EYBaseVideoPlayer.h"

@interface EYHomePlayViewController () <EYBaseVideoPlayerDelegate>

@property (strong, nonatomic) EYBaseVideoPlayer *videoPlayer;

@end

@implementation EYHomePlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 初始化界面
    [self setupUI];
}

//1. 初始化界面
- (void)setupUI {
    //1.隐藏导航
    self.gk_navigationBar.hidden = YES;
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = EYColorRandom;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.name;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.height.mas_equalTo(200);
    }];
    
//    self.view.backgroundColor = EYColorRandom;
}

- (void)startPlayWithURLString:(NSString *)URLString {
    EYLog(@"开始播放");
    [self.videoPlayer setupVideoWidget:self.view insertIndex:0];
    [self.videoPlayer startPlayWithURLString:URLString];
}

#pragma mark - EYBaseVideoPlayerDelegate
- (void)baseVideoPlayerOnNetStatus:(EYBaseVideoPlayer *)baseVideoPlayer withParam:(NSDictionary *)param {
    // EYLog(@"baseVideoPlayerOnNetStatus==%@", baseVideoPlayer);
    
    
}

- (void)baseVideoPlayerOnPlayEvent:(EYBaseVideoPlayer *)baseVideoPlayer event:(int)EvtID withParam:(NSDictionary *)param {
    // EYLog(@"baseVideoPlayerOnPlayEvent");
}

#pragma mark - 懒加载
- (EYBaseVideoPlayer *)videoPlayer {
    if (nil == _videoPlayer) {
        EYBaseVideoPlayer *videoPlayer = [[EYBaseVideoPlayer alloc] init];
        videoPlayer.loop = YES;
        videoPlayer.isAutoPlay = YES;
        videoPlayer.renderMode = RENDER_MODE_FILL_SCREEN;
        videoPlayer.delegate = self;
        _videoPlayer = videoPlayer;
    }
    return _videoPlayer;
}

- (void)dealloc {
    [self.videoPlayer stopPlay];
    self.videoPlayer = nil;
}

@end
