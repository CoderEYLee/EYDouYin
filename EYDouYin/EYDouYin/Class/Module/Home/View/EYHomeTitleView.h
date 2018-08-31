//
//  EYHomeTitleView.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/31.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EYHomeTitleViewButtonType) {
    EYHomeTitleViewButtonTypeSearch,    //搜索
    EYHomeTitleViewButtonTypeMore,      //更多
    EYHomeTitleViewButtonTypeRecommend, //推荐
    EYHomeTitleViewButtonTypeCity,      //同城
};

@class EYHomeTitleView;

@protocol EYHomeTitleViewDelegate<NSObject>

@optional
- (void)homeTitleView:(EYHomeTitleView *)view didSelectedButton:(EYHomeTitleViewButtonType)buttonType;

@end

@interface EYHomeTitleView : UIView

+ (instancetype)homeTitleView;

@property (weak, nonatomic) id <EYHomeTitleViewDelegate> delegate;

@end
