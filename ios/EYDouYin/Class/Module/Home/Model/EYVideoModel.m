//
//  EYVideoModel.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/5/31.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYVideoModel.h"

@implementation EYVideoModel

- (NSString *)ey_like {
    NSInteger like = [self.like integerValue];
    if (like < 10000) {
        return self.like;
    } else {
        return [NSString stringWithFormat:@"%.1f万", like / 10000.0];
    }
}

/**
 自定义字段 视频正常图(阿里云对应图片, 正常图)
 */
- (NSString *)ey_video_img_normal {
    return self.video_img.insertImagePathString_normal;
}

/**
 自定义字段 视频缩略图(阿里云对应图片, 缩略图)
 */
- (NSString *)ey_video_img_thumbnail {
    return self.video_img.insertImagePathString_thumbnail;
}

/**
 自定义字段 视频地址(阿里云对应视频)
 */
- (NSString *)ey_video_name {
    return self.video_name.insertVideoPathString;
}

/**
 自定义字段 用户头像(阿里云对应图片, 缩略图)
 */
- (NSString *)ey_user_image {
    return self.user_image.insertImagePathString_thumbnail;
}

@end
