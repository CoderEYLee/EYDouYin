//
//  EYHomeViewController.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/23.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYBaseViewController.h"

typedef NS_ENUM(NSInteger, EYHomeViewControllerButtonType) {
    EYHomeViewControllerButtonTypeRecommend,
    EYHomeViewControllerButtonTypeCity,
};

@interface EYHomeViewController : EYBaseViewController

@property (assign, nonatomic, readonly) EYHomeViewControllerButtonType type;

@end
