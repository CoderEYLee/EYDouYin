//
//  EYHomeBackView.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/9/25.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EYHomeBackItemModel.h"

@class EYHomeBackView;

@protocol EYHomeBackViewDelegate<NSObject>
@optional
- (void)homeBackViewDidSelectedModel:(EYHomeBackItemModel *)model;

@end

@interface EYHomeBackView : UIView

/**
 初始化方法

 @return 返回XIB 定义的对象
 */
+ (instancetype)homeBackView;

@property (weak, nonatomic) id <EYHomeBackViewDelegate> delegate;

/**
 开始展示的动画
 */
- (void)showWithArray:(NSArray *)array;

@end
