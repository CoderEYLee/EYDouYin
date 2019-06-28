//
//  EYConstant.m
//  EYDouYin
//
//  Created by lieryang on 2016/11/5.
//  Copyright © 2016年 lieryang. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 基地址
//NSString *const TTAPPStoreURLString = @"https://m.chinlab.com";//生产地址
//NSString *const TTAPPStoreURLString = @"https://master.chinlab.cn";//测试1
NSString *const TTAPPStoreURLString = @"https://test.chinlab.cn";//测试2


#pragma mark - 阿里云

// 图片视频拼接前缀 (阿里云的Endpoint)
NSString *const TTOSSAPPStoreEndpoint = @"https://videoali.chinlab.com";
NSString *const TTTXVodPlayConfigPath = @"TTTXVodPlayConfigPath";
NSString *const TTOSSAPPStoreBucketName = @"chinlab-video"; // BucketName
NSString *const TTOSSAvatarFileDirName = @"avatar/";        //头像文件夹
NSString *const TTOSSVideoFileDirName = @"video/";          //视频文件夹

#pragma mark - 持久化存储的 Key
NSString *const TTVideoSearchHistory = @"TTVideoSearchHistory";
NSString *const TTReportSQLiteName = @"TTReportSQLiteName";
