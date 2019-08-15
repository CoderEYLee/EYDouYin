//
//  EYCustomFitView2.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/7/23.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYCustomFitView2.h"

@interface EYCustomFitView2()

@property (weak, nonatomic) UILabel *tt_titleLabel;

@end

@implementation EYCustomFitView2

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *tt_titleLabel = [[UILabel alloc] init];
        tt_titleLabel.numberOfLines = 0;
        tt_titleLabel.backgroundColor = EYColorBlue;
        [self addSubview:tt_titleLabel];
        self.tt_titleLabel = tt_titleLabel;
        [tt_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
            make.bottom.right.mas_equalTo(-10);
        }];
    }
    return self;
}

- (void)setVideoModel:(EYVideoModel *)videoModel {
    _videoModel = videoModel;
    
    self.tt_titleLabel.text = videoModel.video_title;
    
    self.frame = CGRectMake(0, 0, EYScreenWidth, 200 + 20);
}

@end
