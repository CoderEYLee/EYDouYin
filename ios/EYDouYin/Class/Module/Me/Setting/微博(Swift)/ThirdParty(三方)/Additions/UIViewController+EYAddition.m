//
//  UIViewController+EYAddition.m
//
//  Created by lieryang on 16/5/18.
//  Copyright © 2016年 lieryang. All rights reserved.
//

#import "UIViewController+EYAddition.h"

@implementation UIViewController (EYAddition)

- (void)ey_addChildController:(UIViewController *)childController intoView:(UIView *)view  {
    
    [self addChildViewController:childController];
    
    [view addSubview:childController.view];
    
    [childController didMoveToParentViewController:self];
}

@end
