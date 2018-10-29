//
//  EYWaterflowView.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/10/29.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYWaterflowView.h"
#import "EYWaterflowViewCell.h"

#define EYWaterflowViewDefaultCellH 70
#define EYWaterflowViewDefaultMargin 8
#define EYWaterflowViewDefaultNumberOfColumns 3

@interface EYWaterflowView()
/**
 *  所有cell的frame数据
 */
@property (nonatomic, strong) NSMutableArray *cellFrames;
/**
 *  正在展示的cell
 */
@property (nonatomic, strong) NSMutableDictionary *displayingCells;
/**
 *  缓存池（用Set，存放离开屏幕的cell）
 */
@property (nonatomic, strong) NSMutableSet *reusableCells;

@end

@implementation EYWaterflowView
@synthesize delegate = _delegate;

//即将显示到父控件上面
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self reloadData];
}

#pragma mark - 公共接口
/**
 *  cell的宽度
 */
- (CGFloat)cellWidth {
    // 总列数
    NSUInteger numberOfColumns = [self numberOfColumns];
    CGFloat leftM = [self marginForType:EYWaterflowViewMarginTypeLeft];
    CGFloat rightM = [self marginForType:EYWaterflowViewMarginTypeRight];
    CGFloat columnM = [self marginForType:EYWaterflowViewMarginTypeColumn];
    return (self.bounds.size.width - leftM - rightM - (numberOfColumns - 1) * columnM) / numberOfColumns;
}

/**
 *  刷新数据
 */
- (void)reloadData {
    // 清空之前的所有数据
    // 移除正在正在显示cell
    [self.displayingCells.allValues makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.displayingCells removeAllObjects];
    [self.cellFrames removeAllObjects];
    [self.reusableCells removeAllObjects];

    // cell的总数
    NSUInteger numberOfCells = [self.dataSource numberOfCellsInWaterflowView:self];

    // 总列数
    NSUInteger numberOfColumns = [self numberOfColumns];

    // 间距
    CGFloat topM = [self marginForType:EYWaterflowViewMarginTypeTop];
    CGFloat bottomM = [self marginForType:EYWaterflowViewMarginTypeBottom];
    CGFloat leftM = [self marginForType:EYWaterflowViewMarginTypeLeft];
    CGFloat columnM = [self marginForType:EYWaterflowViewMarginTypeColumn];
    CGFloat rowM = [self marginForType:EYWaterflowViewMarginTypeRow];

    // cell的宽度
    CGFloat cellW = [self cellWidth];

    // 用一个C语言数组存放所有列的最大Y值
    CGFloat maxYOfColumns[numberOfColumns];
    for (int i = 0; i<numberOfColumns; i++) {
        maxYOfColumns[i] = 0.0;
    }

    // 计算所有cell的frame
    for (int i = 0; i<numberOfCells; i++) {
        // cell处在第几列(最短的一列)
        NSUInteger cellColumn = 0;
        // cell所处那列的最大Y值(最短那一列的最大Y值)
        CGFloat maxYOfCellColumn = maxYOfColumns[cellColumn];
        // 求出最短的一列
        for (int j = 1; j<numberOfColumns; j++) {
            if (maxYOfColumns[j] < maxYOfCellColumn) {
                cellColumn = j;
                maxYOfCellColumn = maxYOfColumns[j];
            }
        }

        // 询问代理i位置的高度
        CGFloat cellH = [self heightAtIndex:i];

        // cell的位置
        CGFloat cellX = leftM + cellColumn * (cellW + columnM);
        CGFloat cellY = 0;
        if (maxYOfCellColumn == 0.0) { // 首行
            cellY = topM;
        } else {
            cellY = maxYOfCellColumn + rowM;
        }

        // 添加frame到数组中
        CGRect cellFrame = CGRectMake(cellX, cellY, cellW, cellH);
        [self.cellFrames addObject:[NSValue valueWithCGRect:cellFrame]];

        // 更新最短那一列的最大Y值
        maxYOfColumns[cellColumn] = CGRectGetMaxY(cellFrame);
    }

    // 设置contentSize
    CGFloat contentH = maxYOfColumns[0];
    for (int j = 1; j<numberOfColumns; j++) {
        if (maxYOfColumns[j] > contentH) {
            contentH = maxYOfColumns[j];
        }
    }
    contentH += bottomM;
    self.contentSize = CGSizeMake(0, contentH);
}

/**
 *  当UIScrollView滚动的时候也会调用这个方法
 */
- (void)layoutSubviews {
    [super layoutSubviews];

    // 向数据源索要对应位置的cell
    NSUInteger numberOfCells = self.cellFrames.count;
    for (int i = 0; i<numberOfCells; i++) {
        // 取出i位置的frame
        CGRect cellFrame = [self.cellFrames[i] CGRectValue];

        // 优先从字典中取出i位置的cell
        EYWaterflowViewCell *cell = self.displayingCells[@(i)];

        // 判断i位置对应的frame在不在屏幕上（能否看见）
        if ([self isInScreen:cellFrame]) { // 在屏幕上
            if (cell == nil) {
                cell = [self.dataSource waterflowView:self cellAtIndex:i];
                cell.frame = cellFrame;
                [self addSubview:cell];

                // 存放到字典中
                self.displayingCells[@(i)] = cell;
            }
        } else {  // 不在屏幕上
            if (cell) {
                // 从scrollView和字典中移除
                [cell removeFromSuperview];
                [self.displayingCells removeObjectForKey:@(i)];

                // 存放进缓存池
                [self.reusableCells addObject:cell];
            }
        }
    }
}

- (__kindof EYWaterflowViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    __block EYWaterflowViewCell *reusableCell = nil;

    [self.reusableCells enumerateObjectsUsingBlock:^(EYWaterflowViewCell *cell, BOOL *stop) {
        if ([cell.reuseIdentifier isEqualToString:identifier]) {
            reusableCell = cell;
            *stop = YES;
        }
    }];

    if (reusableCell) { // 从缓存池中移除
        [self.reusableCells removeObject:reusableCell];
    }
    return reusableCell;
}

#pragma mark - 私有方法
/**
 *  判断一个frame有无显示在屏幕上
 */
- (BOOL)isInScreen:(CGRect)frame {
    return (CGRectGetMaxY(frame) > self.contentOffset.y) &&
    (CGRectGetMinY(frame) < self.contentOffset.y + self.bounds.size.height);
}

/**
 *  间距
 */
- (CGFloat)marginForType:(EYWaterflowViewMarginType)type {
    if ([self.delegate respondsToSelector:@selector(waterflowView:marginForType:)]) {
        return [self.delegate waterflowView:self marginForType:type];
    } else {
        return EYWaterflowViewDefaultMargin;
    }
}
/**
 *  总列数
 */
- (NSUInteger)numberOfColumns {
    if ([self.dataSource respondsToSelector:@selector(numberOfColumnsInWaterflowView:)]) {
        return [self.dataSource numberOfColumnsInWaterflowView:self];
    } else {
        return EYWaterflowViewDefaultNumberOfColumns;
    }
}
/**
 *  index位置对应的高度
 */
- (CGFloat)heightAtIndex:(NSUInteger)index {
    if ([self.delegate respondsToSelector:@selector(waterflowView:heightAtIndex:)]) {
        return [self.delegate waterflowView:self heightAtIndex:index];
    } else {
        return EYWaterflowViewDefaultCellH;
    }
}

#pragma mark - 事件处理
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![self.delegate respondsToSelector:@selector(waterflowView:didSelectAtIndex:)]) return;

    // 获得触摸点
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];

    __block NSNumber *selectIndex = nil;
    [self.displayingCells enumerateKeysAndObjectsUsingBlock:^(id key, EYWaterflowViewCell *cell, BOOL *stop) {
        if (CGRectContainsPoint(cell.frame, point)) {
            selectIndex = key;
            *stop = YES;
        }
    }];

    if (selectIndex) {
        [self.delegate waterflowView:self didSelectAtIndex:selectIndex.unsignedIntegerValue];
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)cellFrames {
    if (_cellFrames == nil) {
        self.cellFrames = [NSMutableArray array];
    }
    return _cellFrames;
}

- (NSMutableDictionary *)displayingCells {
    if (_displayingCells == nil) {
        self.displayingCells = [NSMutableDictionary dictionary];
    }
    return _displayingCells;
}

@end
