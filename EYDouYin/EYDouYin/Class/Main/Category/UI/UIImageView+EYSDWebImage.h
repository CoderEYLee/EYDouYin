//
//  UIImageView+EYSDWebImage.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/11/2.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (EYSDWebImage)

- (void)ey_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder options:(SDWebImageOptions)options;

@end

NS_ASSUME_NONNULL_END
