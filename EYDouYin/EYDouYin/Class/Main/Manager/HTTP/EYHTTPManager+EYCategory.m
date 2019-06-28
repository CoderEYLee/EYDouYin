//
//  EYHTTPManager+EYCategory.m
//  TTEnglish
//
//  Created by 李二洋 on 2018/12/6.
//  Copyright © 2019 TTEnglish. All rights reserved.
//

#import "EYHTTPManager+EYCategory.h"

@implementation EYHTTPManager (TTCategory)

#pragma mark - 学习端 API 列表
/**
 [1]注册登录:
 /userApi/user_CheckPhoneCode.php
 */
- (void)tt_CheckPhoneCodeWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/user_CheckPhoneCode.php" parameters:parameters success:success failure:failure];
}

/**
 [2] 获取学校名称:
 /userApi/user_GetSchoolName.php
 */
- (void)tt_GetSchoolNameWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/user_GetSchoolName.php" parameters:parameters success:success failure:failure];
}

/**
 [3]设置难度级别:
 /userApi/user_SetUpLevel.php
 */
- (void)tt_GetSetUpLevelWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self tt_POST:@"/userApi/user_SetUpLevel.php" parameters:parameters success:success failure:failure];
    
}

/**
 [4]添加游客观看视频记录:
 /userApi/user_CreateVisitorsWatchRecord.php
 */
- (void)tt_CreateVisitorsWatchRecordWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self tt_POST:@"/userApi/user_CreateVisitorsWatchRecord.php" parameters:parameters success:success failure:failure];
}

/**
 [5]学习端获取APP版本号:
 /userApi/user_LearnGetAppVersion.php
 */
- (void)tt_LearnGetAppVersionWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/user_LearnGetAppVersion.php" parameters:parameters success:success failure:failure];
}

/**
 [6]学习端上传APP版本:
 /userApi/user_LearnUploadVersion.php
 */
- (void)tt_LearnUploadVersionWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    // [self tt_POST:@"/userApi/user_LearnUploadVersion.php" parameters:parameters success:success failure:failure];
}

/**
 [7]学习端视频和评论点赞:
 /userApi/comment_PickStepOn.php
 */
- (void)tt_PickStepOnWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    if ([parameters[@"like_object"] integerValue]==1) {
        if ([parameters[@"like_type"] integerValue] == 1 || [parameters[@"like_type"] integerValue] == 3) {
            [EYNotificationTool tt_postTTPickStepOnNotificationUserInfo:parameters];
        }
    }
    [self tt_POST:@"/userApi/comment_PickStepOn.php" parameters:parameters success:success failure:failure];
}

/**
 [8]获取个人作品:
 /userApi/comment_GetUserVideos.php
 */
- (void)tt_GetUserVideosParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self tt_POST:@"/userApi/comment_GetUserVideos.php" parameters:parameters success:success failure:failure];
}

/**
 [9]搜索视频:
 /userApi/comment_LearnUserSearchVideoInfo.php
 */
- (void)tt_LearnUserSearchVideoInfoWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self tt_POST:@"/userApi/comment_LearnUserSearchVideoInfo.php" parameters:parameters success:success failure:failure];
}

/**
 [10]推荐视频:
 /userApi/enLearnEndVideo_GetPushUserVideoIds.php
 */
- (void)tt_GetPushUserVideoIdsWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self tt_POST:@"/userApi/enLearnEndVideo_GetPushUserVideoIds.php" parameters:parameters success:success failure:failure];
}

/**
 [11]获取视频详情:
 /userApi/enLearnEndVideo_GetUserVideoRecommend.php
 */
- (void)tt_GetUserEnVideoRecommendWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self tt_POST:@"/userApi/enLearnEndVideo_GetUserVideoRecommend.php" parameters:parameters success:success failure:failure];
}

/**
 [12]获取难度级别视频id:
 /userApi/enLearnEndVideo_GetLevelVideoIds.php
 */
- (void)tt_GetLevelEnVideoIdsWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self tt_POST:@"/userApi/enLearnEndVideo_GetLevelVideoIds.php" parameters:parameters success:success failure:failure];
}

/**
 [13]查询用户关系与是否点赞视频关系:
 /userApi/enLearnEndVideo_GetUserRelation.php
 */
- (void)tt_GetUserEnRelationWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self tt_POST:@"/userApi/enLearnEndVideo_GetUserRelation.php" parameters:parameters success:success failure:failure];
}

/**
 [14]用户与视频之间具体详情:
 /userApi/enLearnEndVideo_GetUserVideoRelationPro.php
 */
- (void)tt_GetUserVideoRelationProWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self tt_POST:@"/userApi/enLearnEndVideo_GetUserVideoRelationPro.php" parameters:parameters success:success failure:failure];
}

/**
 [15]获取任务视频详情:
 /userApi/taskVideo_GetEnTaskVideoPro.php
 */
- (void)tt_GetEnTaskVideoProWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self tt_POST:@"/userApi/taskVideo_GetEnTaskVideoPro.php" parameters:parameters success:success failure:failure];
}

/**
 [16]英文学习端搜索字典:
 /userApi/comment_SearchDictionaryEn.php
 */
- (void)tt_SearchDictionaryEnWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/comment_SearchDictionaryEn.php" parameters:parameters success:success failure:failure];
}

/**
 [17]用户收藏功能:
 /userApi/enLearnEndUser_Collection.php
 */
- (void)tt_User_CollectionWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/enLearnEndUser_Collection.php" parameters:parameters success:success failure:failure];
}

/**
 [18]查看该用户是否收藏该词:
 /userApi/enLearnEndUser_GetUserCollectionWorld.php
 */
- (void)tt_EnGetUserCollectionWorldParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self tt_POST:@"/userApi/enLearnEndUser_GetUserCollectionWorld.php" parameters:parameters success:success failure:failure];
}

/**
 [19]用户列表展示收藏数据:
 /userApi/enLearnEndUser_GetCollection.php
 */
- (void)tt_EnGetCollectionParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self tt_POST:@"/userApi/enLearnEndUser_GetCollection.php" parameters:parameters success:success failure:failure];
}

/**
 [20]用户取消收藏功能:
 /userApi/enLearnEndUser_CancelCollection.php
 */
- (void)tt_EnCancelCollectionParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self tt_POST:@"/userApi/enLearnEndUser_CancelCollection.php" parameters:parameters success:success failure:failure];
}

/**
 [21]收藏获取视频:
 /userApi/enLearnEndVideo_GetVideoId.php
 */
- (void)tt_EnGetVideoIdParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self tt_POST:@"/userApi/enLearnEndVideo_GetVideoId.php" parameters:parameters success:success failure:failure];
}

/**
 [22]用户登录成功后触发后端队列，预备视频:
 /userApi/enLearnEndUser_SetPushVideoIds.php
 */
- (void)tt_SetPushVideoIdsParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self tt_POST:@"/userApi/enLearnEndUser_SetPushVideoIds.php" parameters:parameters success:success failure:failure];
}

/**
 [23]开屏视频:
 /userApi/enLearnEndUser_LearnExplainVideo.php
 */
- (void)tt_enLearnEndUser_LearnExplainVideoWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/enLearnEndUser_LearnExplainVideo.php" parameters:parameters success:success failure:failure];
}

/**
 [24]记录视频字幕错误反馈:
 /userApi/comment_VideoSrtFeedback.php
 */
- (void)tt_VideoSrtFeedbackWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self tt_POST:@"/userApi/comment_VideoSrtFeedback.php" parameters:parameters success:success failure:failure];
}

/**
 [25]获取分享链接,记录视频的分享数量(分享和下载):
 /userApi/user_UserShareVideo.php
 share_type:1是分享  2是下载,platform:1是微信(个人或群) 2是微信朋友圈 3是微博 4是QQ(个人或群) 5是QQ空间
 */
- (void)tt_UserShareVideoWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self tt_POST:@"/userApi/user_UserShareVideo.php" parameters:parameters success:success failure:failure];
}

/**
 [26]埋点:
 /userApi/user_RecordUserBehavior.php
 */
- (BOOL)tt_RecordUserBehaviorWithParameters:(id)parameters {
    EYLog(@"给服务器上报数据==%@", parameters);
    
    __block BOOL isSuccess = NO;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [self tt_POST:@"/userApi/user_RecordUserBehavior.php" parameters:parameters success:^(id  _Nullable responseObject) {
        NSInteger state = [responseObject[@"state"] integerValue];
        if (state == 0) {
            isSuccess = YES;
        }
        dispatch_semaphore_signal(semaphore);
    } failure:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER);
    EYLog(@"给服务器上报数据结束");
    return isSuccess;
}

#pragma mark - 公共 API 列表

/**
 [1]获取获取用户信息:
 /userApi/user_GetUserInfo.php
 */
- (void)tt_GetUserInfoWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/user_GetUserInfo.php" parameters:parameters success:success failure:failure];
}

/**
 [2]修改个人用户信息:
 /userApi/user_UpdateUserInfo.php
 */
- (void)tt_UpdateUserInfoWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/user_UpdateUserInfo.php" parameters:parameters success:^(id  _Nullable responseObject) {
        NSInteger state = [responseObject[@"state"] integerValue];
        if (state == 0) {
            [EYNotificationTool tt_postTTUpdateUserInfoNotificationUserInfo:responseObject[@"data"]];
        }

        if (success) {
            success(responseObject);
        }
    } failure:failure];
}

/**
 [3]发送手机验证码:
 /userApi/user_GetCode.php
 */
- (void)tt_GetCodeWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/user_GetCode.php" parameters:parameters success:success failure:failure];
}

/**
 [4]关注 取消关注:
 /userApi/comment_FollowUser.php
 */
- (void)tt_FollowUserWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/comment_FollowUser.php" parameters:parameters success:^(id  _Nullable responseObject) {
        NSInteger stateValue = [responseObject[@"state"] integerValue];
        if (stateValue == 0) {//请求成功处理数据
            NSInteger type = [parameters[@"type"] integerValue];
            if (type == 1) {//关注请求
                [EYNotificationTool tt_postTTUserFocusAndCancelNotificationUserInfo:parameters];
                [EYProgressHUD showInfoWithStatus:EYLocalized(@"tt_0092_0")];
            } else if (type == 2) {//取消关注
                [EYNotificationTool tt_postTTUserFocusAndCancelNotificationUserInfo:parameters];
                [EYProgressHUD showInfoWithStatus:EYLocalized(@"tt_0094_0")];
            } else {//暂时没有
                
            }
        } else if (stateValue == 10037) {
            NSString *message = responseObject[@"message"];
            [EYProgressHUD showInfoWithStatus:message];
        }
        if (success) {
            success(responseObject);
        }
    } failure:failure];
    
    //    NSMutableString *message = [NSMutableString string];
    //    [message appendString:@"type: 1关注 2取消关注\n"];
    //
    //    NSDictionary *dic = (NSDictionary *)parameters;
    //
    //    if ([parameters[@"type"] intValue] == 1) {
    //        [message appendString:@"这是关注请求\n"];
    //    } else if ([parameters[@"type"] intValue] == 2) {
    //        [message appendString:@"这是取消关注请求\n"];
    //    }
    //
    //    for (NSString *key in dic.allKeys) {
    //        id value = dic[key];
    //        [message appendFormat:@"%@ : %@\n", key, value];
    //    }
    //
    //    [message appendString:@"点击确定发送"];
    //
    //    //添加提示框
    //    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    //    [alert addAction:[UIAlertAction actionWithTitle:EYLocalized(@"tt_public_cancel") style:UIAlertActionStyleCancel handler:nil]];
    //
    //    UIAlertAction * actionDetermine = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    //        [self tt_POST:@"/userApi/comment_FollowUser.php" parameters:parameters success:^(id  _Nullable responseObject) {
    //            NSInteger stateValue = [responseObject[@"state"] integerValue];
    //            if (stateValue == 0) {//请求成功处理数据
    //                NSInteger type = [parameters[@"type"] integerValue];
    //                NSString *follow_user_id = parameters[@"follow_user_id"];
    //                if (type == 1) {//关注请求
    //                    [[EYManager manager] addAttentionUserWithUserid:follow_user_id];
    //                } else if (type == 2) {//取消关注
    //                    [[EYManager manager] removeAttentionUserWithUserid:follow_user_id];
    //                } else {//暂时没有
    //
    //                }
    //            }
    //            if (success) {
    //                success(responseObject);
    //            }
    //        } failure:failure];
    //    }];
    //
    //    [alert addAction:actionDetermine];
    //
    //    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

/**
 [5]获取三方 阿里云token 文件上传token:
 /userApi/comment_GetAuthFileToken.php
 */
- (void)tt_GetAuthFileTokenWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/comment_GetAuthFileToken.php" parameters:parameters success:success failure:failure];
}

/**
 [6] 获取关注列表:
 /userApi/comment_GetFollowUserList.php
 */
- (void)tt_GetFollowUserListWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/comment_GetFollowUserList.php" parameters:parameters success:success failure:failure];
}

/**
 [7] 获取粉丝列表:
 /userApi/comment_GetFansUserList.php
 */
- (void)tt_GetFansUserListWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/comment_GetFansUserList.php" parameters:parameters success:success failure:failure];
}

/**
 [8]上传APP版本:
 /userApi/user_UploadVersion.php
 */
- (void)tt_UploadVersionWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/user_UploadVersion.php" parameters:parameters success:success failure:failure];
}

/**
 [10]举报:
 /userApi/comment_CreateImpeach.php
 */
- (void)tt_CreateImpeachWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/comment_CreateImpeach.php" parameters:parameters success:success failure:failure];
}

/**
 [11]不感兴趣:
 /userApi/comment_VideoUninterested.php
 */
- (void)tt_VideoUninterestedWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/comment_VideoUninterested.php" parameters:parameters success:success failure:failure];
}

/**
 [12]拉黑:
 /userApi/user_PullBlack.php
 */
- (void)tt_PullBlackWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/user_PullBlack.php" parameters:parameters success:^(id  _Nullable responseObject) {
        NSInteger state = [responseObject[@"state"] integerValue];
        if (state == 0) {//请求成功处理数据
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:parameters];
            userInfo[@"type"] = @"1";
            //            [[EYManager manager] removeAttentionUserWithUserid:parameters[@"black_user_id"]];
            [EYNotificationTool tt_postTTUserBlackAndCancelNotificationUserInfo:userInfo];
            [EYProgressHUD showInfoWithStatus:EYLocalized(@"tt_0114_0")];
        }
        if (success) {
            success(responseObject);
        }
    } failure:failure];
}

/**
 [13]取消拉黑:
 /userApi/user_CancelPullBlack.php
 */
- (void)tt_CancelPullBlackWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/user_CancelPullBlack.php" parameters:parameters success:^(id  _Nullable responseObject) {
        NSInteger state = [responseObject[@"state"] integerValue];
        if (state == 0) {//请求成功处理数据
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:parameters];
            userInfo[@"type"] = @"2";
            [EYNotificationTool tt_postTTUserBlackAndCancelNotificationUserInfo:userInfo];
            [EYProgressHUD showInfoWithStatus:EYLocalized(@"tt_0127_0")];
        }
        if (success) {
            success(responseObject);
        }
    } failure:failure];
}

/**
 [14]获取拉黑列表:
 /userApi/user_GetPullBlackList.php
 */
- (void)tt_GetPullBlackListWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/user_GetPullBlackList.php" parameters:parameters success:success failure:failure];
}

/**
 [15]获取用户点赞视频::
 /userApi/comment_GetUserPickVideos.php
 */
- (void)tt_GetUserPickVideosParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self tt_POST:@"/userApi/comment_GetUserPickVideos.php" parameters:parameters success:success failure:failure];
}

/**
 [16]英文学习端搜索用户:
 /userApi/comment_EnLearnSearchUser.php
 */
- (void)tt_EnLearnSearchUserWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self tt_POST:@"/userApi/comment_EnLearnSearchUser.php" parameters:parameters success:success failure:failure];
}

/**
 [17]视频评论列表:
 /userApi/enLearnEndVideo_GetVideoComment.php
 */
- (void)tt_GetVideoEnCommentWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self tt_POST:@"/userApi/enLearnEndVideo_GetVideoComment.php" parameters:parameters success:success failure:failure];
}

/**
 [18]获取评论回复列表:
 /userApi/enLearnEndVideo_GetVideoReply.php
 */
- (void)tt_GetVideoReplyWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self tt_POST:@"/userApi/enLearnEndVideo_GetVideoReply.php" parameters:parameters success:success failure:failure];
}

/**
 [19]英文学习端评论回复:
 /userApi/comment_UserCommentReply.php
 */
- (void)tt_UserCommentReplyWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self tt_POST:@"/userApi/comment_UserCommentReply.php" parameters:parameters success:success failure:failure];
}

/**
 [20]删除英文学习端评论回复:
 /userApi/comment_DelUserCommentReply.php
 */
- (void)tt_DelUserCommentReplyWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self tt_POST:@"/userApi/comment_DelUserCommentReply.php" parameters:parameters success:success failure:failure];
}

/**
 [21]评论点赞与取消点赞:
 /userApi/comment_UserCommentLike.php
 */
- (void)tt_UserCommentLikeWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self tt_POST:@"/userApi/comment_UserCommentLike.php" parameters:parameters success:success failure:failure];
}

/**
 [22]获取用户的新旧消息:
 /userApi/message_PrepareUserMsgData.php
 */
- (void)tt_PrepareUserMsgDataWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/message_PrepareUserMsgData.php" parameters:parameters success:success failure:failure];
}

/**
 [23]系统消息:
 /userApi/message_FindMessageSystem.php
 */
- (void)tt_FindMessageSystemWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/message_FindMessageSystem.php" parameters:parameters success:success failure:failure];
}

/**
 [24]消息助手:
 /userApi/message_FindMessage.php
 */
- (void)tt_FindMessageWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/message_FindMessage.php" parameters:parameters success:success failure:failure];
}

/**
 [25]评论消息:
 /userApi/message_GetLearnEndCommment.php
 */
- (void)tt_GetLearnEndCommmentWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/message_GetLearnEndCommment.php" parameters:parameters success:success failure:failure];
}

/**
 [26]点赞消息:
 /userApi/message_GetLearnEndLike.php
 */
- (void)tt_GetLearnEndLikeWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/message_GetLearnEndLike.php" parameters:parameters success:success failure:failure];
}

/**
 [27]关注消息:
 /userApi/message_GetLearnEndUserFollow.php
 */
- (void)tt_GetLearnEndUserFollowWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/message_GetLearnEndUserFollow.php" parameters:parameters success:success failure:failure];
}

/**
 [28]第三方登录:
 /userApi/user_AuthLogin.php
 */
- (void)tt_user_AuthLoginWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/user_AuthLogin.php" parameters:parameters success:success failure:failure];
}

/**
 [29]第三方绑定:
 /userApi/user_BindAuthAccount.php
 */
- (void)tt_user_BindAuthAccountWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/user_BindAuthAccount.php" parameters:parameters success:success failure:failure];
}

/**
 [30]所有账号显示:
 /userApi/user_GetUserAuthInfo.php
 */
- (void)tt_user_GetUserAuthInfoWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/user_GetUserAuthInfo.php" parameters:parameters success:success failure:failure];
}

/**
 [31]解除绑定:
 /userApi/user_RelieveBind.php
 */
- (void)tt_user_RelieveBindWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/user_RelieveBind.php" parameters:parameters success:success failure:failure];
}

/**
 [32]检测该手机号是否可以注册、绑定:
 /userApi/user_VerificationAccount.php
 */
- (void)tt_user_VerificationAccountWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self tt_POST:@"/userApi/user_VerificationAccount.php" parameters:parameters success:success failure:failure];
}

#pragma mark - 内部使用

/**
 [1] 获取 AppStore 的最新版本
 http://itunes.apple.com/cn/lookup?id=1463560267
 */
- (void)tt_AppStoreVersionWithSuccess:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    NSURL *URL = [NSURL URLWithString:@"http://itunes.apple.com/cn/lookup?id=1463560267"];
    [[[NSURLSession sharedSession] dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                if (failure) {
                    failure(error);
                }
            } else {
                NSError *error = nil;
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                if (error) {
                    if (failure) {
                        failure(error);
                    }
                } else {
                    if (success) {
                        success(dictionary);
                    }
                }
            }
        });
    }] resume];
}

@end
