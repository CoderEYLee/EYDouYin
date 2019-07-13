//
//  EYHTTPManager+EYCategory.m
//  TTEnglish
//
//  Created by 李二洋 on 2018/12/6.
//  Copyright © 2019 TTEnglish. All rights reserved.
//

#import "EYHTTPManager+EYCategory.h"

@implementation EYHTTPManager (TTCategory)

- (void)ey_CheckPhoneCodeWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}
- (void)ey_GetSchoolNameWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}
- (void)ey_GetSetUpLevelWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];

}

- (void)ey_CreateVisitorsWatchRecordWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}
- (void)ey_LearnGetAppVersionWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_LearnUploadVersionWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
     [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_PickStepOnWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    if ([parameters[@"like_object"] integerValue]==1) {
        if ([parameters[@"like_type"] integerValue] == 1 || [parameters[@"like_type"] integerValue] == 3) {
            [EYNotificationTool ey_postTTPickStepOnNotificationUserInfo:parameters];
        }
    }
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_GetUserVideosParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_LearnUserSearchVideoInfoWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_GetPushUserVideoIdsWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_GetUserEnVideoRecommendWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_GetLevelEnVideoIdsWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_GetUserEnRelationWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_GetUserVideoRelationProWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_GetEnTaskVideoProWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_SearchDictionaryEnWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_User_CollectionWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_EnGetUserCollectionWorldParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_EnGetCollectionParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_EnCancelCollectionParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_EnGetVideoIdParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_SetPushVideoIdsParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_enLearnEndUser_LearnExplainVideoWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_VideoSrtFeedbackWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_UserShareVideoWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (BOOL)tt_RecordUserClickWithParameters:(id)parameters {
    __block BOOL isSuccess = NO;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [self ey_POST:@"" parameters:parameters success:^(id  _Nullable responseObject) {
        NSInteger state = [responseObject[@"state"] integerValue];
        if (state == 0) {
            isSuccess = YES;
        }
        dispatch_semaphore_signal(semaphore);
    } failure:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER);
    return isSuccess;
}

- (void)ey_GetUserInfoWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_UpdateUserInfoWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:^(id  _Nullable responseObject) {
        NSInteger state = [responseObject[@"state"] integerValue];
        if (state == 0) {
            [EYNotificationTool ey_postTTUpdateUserInfoNotificationUserInfo:responseObject[@"data"]];
        }

        if (success) {
            success(responseObject);
        }
    } failure:failure];
}

- (void)ey_GetCodeWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_FollowUserWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:^(id  _Nullable responseObject) {
        NSInteger stateValue = [responseObject[@"state"] integerValue];
        if (stateValue == 0) {//请求成功处理数据
            NSInteger type = [parameters[@"type"] integerValue];
            if (type == 1) {//关注请求
                [EYNotificationTool ey_postTTUserFocusAndCancelNotificationUserInfo:parameters];
                [EYProgressHUD showInfoWithStatus:EYLocalized(@"tt_0092_0")];
            } else if (type == 2) {//取消关注
                [EYNotificationTool ey_postTTUserFocusAndCancelNotificationUserInfo:parameters];
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
}
- (void)ey_GetAuthFileTokenWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_GetFollowUserListWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_GetFansUserListWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_UploadVersionWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_CreateImpeachWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_VideoUninterestedWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_PullBlackWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:^(id  _Nullable responseObject) {
        NSInteger state = [responseObject[@"state"] integerValue];
        if (state == 0) {//请求成功处理数据
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:parameters];
            userInfo[@"type"] = @"1";
            //            [[EYManager manager] removeAttentionUserWithUserid:parameters[@"black_user_id"]];
            [EYNotificationTool ey_postTTUserBlackAndCancelNotificationUserInfo:userInfo];
            [EYProgressHUD showInfoWithStatus:EYLocalized(@"tt_0114_0")];
        }
        if (success) {
            success(responseObject);
        }
    } failure:failure];
}

- (void)ey_CancelPullBlackWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:^(id  _Nullable responseObject) {
        NSInteger state = [responseObject[@"state"] integerValue];
        if (state == 0) {//请求成功处理数据
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:parameters];
            userInfo[@"type"] = @"2";
            [EYNotificationTool ey_postTTUserBlackAndCancelNotificationUserInfo:userInfo];
            [EYProgressHUD showInfoWithStatus:EYLocalized(@"tt_0127_0")];
        }
        if (success) {
            success(responseObject);
        }
    } failure:failure];
}

- (void)ey_GetPullBlackListWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_GetUserPickVideosParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_EnLearnSearchUserWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_GetVideoEnCommentWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_GetVideoReplyWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_UserCommentReplyWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_DelUserCommentReplyWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_UserCommentLikeWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_PrepareUserMsgDataWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_FindMessageSystemWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_FindMessageWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_GetLearnEndCommmentWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_GetLearnEndLikeWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_GetLearnEndUserFollowWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_user_AuthLoginWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_user_BindAuthAccountWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_user_GetUserAuthInfoWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_user_RelieveBindWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

- (void)ey_user_VerificationAccountWithParameters:(id)parameters success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    [self ey_POST:@"" parameters:parameters success:success failure:failure];
}

@end
