//
//  EYCircleLayout.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/10/31.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYCircleLayout.h"

@implementation EYCircleLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    attrs.size = CGSizeMake(50, 50);

    // 圆的半径
    CGFloat circleRadius = 70;
    CGPoint circleCenter = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5);
    // 每个item之间的角度
    CGFloat angleDelta = M_PI * 2 / [self.collectionView numberOfItemsInSection:indexPath.section];

    // 计算当前item的角度
    CGFloat angle = indexPath.item * angleDelta;

    attrs.center = CGPointMake(circleCenter.x + circleRadius * cosf(angle), circleCenter.y - circleRadius * sinf(angle));

    // z方向轴的大小, 越大在最上面
    attrs.zIndex = indexPath.item;

    return attrs;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *array = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i<count; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [array addObject:attrs];
    }
    return array;
}

@end
