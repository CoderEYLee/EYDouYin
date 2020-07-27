//
//  UIViewController+EYTopViewController.h
//  EYDouYin
//
//  Created by 李二洋 on 2020/7/27.
//  Copyright © 2020 李二洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (EYTopViewController)

/// 返回显示的控制器
- (UIViewController *)ey_visibleViewControllerIfExist;

@end

NS_ASSUME_NONNULL_END
