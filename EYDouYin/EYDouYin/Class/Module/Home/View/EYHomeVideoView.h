//
//  EYHomeVideoView.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/26.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EYHomeInfoView.h"
#import "EYHomeSharedView.h"
#import "EYHomeVideoModel.h"

@interface EYHomeVideoView : UIView

+ (instancetype)homeItemView;

@property (weak, nonatomic, readonly) EYHomeInfoView *homeInfoView;
@property (weak, nonatomic, readonly) EYHomeSharedView *homeSharedView;

@property (strong, nonatomic) EYHomeVideoModel *videoModel;

#pragma mark - 视频相关的功能
- (void)playVideo;
- (void)stopVideo;


@end
