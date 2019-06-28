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

#pragma mark - 学习端 API 列表

/**
 [1]注册登录:
 /userApi/user_CheckPhoneCode.php
 */
- (void)tt_CheckPhoneCodeWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [2] 获取学校名称:
 /userApi/user_GetSchoolName.php
 */
- (void)tt_GetSchoolNameWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [3]设置难度级别:
 /userApi/user_SetUpLevel.php
 */
- (void)tt_GetSetUpLevelWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [4]添加游客观看视频记录:
 /userApi/user_CreateVisitorsWatchRecord.php
 */
- (void)tt_CreateVisitorsWatchRecordWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [5]学习端获取APP版本号:
 /userApi/user_LearnGetAppVersion.php
 */
- (void)tt_LearnGetAppVersionWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [6]学习端上传APP版本:
 /userApi/user_LearnUploadVersion.php
 */
- (void)tt_LearnUploadVersionWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [7]学习端视频和评论点赞:
 /userApi/comment_PickStepOn.php
 */
- (void)tt_PickStepOnWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [8]获取个人作品:
 /userApi/comment_GetUserVideos.php
 */
- (void)tt_GetUserVideosParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [9]搜索视频:
 /userApi/comment_LearnUserSearchVideoInfo.php
 */
- (void)tt_LearnUserSearchVideoInfoWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [10]推荐视频:
 /userApi/enLearnEndVideo_GetPushUserVideoIds.php
 */
- (void)tt_GetPushUserVideoIdsWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [11]获取视频详情:
 /userApi/enLearnEndVideo_GetUserVideoRecommend.php
 */
- (void)tt_GetUserEnVideoRecommendWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [12]获取难度级别视频id:
 /userApi/enLearnEndVideo_GetLevelVideoIds.php
 */
- (void)tt_GetLevelEnVideoIdsWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [13]查询用户关系与是否点赞视频关系:
 /userApi/enLearnEndVideo_GetUserRelation.php
 */
- (void)tt_GetUserEnRelationWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [14]用户与视频之间具体详情:
 /userApi/enLearnEndVideo_GetUserVideoRelationPro.php
 */
- (void)tt_GetUserVideoRelationProWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [15]获取任务视频详情:
 /userApi/taskVideo_GetEnTaskVideoPro.php
 */
- (void)tt_GetEnTaskVideoProWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [16]英文学习端搜索字典:
 /userApi/comment_SearchDictionaryEn.php
 */
- (void)tt_SearchDictionaryEnWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [17]用户收藏功能:
 /userApi/enLearnEndUser_Collection.php
 */
- (void)tt_User_CollectionWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [18]查看该用户是否收藏该词:
 /userApi/enLearnEndUser_GetUserCollectionWorld.php
 */
- (void)tt_EnGetUserCollectionWorldParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [19]用户列表展示收藏数据:
 /userApi/enLearnEndUser_GetCollection.php
 */
- (void)tt_EnGetCollectionParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [20]用户取消收藏功能:
 /userApi/enLearnEndUser_CancelCollection.php
 */
- (void)tt_EnCancelCollectionParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [21]收藏获取视频:
 /userApi/enLearnEndVideo_GetVideoId.php
 */
- (void)tt_EnGetVideoIdParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [22]用户登录成功后触发后端队列，预备视频:
 /userApi/enLearnEndUser_SetPushVideoIds.php
 */
- (void)tt_SetPushVideoIdsParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [23]开屏视频:
 /userApi/enLearnEndUser_LearnExplainVideo.php
 */
- (void)tt_enLearnEndUser_LearnExplainVideoWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [24]记录视频字幕错误反馈:
 /userApi/comment_VideoSrtFeedback.php
 */
- (void)tt_VideoSrtFeedbackWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [25]获取分享链接,记录视频的分享数量(分享和下载):
 /userApi/user_UserShareVideo.php
 share_type:1是分享  2是下载,platform:1是微信(个人或群) 2是微信朋友圈 3是微博 4是QQ(个人或群) 5是QQ空间
 */
- (void)tt_UserShareVideoWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [26]埋点:
 /userApi/user_RecordUserBehavior.php
 */
- (BOOL)tt_RecordUserBehaviorWithParameters:(id)parameters;

#pragma mark - 公共 API 列表

/**
 [1]获取获取用户信息:
 /userApi/user_GetUserInfo.php
 */
- (void)tt_GetUserInfoWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [2]修改个人用户信息:
 /userApi/user_UpdateUserInfo.php
 */
- (void)tt_UpdateUserInfoWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [3]发送手机验证码:
 /userApi/user_GetCode.php
 */
- (void)tt_GetCodeWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [4]关注 取消关注:
 /userApi/comment_FollowUser.php
 */
- (void)tt_FollowUserWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [5]#获取三方 阿里云token 文件上传token:
 /userApi/comment_GetAuthFileToken.php
 */
- (void)tt_GetAuthFileTokenWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [6] 获取关注列表:
 /userApi/comment_GetFollowUserList.php
 */
- (void)tt_GetFollowUserListWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [7] 获取粉丝列表:
 /userApi/comment_GetFansUserList.php
 */
- (void)tt_GetFansUserListWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [8]上传APP版本:
 /userApi/user_UploadVersion.php
 */
- (void)tt_UploadVersionWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [10]举报:
 /userApi/comment_CreateImpeach.php
 */
- (void)tt_CreateImpeachWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [11]不感兴趣:
 /userApi/comment_VideoUninterested.php
 */
- (void)tt_VideoUninterestedWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [12]拉黑:
 /userApi/user_PullBlack.php
 */
- (void)tt_PullBlackWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [13]取消拉黑:
 /userApi/user_CancelPullBlack.php
 */
- (void)tt_CancelPullBlackWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [14]获取拉黑列表:
 /userApi/user_GetPullBlackList.php
 */
- (void)tt_GetPullBlackListWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [15]获取用户点赞视频:
 /userApi/comment_GetUserPickVideos.php
 */
- (void)tt_GetUserPickVideosParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [16]英文学习端搜索用户:
 /userApi/comment_EnLearnSearchUser.php
 */
- (void)tt_EnLearnSearchUserWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [17]视频评论列表:
 /userApi/enLearnEndVideo_GetVideoComment.php
 */
- (void)tt_GetVideoEnCommentWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [18]获取评论回复列表:
 /userApi/enLearnEndVideo_GetVideoReply.php
 */
- (void)tt_GetVideoReplyWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [19]英文学习端评论回复:
 /userApi/comment_UserCommentReply.php
 */
- (void)tt_UserCommentReplyWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [20]删除英文学习端评论回复:
 /userApi/comment_DelUserCommentReply.php
 */
- (void)tt_DelUserCommentReplyWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [21]评论点赞与取消点赞:
 /userApi/comment_UserCommentLike.php
 */
- (void)tt_UserCommentLikeWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [22]获取用户的新旧消息:
 /userApi/message_PrepareUserMsgData.php
 */
- (void)tt_PrepareUserMsgDataWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [23]系统消息:
 /userApi/message_FindMessageSystem.php
 */
- (void)tt_FindMessageSystemWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [24]消息助手:
 /userApi/message_FindMessage.php
 */
- (void)tt_FindMessageWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [25]评论消息:
 /userApi/message_GetLearnEndCommment.php
 */
- (void)tt_GetLearnEndCommmentWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [26]点赞消息:
 /userApi/message_GetLearnEndLike.php
 */
- (void)tt_GetLearnEndLikeWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [27]关注消息:
 /userApi/message_GetLearnEndUserFollow.php
 */
- (void)tt_GetLearnEndUserFollowWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [28]第三方登录:
 /userApi/user_AuthLogin.php
 */
- (void)tt_user_AuthLoginWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [29]第三方绑定:
 /userApi/user_BindAuthAccount.php
 */
- (void)tt_user_BindAuthAccountWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [30]所有账号显示:
 /userApi/user_GetUserAuthInfo.php
 */
- (void)tt_user_GetUserAuthInfoWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [31]解除绑定:
 /userApi/user_RelieveBind.php
 */
- (void)tt_user_RelieveBindWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 [32]检测该手机号是否可以注册、绑定:
 /userApi/user_VerificationAccount.php
 */
- (void)tt_user_VerificationAccountWithParameters:(id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

#pragma mark - 内部使用

/**
 [1] 获取 AppStore 的最新版本
 http://itunes.apple.com/cn/lookup?id=1463560267
 */
- (void)tt_AppStoreVersionWithSuccess:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
