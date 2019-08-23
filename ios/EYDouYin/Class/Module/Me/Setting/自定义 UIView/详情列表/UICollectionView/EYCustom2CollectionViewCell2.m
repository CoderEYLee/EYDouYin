//
//  EYCustom2CollectionViewCell2.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/8/23.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYCustom2CollectionViewCell2.h"

@implementation EYCustom2CollectionViewCell2

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = EYColorWhite0_2;
        self.layer.cornerRadius = 5.0;
    }
    return self;
}

- (UICollectionViewLayoutAttributes*)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes {
    CGFloat width = (EYScreenWidth - 17.0) / 3.0;
    
    CGRect frame = layoutAttributes.frame;
    frame.size.height = layoutAttributes.bounds.size.height;
    layoutAttributes.frame = frame;

    return [super preferredLayoutAttributesFittingAttributes:layoutAttributes];

}

@end
