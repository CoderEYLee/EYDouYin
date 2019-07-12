//
//  EYTestView.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/7/10.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYTestView.h"

@interface EYTestView()
    
@property (weak, nonatomic) YYLabel *tt_titleLabel;

@end

@implementation EYTestView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        EYLog(@"redview==%@", NSStringFromCGRect(frame));
        
        YYLabel *tt_titleLabel = [[YYLabel alloc] init];
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
    
    NSMutableAttributedString *attributedStringM = [[NSMutableAttributedString alloc] initWithString:videoModel.video_title];
    attributedStringM.yy_font = EYSizeFont14;
    attributedStringM.yy_lineSpacing = 7.5;
    attributedStringM.yy_color = EYColorRed;
    self.tt_titleLabel.attributedText = attributedStringM;
    
    // 完全控制:
    YYTextLinePositionSimpleModifier *modifier = [YYTextLinePositionSimpleModifier new];
    modifier.fixedLineHeight = 22;

    YYTextContainer *container = [YYTextContainer new];
    container.size = CGSizeMake(380, CGFLOAT_MAX);
    container.linePositionModifier = modifier;

    YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:attributedStringM];
    CGSize size = layout.textBoundingSize;
//    self.tt_titleLabel.size = size;
//    self.tt_titleLabel.textLayout = layout;
    self.frame = CGRectMake(0, 0, size.width + 20, size.height + 20);
}

@end
