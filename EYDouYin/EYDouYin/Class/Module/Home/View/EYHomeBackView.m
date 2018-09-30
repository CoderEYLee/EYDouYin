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
    EYLog(@"EYHomeBackView----%@", self.scrollView.subviews);

    EYHomeBackItemView *view = nil;
    CGFloat width = EYScreenWidth*0.2;
    NSUInteger count = array.count;

    // 创建对应个数的view 展示界面
    for (int i = 0; i < count; i++) {
        view = [EYHomeBackItemView homeBackItemView];
        view.frame = CGRectMake(width * i, 0, width, EYBackViewHeight);
        view.model = array[i];
        view.delegate = self;
        view.backgroundColor = EYRandomColor;
        [self.scrollView addSubview:view];
    }

    self.scrollView.contentSize = CGSizeMake(width * count, EYBackViewHeight);
}

#pragma mark - EYHomeBackItemViewDelegate
- (void)homeBackItemViewDidClick:(EYHomeBackItemView *)view {
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeBackViewDidSelectedModel:)]) {
        [self.delegate homeBackViewDidSelectedModel:view.model];
    }
}

@end
