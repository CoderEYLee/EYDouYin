//
//  EYFlowLayout.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/11/1.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYFlowLayout.h"

@implementation EYFlowLayout

/**
 * 当collectionView的显示范围发生改变的时候，是否需要重新刷新布局
 * 一旦重新刷新布局，就会重新调用下面的方法：
 1.prepareLayout
 2.layoutAttributesForElementsInRect:方法
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {

    return YES;
}

/**
 UICollectionViewLayoutAttributes *attrs;
 1.一个cell对应一个UICollectionViewLayoutAttributes对象
 2.UICollectionViewLayoutAttributes对象决定了cell的frame
 这个方法的返回值是一个数组（数组里面存放着rect范围内所有元素的布局属性）
 * 这个方法的返回值决定了rect范围内所有元素的排布（frame）
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *layoutAttrs = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];

    //collectionView中心点的位置
    CGFloat collectionViewCenterX = self.collectionView.bounds.size.width * 0.5 + self.collectionView.contentOffset.x;
    for (UICollectionViewLayoutAttributes *attrs in layoutAttrs) {
        //item距离collectionView中点的位置距离
        CGFloat delta = ABS(collectionViewCenterX - attrs.center.x);

        CGFloat scale = 1 - delta / self.collectionView.bounds.size.width;

        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }

    return layoutAttrs;
}

/**
 重写targetContentOffsetForProposedContentOffset:withScrollingVelocity:方法
 作用：返回值决定了collectionView停止滚动时最终的偏移量（contentOffset）
 参数：
 - proposedContentOffset：原本情况下，collectionView停止滚动时最终的偏移量
 - velocity：滚动速率，通过这个参数可以了解滚动的方向
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    //目的的位置，然后计算与中心点的距离 最小的那一个就 = 中心点的位置。

    NSArray *layoutAttrs = [self layoutAttributesForElementsInRect:CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height)];

    CGFloat centerX = self.collectionView.bounds.size.width * 0.5 + proposedContentOffset.x;
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in layoutAttrs) {
        if (!CGRectIntersectsRect(CGRectMake(proposedContentOffset.x, proposedContentOffset.y, self.collectionView.frame.size.width, self.collectionView.frame.size.height), attrs.frame))continue;
        CGFloat delta = ABS(attrs.center.x - centerX);
        if (delta < ABS(minDelta)) {
            minDelta = attrs.center.x - centerX;
        }
    }
    return CGPointMake(proposedContentOffset.x + minDelta, proposedContentOffset.y);
}

/**
 *  用来做布局的初始化操作（不建议在init方法中进行布局的初始化操作）
 作用：在这个方法中做一些初始化操作
 注意：一定要调用[super prepareLayout]
 */
- (void)prepareLayout {

    [super prepareLayout];

    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat height = self.collectionView.bounds.size.height * 0.5;
    self.itemSize = CGSizeMake(height, height);
}

@end
