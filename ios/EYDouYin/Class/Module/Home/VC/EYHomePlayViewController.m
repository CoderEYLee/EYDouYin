//
//  EYHomePlayViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/5/31.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYHomePlayViewController.h"
#import "EYBaseTXVideoPlayer.h"
#import "EYLikeAnimation.h"

@interface EYHomePlayViewController () <EYBaseTXVideoPlayerDelegate>

@property (strong, nonatomic) EYBaseTXVideoPlayer *videoPlayer;
@property (weak, nonatomic) UIImageView *videoImageView;

@property (weak, nonatomic) UIButton *playbutton;
@property (assign, nonatomic) NSTimeInterval lastTouchTime;

@end

@implementation EYHomePlayViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化界面
    [self setupUI];
    
    //2.设置数据
    [self setupData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.playbutton.selected) {
        
    } else {
        [self resumePlay];
    }
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
    
    //3.播放按钮
    UIButton *playbutton = [[UIButton alloc] initWithFrame:self.view.bounds];
    [playbutton setImage:[UIImage imageNamed:@"common_video_pause"] forState:UIControlStateSelected];
    playbutton.selected = NO;
    playbutton.userInteractionEnabled = NO;
    [playbutton addTarget:self action:@selector(tapPlayButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playbutton];
    self.playbutton = playbutton;
}

//2.设置数据
- (void)setupData {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    NSTimeInterval timestamp = touches.anyObject.timestamp;
    if (timestamp - self.lastTouchTime > 0.25) {//单击
        [self performSelector:@selector(touchPauseOrResume) withObject:nil afterDelay:0.25];
    } else {//双击
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(touchPauseOrResume) object:nil];
        
        [[EYLikeAnimation shareInstance] createAnimationWithTouch:touches withEvent:event];
    }
    
    self.lastTouchTime = timestamp;
}

- (void)touchPauseOrResume {
    if (self.isPlaying) {
        [self pausePlay];
    } else {
        [self resumePlay];
    }
}

- (void)setVideoModel:(EYVideoModel *)videoModel {
    _videoModel = videoModel;
    
    // 1.恢复按钮状态
    self.playbutton.selected = NO;
    
    //2.缓存视频
    self.videoPlayer.isAutoPlay = NO;
    [self.videoPlayer startPlayWithURLString:videoModel.ey_video_name];
    
    //3.视频首帧图片
    [self.videoImageView ey_setImageWithURL:[NSURL URLWithString:videoModel.ey_video_img_normal] placeholderImage:[UIImage imageNamed:@"common_placeholder"]];
}

#pragma mark - Public Methods
- (void)setIsAutoPlay:(BOOL)isAutoPlay {
    _isAutoPlay = isAutoPlay;
    
    self.videoPlayer.isAutoPlay = isAutoPlay;
}

///开始播放视频
- (void)startPlayWithURLString:(NSString *)TX_URLString {
    [self.videoPlayer startPlayWithURLString:TX_URLString];
}

///暂停播放
- (void)pausePlay {
    self.isAutoPlay = YES;
    [self.videoPlayer pausePlay];
    
    self.playbutton.selected = YES;
}

///恢复播放
- (void)resumePlay {
    // 1.恢复按钮状态
    self.playbutton.selected = NO;
    
    self.isAutoPlay = YES;
    [self.videoPlayer resumePlay];
}

///停止播放
- (void)stopPlay {
    // 1.恢复按钮状态
    self.playbutton.selected = NO;
    
    [self.videoPlayer stopPlay];
    self.isAutoPlay = NO;
}

///移除播放
- (void)removePlay {
    // 1.恢复按钮状态
    self.playbutton.selected = NO;
    
    [self.videoPlayer removePlay];
    self.isAutoPlay = NO;
}

- (BOOL)isPlaying {
    return self.videoPlayer.isPlaying;
}

#pragma mark - Private Methods
- (void)tapPlayButton:(UIButton *)button {
    button.selected = !button.isSelected;
    
    if (button.isSelected) {//暂停播放
        [self.videoPlayer pausePlay];
    } else {//恢复播放
        [self.videoPlayer resumePlay];
    }
}

#pragma mark - EYBaseTXVideoPlayerDelegate
- (void)baseVideoPlayerOnNetStatus:(EYBaseTXVideoPlayer *)baseVideoPlayer withParam:(NSDictionary *)param {
//     EYLog(@"baseVideoPlayerOnNetStatus==%@", baseVideoPlayer);
}

- (void)baseVideoPlayerOnPlayEvent:(EYBaseTXVideoPlayer *)baseVideoPlayer event:(int)EvtID withParam:(NSDictionary *)param {
//    EYLog(@"baseVideoPlayerOnPlayEvent");
    switch (EvtID) {
        case PLAY_EVT_PLAY_LOADING:{// loading
            
            break;
        }
        case PLAY_EVT_PLAY_BEGIN:{// 开始播放
            
            break;
        }
        case PLAY_EVT_PLAY_END:{// 播放结束
            
            break;
        }
        case PLAY_ERR_NET_DISCONNECT:{// 失败，多次重连无效
            
            break;
        }
        case PLAY_EVT_PLAY_PROGRESS:{// 进度
            if (baseVideoPlayer.isPlaying) {
                if (self.ey_visibleViewControllerIfExist == self) {
                    
                } else {
                    [baseVideoPlayer pausePlay];
                }
            }
//            float currTime = [param[EVT_PLAY_PROGRESS] floatValue];
//            EYLog(@"PLAY_EVT_PLAY_PROGRESS==%f==%d", currTime, baseVideoPlayer.isPlaying);
//            self.playbutton.selected = !baseVideoPlayer.isPlaying;
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - 懒加载
- (EYBaseTXVideoPlayer *)videoPlayer {
    if (nil == _videoPlayer) {
        EYBaseTXVideoPlayer *videoPlayer = [[EYBaseTXVideoPlayer alloc] init];
        videoPlayer.loop = YES;
        videoPlayer.isAutoPlay = NO;
        videoPlayer.renderMode = RENDER_MODE_FILL_SCREEN;
        videoPlayer.dissablePlaySameVideo = YES;
        videoPlayer.delegate = self;
        _videoPlayer = videoPlayer;
    }
    return _videoPlayer;
}

- (void)dealloc {
    self.videoPlayer = nil;
}

@end
