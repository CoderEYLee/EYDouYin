//
//  EYWaterflowView.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/10/29.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    EYWaterflowViewMarginTypeTop,
    EYWaterflowViewMarginTypeBottom,
    EYWaterflowViewMarginTypeLeft,
    EYWaterflowViewMarginTypeRight,
    EYWaterflowViewMarginTypeColumn, // 每一列
    EYWaterflowViewMarginTypeRow,    // 每一行
} EYWaterflowViewMarginType;

@class EYWaterflowView, EYWaterflowViewCell;

@protocol EYWaterflowViewDataSource <NSObject>
@required

/**
 一共有多少个数据

 @param waterflowView 瀑布流控件
 @return 数据的个数
 */
- (NSUInteger)numberOfCellsInWaterflowView:(EYWaterflowView *)waterflowView;

/**
 对应index位置对应的cell

 @param waterflowView 瀑布流控件
 @param index 下标
 @return 对应的cell
 */
- (EYWaterflowViewCell *)waterflowView:(EYWaterflowView *)waterflowView cellAtIndex:(NSUInteger)index;

@optional

/**
 一共有多少列

 @param waterflowView 瀑布流控件
 @return 列的个数
 */
- (NSUInteger)numberOfColumnsInWaterflowView:(EYWaterflowView *)waterflowView;
@end

@protocol EYWaterflowViewDelegate <UIScrollViewDelegate>
@optional

/**
 index位置cell对应的高度

 @param waterflowView 瀑布流控件
 @param index 下标
 @return 对应的高度
 */
- (CGFloat)waterflowView:(EYWaterflowView *)waterflowView heightAtIndex:(NSUInteger)index;

/**
 index位置的cell

 @param waterflowView 瀑布流控件
 @param index 选中的下标
 */
- (void)waterflowView:(EYWaterflowView *)waterflowView didSelectAtIndex:(NSUInteger)index;

/**
 设置间距

 @param waterflowView 瀑布流控件
 @param type 瀑布流控件的间距(枚举)
 @return 对应方向的间距
 */
- (CGFloat)waterflowView:(EYWaterflowView *)waterflowView marginForType:(EYWaterflowViewMarginType)type;
@end

@interface EYWaterflowView : UIScrollView

@property (nonatomic, weak) id<EYWaterflowViewDataSource> dataSource;
@property (nonatomic, weak) id<EYWaterflowViewDelegate> delegate;

/**
 刷新数据（只要调用这个方法，会重新向数据源和代理发送请求，请求数据）
 */
- (void)reloadData;

/**
 cell的宽度

 @return cell的宽度
 */
- (CGFloat)cellWidth;

/**
 根据标识去缓存池查找可循环利用的cell

 @param identifier 重用标识符
 @return 对应的cell
 */
- (__kindof EYWaterflowViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
