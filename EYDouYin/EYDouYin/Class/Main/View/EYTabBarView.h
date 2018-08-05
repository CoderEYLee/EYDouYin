//
//  EYTabBarView.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/5.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EYTabBarView;

typedef NS_ENUM(NSInteger, EYTabBarViewType) {
    EYTabBarViewTypeHome, //首页
    EYTabBarViewTypeLike, //关注
    EYTabBarViewTypePlus, //+
    EYTabBarViewTypeMessage,//消息
    EYTabBarViewTypeMe,//我
};

@protocol EYTabBarViewDelegate<NSObject>

@optional
- (void)tabBarView:(EYTabBarView *)tabBarView didSelectedIndex:(NSInteger)index;

@end

@interface EYTabBarView : UIView

+ (instancetype)tabBarView;

@property (weak, nonatomic) id <EYTabBarViewDelegate> delegate;

@end
