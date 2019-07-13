//
//  EYHTTPManager+EYCategory.h
//  TTEnglish
//
//  Created by 李二洋 on 2018/12/6.
//  Copyright © 2019 TTEnglish. All rights reserved.
//

#import "EYHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface EYHTTPManager (TTCategory)

- (void)ey_CheckPhoneCodeWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_GetSchoolNameWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_GetSetUpLevelWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_CreateVisitorsWatchRecordWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_LearnGetAppVersionWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_LearnUploadVersionWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_PickStepOnWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_GetUserVideosParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_LearnUserSearchVideoInfoWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_GetPushUserVideoIdsWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_GetUserEnVideoRecommendWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_GetLevelEnVideoIdsWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_GetUserEnRelationWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_GetUserVideoRelationProWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_GetEnTaskVideoProWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_SearchDictionaryEnWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_User_CollectionWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_EnGetUserCollectionWorldParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_EnGetCollectionParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_EnCancelCollectionParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_EnGetVideoIdParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_SetPushVideoIdsParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_enLearnEndUser_LearnExplainVideoWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_VideoSrtFeedbackWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_UserShareVideoWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (BOOL)tt_RecordUserClickWithParameters:(id)parameters;

- (void)ey_GetUserInfoWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_UpdateUserInfoWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_GetCodeWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_FollowUserWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_GetAuthFileTokenWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_GetFollowUserListWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_GetFansUserListWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_UploadVersionWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_CreateImpeachWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_VideoUninterestedWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_PullBlackWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_CancelPullBlackWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_GetPullBlackListWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_GetUserPickVideosParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_EnLearnSearchUserWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_GetVideoEnCommentWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_GetVideoReplyWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_UserCommentReplyWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_DelUserCommentReplyWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_UserCommentLikeWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_PrepareUserMsgDataWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_FindMessageSystemWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_FindMessageWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_GetLearnEndCommmentWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_GetLearnEndLikeWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_GetLearnEndUserFollowWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_user_AuthLoginWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_user_BindAuthAccountWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_user_GetUserAuthInfoWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_user_RelieveBindWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)ey_user_VerificationAccountWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
