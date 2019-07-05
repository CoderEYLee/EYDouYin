//
//  EYTabBarController.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/22.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EYTabBarView.h"
@class EYHomeViewController;

@class EYTabBarController;

@protocol EYTabBarControllerDelegate<NSObject>
@optional
- (void)tabBarControllerDidSelectedIndex:(EYTabBarViewType)index;

@end

@interface EYTabBarController : UITabBarController

@property (weak, nonatomic) EYHomeViewController *homeVC;


@property (nullable, nonatomic, weak) id <EYTabBarControllerDelegate, UITabBarControllerDelegate> delegate;

@end
