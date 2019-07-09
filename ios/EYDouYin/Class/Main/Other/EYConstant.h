//
//  EYConstant.h
//  EYDouYin
//
//  Created by lieryang on 2016/11/5.
//  Copyright © 2016年 lieryang. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 通用枚举

typedef NS_ENUM(NSInteger, EYJumpType) {
    EYJumpTypeDefault,                  // 默认值
    
    #pragma mark - 界面上的按钮
    //首页
    
    
    //我的
    EYJumpTypeMineUserBackImageButton,  //用户背景图片按钮
    EYJumpTypeMineUserHeaderButton,     //用户头像按钮
    EYJumpTypeMineProfileButton,        //用户编辑个人资料按钮
    EYJumpTypeMineFocusButton,          //用户关注按钮
    EYJumpTypeMineAddFriendButton,      //用户添加好友按钮
    EYJumpTypeMineSignatureButton,      //用户修改个人简介按钮
    EYJumpTypeMineAgeButton,            //用户修改年龄按钮
    EYJumpTypeMineLocationButton,       //用户修改定位按钮
    EYJumpTypeMineSchoolButton,         //用户修改学校按钮
    EYJumpTypeMineToMeLikeButton,       //用户得到的赞数按钮
//    EYJumpTypeMineSchoolButton,       //用户修改学校按钮
    
    
    #pragma mark - 跳转方式
    //其他地方--->首页
    
    //其他地方--->我的
    EYJumpTypeHomeToMe,                 // 首页--->我的
};

#pragma mark - 基地址
UIKIT_EXTERN NSString *const TTAPPStoreURLString;

#pragma mark - 阿里云

UIKIT_EXTERN NSString *const TTOSSAPPStoreEndpoint;
UIKIT_EXTERN NSString *const TTTXVodPlayConfigPath;
UIKIT_EXTERN NSString *const TTOSSAPPStoreBucketName;
UIKIT_EXTERN NSString *const TTOSSAvatarFileDirName;
UIKIT_EXTERN NSString *const TTOSSVideoFileDirName;

#pragma mark - 持久化存储的 Key
UIKIT_EXTERN NSString *const TTVideoSearchHistory;
UIKIT_EXTERN NSString *const TTReportSQLiteName;
