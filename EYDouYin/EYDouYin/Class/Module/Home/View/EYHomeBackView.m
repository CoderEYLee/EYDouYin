//
//  EYHomeBackView.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/9/25.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYHomeBackView.h"
#import "EYHomeBackItemView.h"

@interface EYHomeBackView() <EYHomeBackItemViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation EYHomeBackView

- (void)awakeFromNib {
    [super awakeFromNib];
}

+ (instancetype)homeBackView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)showWithArray:(NSArray *)array {
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    EYHomeBackItemView *view = nil;
    CGFloat width = EYScreenWidth*0.2;
    NSUInteger count = array.count;

    // 创建对应个数的view 展示界面
    for (int i = 0; i < count; i++) {
        view = [EYHomeBackItemView homeBackItemView];
        view.frame = CGRectMake(width * i, EYBackViewHeight, width, EYBackViewHeight);
        view.model = array[i];
        view.delegate = self;
        view.backgroundColor = EYColorRandom;
        [self.scrollView addSubview:view];
    }

    self.scrollView.contentSize = CGSizeMake(width * count, EYBackViewHeight);

    // 动画展示
    for (int i = 0; i < count; i++) {
        UIView *view = self.scrollView.subviews[i];
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        anim.fromValue = @(view.centerY);
        anim.toValue = @(view.centerY - EYBackViewHeight);
        // 弹力系数，取值范围 0~20，数值越大，弹性越大，默认数值为4
        anim.springBounciness = 8;
        // 弹力速度，取值范围 0~20，数值越大，速度越快，默认数值为12
        anim.springSpeed = 8;
        // 设置动画启动时间
        anim.beginTime = CACurrentMediaTime() + i * 0.1;
        [view pop_addAnimation:anim forKey:nil];
    }
}

- (void)close {
    NSArray *array = self.scrollView.subviews.reverseObjectEnumerator.allObjects;
    for (int i = 0; i < array.count; i++) {
        UIView *view = array[i];
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        anim.fromValue = @(view.centerY);
        anim.toValue = @(view.centerY + EYBackViewHeight);
        // 弹力系数，取值范围 0~20，数值越大，弹性越大，默认数值为4
        anim.springBounciness = 8;
        // 弹力速度，取值范围 0~20，数值越大，速度越快，默认数值为12
        anim.springSpeed = 8;
        // 设置动画启动时间
        anim.beginTime = CACurrentMediaTime() + i * 0.1;
        [view.layer pop_addAnimation:anim forKey:nil];
    }
}

#pragma mark - EYHomeBackItemViewDelegate
- (void)homeBackItemViewDidClick:(EYHomeBackItemView *)view {
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeBackViewDidSelectedModel:)]) {
        [self.delegate homeBackViewDidSelectedModel:view.model];
    }
}

@end
