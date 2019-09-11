//
//  EYCustom2CollectionViewCell1.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/8/23.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYCustom2CollectionViewCell1.h"

@interface EYCustom2CollectionViewCell1()

@property (weak, nonatomic) UILabel *tt_titleLabel;

@end

@implementation EYCustom2CollectionViewCell1

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = EYColorRed;
        
        UILabel *tt_titleLabel = [[UILabel alloc] init];
        tt_titleLabel.backgroundColor = EYColorRandom;
        tt_titleLabel.numberOfLines = 0;
        tt_titleLabel.text = @"123456djsfhdsifgsdhiuashfuihsdiufbasdi123456djsfhdsifgsdhiuashfuihsdiufbasdi123456djsfhdsifgsdhiuashfuihsdiufbasdi123456djsfhdsifgsdhiuashfuihsdiufbasdi123456djsfhdsifgsdhiuashfuihsdiufbasdi123456djsfhdsifgsdhiuashfuihsdiufbasdi123456djsfhdsifgsdhiuashfuihsdiufbasdi123456djsfhdsifgsdhiuashfuihsdiufbasdi";
        [self.contentView addSubview:tt_titleLabel];
        self.tt_titleLabel = tt_titleLabel;
        
        [tt_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
//            make.height.mas_greaterThanOrEqualTo(5).priorityLow();
        }];
    }
    return self;
}

- (UICollectionViewLayoutAttributes*)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes {
    CGRect frame = layoutAttributes.frame;
    frame.size.width = EYScreenWidth - 8.0;
    layoutAttributes.frame = frame;

    return layoutAttributes;
}

@end
