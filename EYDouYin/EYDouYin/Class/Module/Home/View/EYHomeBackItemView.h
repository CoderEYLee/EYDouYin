//
//  EYHomeBackItemView.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/9/30.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EYHomeBackItemModel.h"

@class EYHomeBackItemView;

@protocol EYHomeBackItemViewDelegate<NSObject>
@optional
- (void)homeBackItemViewDidClick:(EYHomeBackItemView *)view;

@end

@interface EYHomeBackItemView : UIView

+ (instancetype)homeBackItemView;

@property (weak, nonatomic) id <EYHomeBackItemViewDelegate> delegate;

@property (strong, nonatomic) EYHomeBackItemModel * model;

@end
