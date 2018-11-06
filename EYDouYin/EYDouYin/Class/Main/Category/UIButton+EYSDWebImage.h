//
//  UIButton+EYSDWebImage.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/11/6.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (EYSDWebImage)

- (void)ey_setImageWithURL:(nullable NSURL *)url
                  forState:(UIControlState)state
          placeholderImage:(nullable UIImage *)placeholder
                   options:(SDWebImageOptions)options;

@end

NS_ASSUME_NONNULL_END
