//
//  EYHomeItemView.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/26.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYHomeItemView.h"

@interface EYHomeItemView()

@end

@implementation EYHomeItemView

+ (instancetype)homeItemView {
    EYHomeItemView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([EYHomeItemView class]) owner:nil options:nil] lastObject];
    view.frame = EYScreenBounds;
    return view;
}

@end
