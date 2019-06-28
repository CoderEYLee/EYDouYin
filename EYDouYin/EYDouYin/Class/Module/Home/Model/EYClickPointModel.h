//
//  EYClickPointModel.h
//  TTEnglish
//
//  Created by 李二洋 on 2019/6/21.
//  Copyright © 2019 TaoTie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTClickPointParamModel : NSObject

/**
 视频 id
 */
@property (copy, nonatomic) NSString *video_id;

/**
 视频播放对应的页面(该条视频在哪个页面进行播放的)
 */
@property (copy, nonatomic) NSString *video_page;

/**
 视频播放的次数(不包括最后一次)
 */
@property (assign, nonatomic) NSUInteger play_count;

/**
 最后一次的播放时间
 */
@property (assign, nonatomic) NSUInteger play_time;

/**
 单词
 */
@property (copy, nonatomic) NSString *word;

/**
 具体任务名称
 */
@property (copy, nonatomic) NSString *task_id;

/**
 评论id
 */
@property (copy, nonatomic) NSString *comment_id;

/**
 评论内容
 */
@property (copy, nonatomic) NSString *comment;

/**
 难度等级
 */
@property (assign, nonatomic) NSInteger difficulty;

/**
 别人的 user_id
 */
@property (copy, nonatomic) NSString *user_id;

@end

typedef NS_ENUM(NSInteger, EYClickPointModelAction) {
    EYClickPointModelActionPlayorPause = 1,                 //播放/暂停
    EYClickPointModelActionPlaytimes,                   //完整播放次数
    EYClickPointModelActionChecksubtitle,               //点击字幕
    EYClickPointModelActionCollect_subtitle,            //收藏
    EYClickPointModelActionUncollect_subtitle,          //取消收藏
    EYClickPointModelActionPronunciation_subtitle,      //点击发音
    EYClickPointModelActionTask,                        //用户点击主页左下方的任务标签
    EYClickPointModelActionSearch,                      //用户点击主页左上方搜索按钮
    EYClickPointModelActionComment,                     //点击评论按钮
    EYClickPointModelActionCommentlike_video,           //给评论点赞
    EYClickPointModelActionCommentunlike_video,         //取消评论点赞
    EYClickPointModelActionCommentgive_video,           //发出评论/回复
    EYClickPointModelActionUsercheck_comment,           //通过评论进入某用户界面
    EYClickPointModelActionLike,                        //赞
    EYClickPointModelActionUnlike,                      //取消点赞
    EYClickPointModelActionLastsentence,                //点击回到上一句按钮
    EYClickPointModelActionShare,                       //点击转发按钮
    EYClickPointModelActionSharecancel,                 //退出转发界面
    EYClickPointModelActionShareWechatfriend,           //点击转发至微信好友
    EYClickPointModelActionShareWechatmoment,           //至微信朋友圈
    EYClickPointModelActionShareWeibo,                  //至微博
    EYClickPointModelActionShareQqfriend,               //至qq好友
    EYClickPointModelActionShareQqzone,                 //至QQ空间
    EYClickPointModelActionShareDownload,               //用户点击下载视频
    EYClickPointModelActionShareWithoutsubtitle,        //用户关闭”带字幕转发/下载”
    EYClickPointModelActionShareWithsubtitle,           //用户开启”带字幕转发/下载”
    EYClickPointModelActionDifficulty,                  //用户点击“调节难度”按钮
    EYClickPointModelActionDifficultyLeft,              //用户点击左按钮，降低难度
    EYClickPointModelActionDifficultyRight,             //用户点击右按钮，提高难度
    EYClickPointModelActionDifficultypoint,             //用户点击下方难度位点
    EYClickPointModelActionDifficultydrag,              //用户拖动吃豆人并释放
    EYClickPointModelActionDifficultydone,              //用户点击完成
    EYClickPointModelActionOther,                       //用户点击“其它”按钮
    EYClickPointModelActionNotinterested,               //用户点击“不感兴趣”
    EYClickPointModelActionReport,                      //用户点击“举报”
    EYClickPointModelActionUsercheck_video,             //用户点击视频主页的作者头像
    EYClickPointModelActionFollow_video,                //点击加号进行关注
    EYClickPointModelActionSearch_words,                //用户搜索字/词或切换到字词tab，记录
    EYClickPointModelActionSearch_video,                //用户点击搜索出的视频结果观看，记录
    EYClickPointModelActionPronunciation_search,        //用户点击发音按钮
    EYClickPointModelActionSearch_cancel,               //用户点击取消搜索按钮
    EYClickPointModelActionUsercheck_searchwords,       //通过字词搜索界面进入某用户主页
    EYClickPointModelActionSearch_users,                //用户切换到用户Tab，记录
    EYClickPointModelActionFollow_search,               //搜索用户界面下关注
    EYClickPointModelActionUnfollow_search,             //搜索用户界面下取关
    EYClickPointModelActionUsercheck_search,            //通过用户搜索tab进入某用户主页
    EYClickPointModelActionFollow_contributor,          //用户关注贡献者
    EYClickPointModelActionUnfollow_contributor,        //用户点击“已关注”取关贡献者
    EYClickPointModelActionContributor_follow,          //用户查看贡献者的关注列表
    EYClickPointModelActionContributor_fans,            //用户查看贡献者的粉丝列表
    EYClickPointModelActionFollow_CFollowList,          //用户在贡献者的关注列表中进行关注
    EYClickPointModelActionUnfollow_CFollowList,        //用户在贡献者的关注列表中进行取消关注
    EYClickPointModelActionUsercheck_CFollowList,       //用户在贡献者的关注列表中进入某用户主页
    EYClickPointModelActionFollow_CFanList,             //用户在贡献者的粉丝列表中进行关注
    EYClickPointModelActionUnfollow_CFanList,           //用户在贡献者的粉丝列表中进行取消关注
    EYClickPointModelActionUsercheck_CFanList,          //用户在贡献者的粉丝列表中进入某用户主页
    EYClickPointModelActionContributor_works,           //用户切换到贡献者的作品Tab
    EYClickPointModelActionContributor_liked,           //用户切换到贡献者的点赞Tab
    EYClickPointModelActionContributor_other,           //用户点击“其它”
    EYClickPointModelActionContributor_report,          //用户点击举报贡献者
    EYClickPointModelActionContributor_block,           //用户点击拉黑贡献者
    EYClickPointModelActionFollow_Learner,              //用户关注学习者
    EYClickPointModelActionUnfollow_Learner,            //用户点击“已关注”取关学习者
    EYClickPointModelActionLearner_follow,              //用户查看学习者的关注列表
    EYClickPointModelActionLearner_fans,                //用户查看学习者的粉丝列表
    EYClickPointModelActionFollow_LFollowList,          //用户在学习者的关注列表中进行关注
    EYClickPointModelActionUnfollow_LFollowList,        //用户在学习者的关注列表中进行取消关注
    EYClickPointModelActionUsercheck_LFollowList,       //用户在学习者的关注列表中进入某用户主页
    EYClickPointModelActionFollow_LFanList,             //用户在学习者的粉丝列表中进行关注
    EYClickPointModelActionUnfollow_LFanList,           //用户在学习者的粉丝列表中进行取消关注
    EYClickPointModelActionUsercheck_LFanList,          //用户在学习者的粉丝列表中进入某用户主页
    EYClickPointModelActionLearner_collect,             //用户切换到学习者的收藏Tab
    EYClickPointModelActionLearner_liked,               //用户切换到学习者的点赞Tab
    EYClickPointModelActionLearner_other,               //用户点击“其它”
    EYClickPointModelActionLearner_report,              //用户点击举报学习者
    EYClickPointModelActionLearner_block,               //用户点击拉黑学习者
    EYClickPointModelActionMsg_tab,                     //用户进入消息页面
    EYClickPointModelActionMsg_like,                    //用户查看获赞列表页面
    EYClickPointModelActionMsg_comreply,                //用户查看新评论/回复列表页面
    EYClickPointModelActionMsg_newfan,                  //用户查看新粉丝列表页面
    EYClickPointModelActionMsg_renew,                   //用户下拉刷新此页面
    EYClickPointModelActionMsg_assistant,               //用户查看助手消息
    EYClickPointModelActionMsg_official,                //用户查看官方消息
    EYClickPointModelActionCommentlike_Msg,             //用户通过消息页面给一个新评论点赞
    EYClickPointModelActionCommentunlike_Msg,           //用户通过消息页面给一个新评论取消点赞
    EYClickPointModelActionCommentgive_Msg,             //用户通过消息页面给一个新评论进行回复
    EYClickPointModelActionFollow_NewFanList,           //用户在自己的新增粉丝界面中进行关注
    EYClickPointModelActionUnfollow_NewFanList,         //用户在自己的新增粉丝界面中进行取消关注
    EYClickPointModelActionUsercheck_NewFanList,        //用户在自己的新增粉丝界面中进入某用户主页
    EYClickPointModelActionMe_tab,                      //用户进入个人中心界面
    EYClickPointModelActionMe_like,                     //用户点击自己的点赞Tab
    EYClickPointModelActionMe_collect,                  //用户点击自己的收藏Tab
    EYClickPointModelActionMe_collected,                //用户点击查看自己收藏的具体单词
    EYClickPointModelActionMe_follow,                   //用户查看自己的关注列表
    EYClickPointModelActionMe_fans,                     //用户查看自己的粉丝列表
    EYClickPointModelActionMe_profile,                  //用户点击自己的头像，进入个人资料页
    EYClickPointModelActionMe_settings,                 //用户点击设置按钮
    EYClickPointModelActionHomepage,                    //用户切换回视频流首页
    EYClickPointModelActionSatrtApp,                    //启动 App
    EYClickPointModelActionLoginApp = 100,              //登录 App
};

@interface EYClickPointModel : NSObject

/**
 用户 user_id 自动产生(可能为空)
 */
@property (copy, nonatomic) NSString *user_id;

/**
 操作 id(埋点 id)
 */
@property (assign, nonatomic) EYClickPointModelAction action_id;

/**
 日志创建时间 自动产生
 */
@property (copy, nonatomic) NSString *create_time;

/**
 具体参数
 */
@property (strong, nonatomic) TTClickPointParamModel *param;

@end

NS_ASSUME_NONNULL_END
