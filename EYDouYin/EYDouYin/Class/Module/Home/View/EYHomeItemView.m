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

@property (weak, nonatomic) NSTimer * timer;

@end

@implementation EYHomeItemView

NSString *const EYHomeItemViewSystemVolumeDidChangeNotification=@"AVSystemController_SystemVolumeDidChangeNotification";

#pragma mark - 初始化方法
- (void)awakeFromNib {
    [super awakeFromNib];

    self.homeSharedView.delegate = self;

    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    self.volumeProgressLabel.mj_w = EYScreenWidth * audioSession.outputVolume;

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

- (void)dealloc {
    [EYNotificationCenter removeObserver:self];
}

@end
