//
//  EYManager.h
//  TTEnglish
//
//  Created by 李二洋 on 2018/11/19.
//  Copyright © 2019 TTEnglish. All rights reserved.
//  单例管理类

#import <Foundation/Foundation.h>
@class EYUserModel;

NS_ASSUME_NONNULL_BEGIN

@interface EYManager : NSObject

+ (instancetype)manager;

#pragma mark - 用户信息
/**
 得到值
 */
@property (readonly, nonatomic) EYUserModel *userModel;

/**
 存储值

 @param userModel 需要存储的数据
 */
- (void)saveUserModel:(EYUserModel *)userModel;

// EYMeViewController控制器使用
@property (strong, nonatomic, readonly) NSArray *meArray;

// EYCollectionViewController控制器使用
@property (strong, nonatomic, readonly) NSArray *collectionArray;

#pragma mark -- 用户上传过的视频 --
//查找是否上传过该视频，上传过返回yes未上传返回no
- (BOOL)search_video_tag:(NSString *)video_tag;

//添加用户上传的视频
- (void)add_video_tag:(NSString *)video_tag;

#pragma mark -- 用户搜索历史 --
//搜索内容
@property (nonatomic,copy)NSString *search_history_content;
//获取搜索历史
- (NSArray *)search_history;
//删除搜索历史
- (void)delete_search_history_content:(NSString *)delete_content;
//全部删除搜索历史
- (void)delete_search_all;

#pragma mark - 所有
/**
 清除该单例中所有内存数据(退出登录的时候调用)
 */
- (void)clearAllMemoryData;

@end

NS_ASSUME_NONNULL_END
