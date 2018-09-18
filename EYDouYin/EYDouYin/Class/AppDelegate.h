//
//  AppDelegate.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/22.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EYRootViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (weak, nonatomic, readonly) EYRootViewController *rootViewController;

@end

