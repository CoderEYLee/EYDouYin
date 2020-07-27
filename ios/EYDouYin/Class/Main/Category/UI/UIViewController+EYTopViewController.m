//
//  UIViewController+EYTopViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2020/7/27.
//  Copyright © 2020 李二洋. All rights reserved.
//

#import "UIViewController+EYTopViewController.h"

@implementation UIViewController (EYTopViewController)


- (UIViewController *)ey_visibleViewControllerIfExist {
    
    if (self.presentedViewController) {
        return [self.presentedViewController ey_visibleViewControllerIfExist];
    }
    
    if ([self isKindOfClass:[UINavigationController class]]) {
        return [((UINavigationController *)self).topViewController ey_visibleViewControllerIfExist];
    }
    
    if ([self isKindOfClass:[UITabBarController class]]) {
        return [((UITabBarController *)self).selectedViewController ey_visibleViewControllerIfExist];
    }
    
    if ([self isViewLoaded] && self.view.window) {
        return self;
    } else {
        EYLog(@"找不到可见的控制器，viewcontroller.self = %@, self.view.window = %@", self, self.view.window);
        return nil;
    }
}


@end
