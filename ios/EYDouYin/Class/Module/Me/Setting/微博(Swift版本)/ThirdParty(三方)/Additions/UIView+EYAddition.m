//
//  UIView+EYAddition.m
//
//  Created by lieryang on 16/5/11.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "UIView+EYAddition.h"

@implementation UIView (EYAddition)

- (UIImage *)ey_snapshotImage {

    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return result;
}

@end
