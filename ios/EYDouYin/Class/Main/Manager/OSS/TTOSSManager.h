//
//  TTOSSManager.h
//  TTEnglish
//
//  Created by 李二洋 on 2018/12/14.
//  Copyright © 2019 TTEnglish. All rights reserved.
//  阿里云单例管理类

#import <Foundation/Foundation.h>
#import <AliyunOSSiOS/AliyunOSSiOS.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TTOSSManagerResumableState) {
    TTOSSManagerResumableStateFree,      //空闲状态
    TTOSSManagerResumableStateUploading, //正在上传状态
};

@interface TTOSSManager : NSObject

/**
 断点上传的状态
 */
@property (assign, nonatomic) TTOSSManagerResumableState resumableState;

#pragma mark - 未验证
+ (instancetype)manager;

/**
 异步上传图片

 @param image 需要上传的图片
 @param progress 进度回调
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)ey_asyncPutImage:(UIImage *)image progress:(nullable void (^)(CGFloat precent))progress success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/**
 断点续传

 @param localFilePath 需要上传的本地文件路径
 @param parameters 字典 (task_id & task_name & firstImage)
 @param progress 上传进度
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)ey_resumableUploadWithLocalFilePath:(NSString *)localFilePath parameters:(NSDictionary *)parameters progress:(nullable void (^)(CGFloat precent))progress success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
