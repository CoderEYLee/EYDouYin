//
//  EYUserModel.h
//  EYDouYin
//
//  Created by 李二洋 on 2019/6/28.
//  Copyright © 2019 李二洋. All rights reserved.
//  用户模型

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EYUserModel : NSObject

/**
 所处环境
 */
@property (copy, nonatomic) NSString *environment;

@property (copy, nonatomic) NSString *user_id;
/**
 用户 用户关系 0:无关系 1:关注关系 2:粉丝关系 3:互相关注关系 4:拉黑关系 5:被拉黑关系 6:相互拉黑
 */
@property (copy, nonatomic) NSString *user_per;
/**
 用户 别人的黑名单列表
 */
@property (copy, nonatomic) NSArray <EYUserModel *>*user_blacklist;
/**
 用户 用户自己黑名单列表
 */
@property (copy, nonatomic) NSArray <EYUserModel *>*self_user_blacklist;
/**
 用户 用户账号
 */
@property (copy, nonatomic) NSString *user_name;
/**
 用户 用户真实姓名
 */
@property (copy, nonatomic) NSString *user_realname;
/**
 用户 是否做过题1是做过0没做过
 */
@property (copy, nonatomic) NSString *is_question;
/**
 用户 昵称 (12个字)
 */
@property (copy, nonatomic) NSString *user_nikename;
/**
 用户 性别 1: 男 2: 女
 */
@property (copy, nonatomic) NSString *user_agent;
/**
 用户 生日 时间戳
 */
@property (copy, nonatomic) NSString *user_age;
/**
 用户 签名 (20个字)
 */
@property (copy, nonatomic) NSString *user_autograph;
/**
 用户 学校
 */
@property (copy, nonatomic) NSString *user_school;
/**
 用户 入学时间 (时间戳)
 */
@property (copy, nonatomic) NSString *user_school_start_time;
/**
 用户 所在地
 */
@property (copy, nonatomic) NSString *user_location;
/**
 用户 特长(兴趣爱好)
 */
@property (copy, nonatomic) NSString *user_speciality;
/**
 用户 头像
 */
@property (copy, nonatomic) NSString *user_image;
/**
 用户 session_key
 */
@property (copy, nonatomic) NSString *session_key;
/**
 用户 access_token
 */
@property (copy, nonatomic) NSString *access_token;
/**
 用户 用户共享者类型【zh,en】
 */
@property (copy, nonatomic) NSString *user_contributor;
/**
 用户 user_num
 */
@property (copy, nonatomic) NSString *user_num;
/**
 const REGISTER_APP_USER   = 1; //贡献端真实用户
 const VIRTUAL_NORMAL_USER = 2; //虚拟正常用户
 const VIRTUAL_USER        = 3;  //虚拟隐身用户
 const PGC_APP_USER        = 4;  //PGC 真实用户
 const STUDENT_USER        = 5;  //学习端真实用户
 const EN_LEARN_USER       = 6;  //英文学习端真实用户
 user_type为1:如果user_contributor不存在默认是zh
 user_type为5:如果user_contributor不存在默认是en
 用户 user_type 1是贡献端,5是中文学习端,6:英文学习端
 */
@property (copy, nonatomic) NSString *user_type;
/**
 用户 user_identity_class 身份 1:上班族 2: 学生
 */
@property (copy, nonatomic) NSString *user_identity_class;
/**
 用户 user_language 母语
 */
@property (copy, nonatomic) NSString *user_language;
/**
 用户 user_host_country 所在国家
 */
@property (copy, nonatomic) NSString *user_host_country;
/**
 用户 create_time (时间戳)
 */
@property (copy, nonatomic) NSString *create_time;
/**
 用户 user_works_num 用户上传的视频总数(登陆者)
 */
@property (copy, nonatomic) NSString *user_works_num;
/**
 用户 pass_video_num 用户通过的总数(查看别人的视频)
 */
@property (copy, nonatomic) NSString *pass_video_num;
/**
 用户 to_pick_num 用户视频被点赞的总数
 */
@property (copy, nonatomic) NSString *to_pick_num;
/**
 用户 pick_num 用户pick的视频总数
 */
@property (copy, nonatomic) NSString *pick_num;
/**
 用户 user_follow_num 用户关注的的总数
 */
@property (copy, nonatomic) NSString *user_follow_num;
/**
 用户 user_Fans_num 用户粉丝的总数
 */
@property (copy, nonatomic) NSString *user_Fans_num;
/**
 用户 user_collection_num 用户收藏的总数
 */
@property (copy, nonatomic) NSString *user_collection_num;

#pragma mark - 获赞
/**
 用户 like_remind_zh_1 获赞_中文_贡献端
 */
@property (copy, nonatomic) NSString *like_remind_zh_1;
/**
 用户 like_remind_zh_2 获赞_中文_学习端
 */
@property (copy, nonatomic) NSString *like_remind_zh_2;
/**
 用户 like_remind_en_1 获赞_英文_贡献端
 */
@property (copy, nonatomic) NSString *like_remind_en_1;
/**
 用户 like_remind_en_2 获赞_英文_学习端
 */
@property (copy, nonatomic) NSString *like_remind_en_2;

#pragma mark - 评论/回复
/**
 用户 comment_remind_zh_1 评论/回复_中文_贡献端
 */
@property (copy, nonatomic) NSString *comment_remind_zh_1;
/**
 用户 comment_remind_zh_2 评论/回复_中文_学习端
 */
@property (copy, nonatomic) NSString *comment_remind_zh_2;
/**
 用户 comment_remind_en_1 评论/回复_英文_贡献端
 */
@property (copy, nonatomic) NSString *comment_remind_en_1;
/**
 用户 comment_remind_en_2 评论/回复_英文_学习端
 */
@property (copy, nonatomic) NSString *comment_remind_en_2;

#pragma mark - 新增粉丝
/**
 用户 follow_remind_zh_1 新增粉丝_中文_贡献端
 */
@property (copy, nonatomic) NSString *follow_remind_zh_1;
/**
 用户 follow_remind_zh_2 新增粉丝_中文_学习端
 */
@property (copy, nonatomic) NSString *follow_remind_zh_2;
/**
 用户 follow_remind_en_1 新增粉丝_英文_贡献端
 */
@property (copy, nonatomic) NSString *follow_remind_en_1;
/**
 用户 follow_remind_en_2 新增粉丝_英文_学习端
 */
@property (copy, nonatomic) NSString *follow_remind_en_2;

#pragma mark - 消息助手
/**
 用户 assistant_time_zh_1 消息助手_中文_贡献端
 */
@property (copy, nonatomic) NSString *assistant_time_zh_1;

/**
 用户 assistant_time_zh_2 消息助手_中文_学习端
 */
@property (copy, nonatomic) NSString *assistant_time_zh_2;

/**
 用户 assistant_time_en_1 消息助手_英文_贡献端
 */
@property (copy, nonatomic) NSString *assistant_time_en_1;

/**
 用户 assistant_time_en_2 消息助手_英文_学习端
 */
@property (copy, nonatomic) NSString *assistant_time_en_2;

#pragma mark - 系统消息
/**
 用户 news_time_zh_1 系统消息_中文_贡献端
 */
@property (copy, nonatomic) NSString *news_time_zh_1;

/**
 用户 news_time_zh_2 系统消息_中文_学习端
 */
@property (copy, nonatomic) NSString *news_time_zh_2;

/**
 用户 news_time_en_1 系统消息_英文_贡献端
 */
@property (copy, nonatomic) NSString *news_time_en_1;

/**
 用户 news_time_en_2 系统消息_英文_学习端
 */
@property (copy, nonatomic) NSString *news_time_en_2;

#pragma mark - 自己处理字段

/**
 自定义字段 获赞
 */
@property (copy, nonatomic) NSString *tt_like_remind_time;

/**
 自定义字段 评论/回复
 */
@property (copy, nonatomic) NSString *tt_comment_remind_time;

/**
 自定义字段 新增粉丝
 */
@property (copy, nonatomic) NSString *tt_follow_remind_time;

/**
 自定义字段 消息助手
 */
@property (copy, nonatomic) NSString *tt_message_time_taotie;

/**
 自定义字段 系统消息
 */
@property (copy, nonatomic) NSString *tt_message_time_system;

/**
 自定义字段 用户头像(阿里云对应图片, 缩略图)
 */
@property (copy, nonatomic) NSString *tt_user_image;

@end

NS_ASSUME_NONNULL_END
