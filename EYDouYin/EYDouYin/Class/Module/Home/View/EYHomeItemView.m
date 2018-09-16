//
//  EYHomeItemView.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/26.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYHomeItemView.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface EYHomeItemView() <EYHomeSharedViewDelegate>

@property (weak, nonatomic, readwrite) IBOutlet EYHomeInfoView *homeInfoView;
@property (weak, nonatomic, readwrite) IBOutlet EYHomeSharedView *homeSharedView;
@property (weak, nonatomic) IBOutlet UILabel *volumeProgressLabel;


@end

@implementation EYHomeItemView

NSString *const EYHomeItemViewSystemVolumeDidChangeNotification=@"AVSystemController_SystemVolumeDidChangeNotification";

#pragma mark - 初始化方法
- (void)awakeFromNib {
    [super awakeFromNib];

    self.homeSharedView.delegate = self;

    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    self.volumeProgressLabel.mj_w = EYScreenWidth * audioSession.outputVolume;

    [self addSubview:[self getSystemVolumSlider]];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeChange:) name:EYHomeItemViewSystemVolumeDidChangeNotification object:nil];
}

+ (instancetype)homeItemView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([EYHomeItemView class]) owner:nil options:nil] lastObject];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([EYHomeItemView class]) owner:nil options:nil] lastObject];
        self.frame = frame;
    }
    return self;
}

- (void)volumeChange:(NSNotification*)notifi{
    NSString * style = [notifi.userInfo objectForKey:@"AVSystemController_AudioCategoryNotificationParameter"];
    CGFloat value = [[notifi.userInfo objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"] doubleValue];
    if ([style isEqualToString:@"Audio/Video"]){
        self.volumeProgressLabel.hidden = NO;
        self.volumeProgressLabel.mj_w = EYScreenWidth * value;

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.volumeProgressLabel.hidden = YES;
        });
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

#pragma mark - 音量控制
/*
 * 获取系统音量滑块
 */
- (UIView *)getSystemVolumSlider{
    UIView * view = nil;
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    for (UIView *newView in volumeView.subviews) {
        if ([newView.class.description isEqualToString:@"MPVolumeSlider"]){
            newView.frame = CGRectMake(EYScreenWidth, EYScreenHeight, 1, 1);
            view = newView;
            break;
        }
    }
    return view;
}

- (void)dealloc {
    [EYNotificationCenter removeObserver:self];
}

@end
