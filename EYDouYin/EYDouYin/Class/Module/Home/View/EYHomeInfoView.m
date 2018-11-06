//
//  EYHomeInfoView.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/31.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYHomeInfoView.h"
#import "EYHomeVideoModel.h"

@interface EYHomeInfoView ()

@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation EYHomeInfoView

+ (instancetype)homeInfoView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:[self alloc] options:nil] lastObject];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView * view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].firstObject;
        view.frame = self.bounds;
        [self addSubview:view];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIView *view = [[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] instantiateWithOwner:self options:nil].firstObject;
        view.frame = self.bounds;
        [self addSubview:view];
    }
    return self;
}

- (void)setVideoModel:(EYHomeVideoModel *)videoModel {
    _videoModel = videoModel;

    self.titleLabel.text = videoModel.title;
    [self.locationButton setTitle:videoModel.location forState:UIControlStateNormal];
}

@end
