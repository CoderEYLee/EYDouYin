//
//  EYHomeInfoView.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/31.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EYHomeVideoModel;

@interface EYHomeInfoView : UIView

+ (instancetype)homeInfoView;

@property (strong, nonatomic) EYHomeVideoModel *videoModel;

@end
