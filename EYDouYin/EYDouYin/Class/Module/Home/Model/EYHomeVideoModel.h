//
//  EYHomeVideoModel.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/9/12.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EYHomeVideoLikeModel.h"
#import "EYHomeItemCommentModel.h"

@interface EYHomeVideoModel : NSObject

/**
 用户 id
 */
@property (copy, nonatomic) NSString *userId;

/**
  用户 name
 */
@property (copy, nonatomic) NSString *userName;

/**
 用户头像链接
 */
@property (copy, nonatomic) NSString *user_head_url;

/**
 视频 id
 */
@property (copy, nonatomic) NSString *itemId;

/**
 视频标题
 */
@property (copy, nonatomic) NSString *title;

/**
 视频链接
 */
@property (copy, nonatomic) NSString *video_url;

/**
 位置信息
 */
@property (copy, nonatomic) NSString *location;

/**
 视频中的喜欢数组
 */
@property (copy, nonatomic) NSArray <EYHomeVideoLikeModel *>*likes;

/**
 视频中评论数组
 */
@property (copy, nonatomic) NSArray <EYHomeVideoLikeModel *>*comments;

/**
 视频中转发数组
 */
@property (copy, nonatomic) NSArray <EYHomeVideoLikeModel *>*forwards;

@end
