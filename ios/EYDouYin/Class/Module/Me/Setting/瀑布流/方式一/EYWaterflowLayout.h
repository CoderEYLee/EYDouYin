//
//  EYWaterflowLayout.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/10/29.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@class EYWaterflowLayout;

@protocol EYWaterflowLayoutDelegate <NSObject>
- (CGFloat)waterflowLayout:(EYWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end

@interface EYWaterflowLayout : UICollectionViewLayout

@property (nonatomic, assign) UIEdgeInsets sectionInset;
/** 每一列之间的间距 */
@property (nonatomic, assign) CGFloat columnMargin;
/** 每一行之间的间距 */
@property (nonatomic, assign) CGFloat rowMargin;
/** 显示多少列 */
@property (nonatomic, assign) int columnsCount;

@property (nonatomic, weak) id<EYWaterflowLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
