//
//  EYHomePlayViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/5/31.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYHomePlayViewController.h"

@interface EYHomePlayViewController () <EYBaseVideoPlayerDelegate>

@property (strong, nonatomic, readwrite) EYBaseVideoPlayer *videoPlayer;
@property (weak, nonatomic) UIImageView *videoImageView;

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
    
    self.view.backgroundColor = EYColorClear;
    
    //2.图片
    UIImageView *videoImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    videoImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:videoImageView];
    self.videoImageView = videoImageView;
    
    //3.播放器
    [self.videoPlayer setupVideoWidget:videoImageView insertIndex:0];
}

- (void)setVideoModel:(EYVideoModel *)videoModel {
    
    if (_videoModel == videoModel) {
        EYLog(@"已经设置过了视频的首帧");
        return;
    }
    _videoModel = videoModel;
    
    [self.videoImageView ey_setImageWithURL:[NSURL URLWithString:videoModel.tt_video_img_normal] placeholderImage:[UIImage imageNamed:@"common_placeholder"]];
}

- (void)startPlayWithURLString:(NSString *)URLString {
    [self.videoPlayer startPlayWithURLString:URLString];
}

- (void)stopPlay {
    [self.videoPlayer stopPlay];
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
        videoPlayer.dissablePlaySameVideo = YES;
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
