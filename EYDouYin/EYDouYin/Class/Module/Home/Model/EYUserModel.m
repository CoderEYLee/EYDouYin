//
//  EYUserModel.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/6/28.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYUserModel.h"

@implementation EYUserModel

MJCodingImplementation

- (BOOL)isEqual:(EYUserModel *)object {
    return [self.user_id isEqualToString:object.user_id];
}

- (NSString *)user_contributor {
    if ([self.user_type isEqualToString:@"1"]) {//user_type为1:如果user_contributor不存在默认是zh
        if (_user_contributor.length == 0) {
            return @"zh";
        }
    } else if ([self.user_type isEqualToString:@"5"]) {//user_type为5:如果user_contributor不存在默认是en
        if (_user_contributor.length == 0) {
            return @"en";
        }
    } else {
        
    }
    //返回
    return _user_contributor;
}

#pragma mark - 自定义字段

/**
 获赞
 */
- (NSString *)tt_like_remind_time {
    if ([self.user_contributor isEqualToString:@"zh"]) {
        //        /**
        //         用户 like_remind_zh_1 获赞_中文_贡献端
        //         */
        //        @property (copy, nonatomic) NSString *like_remind_zh_1;
        //        /**
        //         用户 like_remind_zh_2 获赞_中文_学习端
        //         */
        //        @property (copy, nonatomic) NSString *like_remind_zh_2;
        if (self.like_remind_zh_2.length) {
            return self.like_remind_zh_2;
        }
    } else if ([self.user_contributor isEqualToString:@"en"]) {
        //        /**
        //         用户 like_remind_en_1 获赞_英文_贡献端
        //         */
        //        @property (copy, nonatomic) NSString *like_remind_en_1;
        //        /**
        //         用户 like_remind_en_2 获赞_英文_学习端
        //         */
        //        @property (copy, nonatomic) NSString *like_remind_en_2;
        if (self.like_remind_en_2.length) {
            return self.like_remind_en_2;
        }
    } else {
        
    }
    //默认时间 2019-4-1-00:00:00
    return @"1554048000";
}

/**
 评论/回复
 */
- (NSString *)tt_comment_remind_time {
    if ([self.user_contributor isEqualToString:@"zh"]) {
        //    /**
        //     用户 comment_remind_zh_1 评论/回复_中文_贡献端
        //     */
        //    @property (copy, nonatomic) NSString *comment_remind_zh_1;
        //    /**
        //     用户 comment_remind_zh_2 评论/回复_中文_学习端
        //     */
        //    @property (copy, nonatomic) NSString *comment_remind_zh_2;
        if (self.comment_remind_zh_2.length) {
            return self.comment_remind_zh_2;
        }
    } else if ([self.user_contributor isEqualToString:@"en"]) {
        //    /**
        //     用户 comment_remind_en_1 评论/回复_英文_贡献端
        //     */
        //    @property (copy, nonatomic) NSString *comment_remind_en_1;
        //    /**
        //     用户 comment_remind_en_2 评论/回复_英文_学习端
        //     */
        //    @property (copy, nonatomic) NSString *comment_remind_en_2;
        
        if (self.comment_remind_en_2.length) {
            return self.comment_remind_en_2;
        }
    } else {
        
    }
    //默认时间 2019-4-1-00:00:00
    return @"1554048000";
}

/**
 新增粉丝
 */
- (NSString *)tt_follow_remind_time {
    if ([self.user_contributor isEqualToString:@"zh"]) {
        //    /**
        //     用户 follow_remind_zh_1 新增粉丝_中文_贡献端
        //     */
        //    @property (copy, nonatomic) NSString *follow_remind_zh_1;
        //    /**
        //     用户 follow_remind_zh_2 新增粉丝_中文_学习端
        //     */
        //    @property (copy, nonatomic) NSString *follow_remind_zh_2;
        if (self.follow_remind_zh_2.length) {
            return self.follow_remind_zh_2;
        }
    } else if ([self.user_contributor isEqualToString:@"en"]) {
        //    /**
        //     用户 follow_remind_en_1 新增粉丝_英文_贡献端
        //     */
        //    @property (copy, nonatomic) NSString *follow_remind_en_1;
        //    /**
        //     用户 follow_remind_en_2 新增粉丝_英文_学习端
        //     */
        //    @property (copy, nonatomic) NSString *follow_remind_en_2;
        if (self.follow_remind_en_2.length) {
            return self.follow_remind_en_2;
        }
    } else {
        
    }
    
    //默认时间 2019-4-1-00:00:00
    return @"1554048000";
}

- (NSString *)tt_message_time_taotie {
    if ([self.user_contributor isEqualToString:@"zh"]) {
        //    /**
        //     用户 assistant_time_zh_1 消息助手_中文_贡献端
        //     */
        //    @property (copy, nonatomic) NSString *assistant_time_zh_1;
        //
        //    /**
        //     用户 assistant_time_zh_2 消息助手_中文_学习端
        //     */
        //    @property (copy, nonatomic) NSString *assistant_time_zh_2;
        if (self.assistant_time_zh_2.length) {
            return self.assistant_time_zh_2;
        }
    } else if ([self.user_contributor isEqualToString:@"en"]) {
        //    /**
        //     用户 assistant_time_en_1 消息助手_英文_贡献端
        //     */
        //    @property (copy, nonatomic) NSString *assistant_time_en_1;
        //
        //    /**
        //     用户 assistant_time_en_2 消息助手_英文_学习端
        //     */
        //    @property (copy, nonatomic) NSString *assistant_time_en_2;
        if (self.assistant_time_en_2.length) {
            return self.assistant_time_en_2;
        }
    } else {
        
    }
    //默认时间 2019-4-1-00:00:00
    return @"1554048000";
}

- (NSString *)tt_message_time_system {
    if ([self.user_contributor isEqualToString:@"zh"]) {
        //        /**
        //         用户 news_time_zh_1 系统消息_中文_贡献端
        //         */
        //        @property (copy, nonatomic) NSString *news_time_zh_1;
        //
        //        /**
        //         用户 news_time_zh_2 系统消息_中文_学习端
        //         */
        //        @property (copy, nonatomic) NSString *news_time_zh_2;
        if (self.news_time_zh_2.length) {
            return self.news_time_zh_2;
        }
    } else if ([self.user_contributor isEqualToString:@"en"]) {
        //        /**
        //         用户 news_time_en_1 系统消息_英文_贡献端
        //         */
        //        @property (copy, nonatomic) NSString *news_time_en_1;
        //
        //        /**
        //         用户 news_time_en_2 系统消息_英文_学习端
        //         */
        //        @property (copy, nonatomic) NSString *news_time_en_2;
        
        if (self.news_time_en_2.length) {
            return self.news_time_en_2;
        }
    } else {
        
    }
    
    //默认时间 2019-4-1-00:00:00
    return @"1554048000";
}

/**
 自定义字段 用户头像(阿里云对应图片, 缩略图)
 */
- (NSString *)tt_user_image {
    return self.user_image.insertImagePathString_thumbnail;
}

@end
