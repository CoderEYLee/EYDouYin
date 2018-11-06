//
//  UIButton+EYSDWebImage.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/11/6.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "UIButton+EYSDWebImage.h"
#import <UIButton+WebCache.h>

@implementation UIButton (EYSDWebImage)

- (void)ey_setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options {
    [self sd_setImageWithURL:url forState:state placeholderImage:placeholder options:options];
}

@end
