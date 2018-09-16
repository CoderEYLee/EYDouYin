//
//  EYHomeItemView.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/26.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EYHomeInfoView.h"
#import "EYHomeSharedView.h"

@interface EYHomeItemView : UIView

+ (instancetype)homeItemView;

@property (weak, nonatomic, readonly) EYHomeInfoView *homeInfoView;

@property (weak, nonatomic, readonly) EYHomeSharedView *homeSharedView;

@end
