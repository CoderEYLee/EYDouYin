//
//  EYVideoModel.h
//  EYDouYin
//
//  Created by 李二洋 on 2019/5/31.
//  Copyright © 2019 李二洋. All rights reserved.
//  视频模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EYVideoModel : NSObject

/**
 视频 video_id
 */
@property (nonatomic, copy) NSString *video_id;
/**
 视频 video_name
 */
@property (nonatomic, copy) NSString *video_name;
/**
 视频 video_title
 */
@property (nonatomic, copy) NSString *video_title;
/**
 视频 video_md5
 */
@property (nonatomic, copy) NSString *video_md5;
/**
 视频 视频来源
 */
@property (nonatomic, copy) NSString *video_from;
/**
 视频 video_img
 */
@property (nonatomic, copy) NSString *video_img;

/**
 视频 video_createtime
 */
@property (nonatomic, copy) NSString *video_createtime;
/**
 视频 srt_id
 */
@property (nonatomic, copy) NSString *srt_id;
/**
 视频 srt_name
 */
@property (nonatomic, copy) NSString *srt_name;
/**
 视频 user_id
 */
@property (nonatomic, copy) NSString *user_id;
/**
 视频 isPGC
 */
@property (nonatomic, copy) NSString *isPGC;
/**
 视频 是否上下架 0:未审核 1:审核通过 2:审核未通过
 */
@property (nonatomic, copy) NSString *isPublish;
/**
 视频 审核未通过的原因数组
 */
//@property (nonatomic, copy) NSArray <CLVideoTagModel *>*tag;
/**
 视频 喜欢数
 */
@property (nonatomic, copy) NSString *like;
/**
 视频 踩数
 */
@property (nonatomic, copy) NSString *unlike;
/**
 视频 评论数
 */
@property (nonatomic, copy) NSString *comment;
/**
 视频 人物头像
 */
@property (nonatomic, copy) NSString *user_image;

/**
 任务id
 */
@property (nonatomic,copy)NSString *task_id;
/**
 任务名称
 */
@property (nonatomic,copy)NSString *task_name;
/**
 作者名称
 */
@property (nonatomic,copy)NSString *user_nikename;
/**
 任务池
 */
@property (nonatomic,copy)NSString *pool;
/**
 任务
 */
@property (nonatomic,copy)NSString *exposure_num;
/**
 任务
 */
@property (nonatomic,copy)NSString *at_head;
/**
 删除
 */
@property (nonatomic,assign)NSInteger is_delete;//1删除 0未删除

/**
 关注关系
 */
@property (nonatomic,copy)NSString *user_per;

/**
 点赞关系
 */
@property (nonatomic,copy)NSString *is_like;

#pragma mark - 自己添加字段
/**
 视频 是否pick/diss 0:未进行操作 1:已经点击了pick 2:diss 3:这个视频划过去了
 */
@property (nonatomic, copy) NSString *is_pass;
/**
 视频 喜欢数描述(根据like字段产生)
 */
@property (copy, nonatomic, readonly) NSString *ey_like;

/**
 是否拉取过关系 yes拉取过 no未拉取
 */
@property (nonatomic, assign)BOOL relationship_state;

/**
 自定义字段 视频正常图(阿里云对应图片, 正常图)
 */
@property (nonatomic, copy) NSString *ey_video_img_normal;

/**
 自定义字段 视频缩略图(阿里云对应图片, 缩略图)
 */
@property (nonatomic, copy) NSString *ey_video_img_thumbnail;

/**
 自定义字段 视频地址(阿里云对应视频)
 */
@property (nonatomic, copy) NSString *ey_video_name;

/**
 自定义字段 用户头像(阿里云对应图片, 缩略图)
 */
@property (nonatomic, copy) NSString *ey_user_image;

@end

NS_ASSUME_NONNULL_END
