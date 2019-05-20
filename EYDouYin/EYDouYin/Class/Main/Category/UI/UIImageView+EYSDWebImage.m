//
//  UIImageView+EYSDWebImage.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/11/2.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "UIImageView+EYSDWebImage.h"

@implementation UIImageView (EYSDWebImage)

- (void)ey_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder options:(SDWebImageOptions)options {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options];
}

@end
