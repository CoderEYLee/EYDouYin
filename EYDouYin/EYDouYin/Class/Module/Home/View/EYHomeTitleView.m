//
//  EYHomeTitleView.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/31.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYHomeTitleView.h"

@interface EYHomeTitleView()

@property (weak, nonatomic) IBOutlet UIButton *recommendButton;
@property (weak, nonatomic) IBOutlet UIButton *cityButton;

@end

@implementation EYHomeTitleView

- (void)awakeFromNib {
    [super awakeFromNib];

    [self setButtonDefaultState];

    self.recommendButton.selected = YES;
    self.recommendButton.titleLabel.font = [UIFont systemFontOfSize:19.0 weight:UIFontWeightBold];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.cityButton.titleLabel.textColor = EYColorAlpha(100, 100, 100, 1.0);
        self.cityButton.titleLabel.tintColor = EYColorAlpha(100, 100, 100, 1.0);
    });
}

- (void)setButtonDefaultState {
    [self.recommendButton setTitle:@"推荐" forState:UIControlStateNormal];
    [self.recommendButton setTitle:@"推荐" forState:UIControlStateSelected];
    [self.recommendButton setTitleColor:EYColorAlpha(100, 100, 100, 1.0) forState:UIControlStateNormal];
    [self.recommendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    self.recommendButton.titleLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightBold];

    [self.cityButton setTitle:@"同城" forState:UIControlStateNormal];
    [self.cityButton setTitle:@"同城" forState:UIControlStateSelected];
    [self.cityButton setTitleColor:EYColorAlpha(100, 100, 100, 1.0) forState:UIControlStateNormal];
    [self.cityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    self.cityButton.titleLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightBold];
}

#pragma mark - 初始化方法
+ (instancetype)homeTitleView {
    EYHomeTitleView * view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    view.frame = CGRectMake(0, 0, EYScreenWidth, 44);
    return view;
}

#pragma mark - 点击方法

- (IBAction)tapButton:(UIButton *)sender {
    [self setButtonDefaultState];
    sender.selected = YES;
    sender.titleLabel.font = [UIFont systemFontOfSize:19.0 weight:UIFontWeightBold];

    if (self.delegate && [self.delegate respondsToSelector:@selector(homeTitleView:didSelectedButton:)]) {
        [self.delegate homeTitleView:self didSelectedButton:sender.tag];
    }
}

@end
