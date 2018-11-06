//
//  EYHomeSharedView.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/31.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYHomeSharedView.h"
#import "EYHomeVideoModel.h"

@interface EYHomeSharedView()

// 待定使用
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

#pragma mark - 显示层的 label
/**
 小心心
 */
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;

/**
 评论
 */
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

/**
 转发
 */
@property (weak, nonatomic) IBOutlet UILabel *forwardLabel;

@end

@implementation EYHomeSharedView

- (void)awakeFromNib {
    [super awakeFromNib];

    if (self.buttons.count) {
        UIButton *button = self.buttons.firstObject;
        [button changButtonWithLineColor:[UIColor whiteColor] lineWidth:2.0];
    }
}

#pragma mark - 初始化方法
+ (instancetype)homeSharedView {
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

#pragma mark - 点击方法
- (IBAction)tapButton:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeSharedView:didSeletedButton:)]) {
        [self.delegate homeSharedView:self didSeletedButton:sender.tag];
    }
}

- (void)setVideoModel:(EYHomeVideoModel *)videoModel {
    _videoModel = videoModel;
    if (self.buttons.count) {
        UIButton *headButton = self.buttons.firstObject;
        [headButton ey_setImageWithURL:[NSURL URLWithString:videoModel.user_head_url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"common_placeholder"] options:SDWebImageAllowInvalidSSLCertificates];
    }

    self.likeLabel.text = [NSString stringWithFormat:@"%lu", videoModel.likes.count];
    self.commentLabel.text = [NSString stringWithFormat:@"%lu", videoModel.comments.count];
    self.forwardLabel.text = [NSString stringWithFormat:@"%lu", videoModel.forwards.count];
}

@end
