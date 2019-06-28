//
//  EYHTTPManager.h
//  TTEnglish
//
//  Created by 李二洋 on 2018/11/19.
//  Copyright © 2019 TTEnglish. All rights reserved.
//  网络请求的单例管理类

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EYHTTPManager : NSObject

+ (instancetype)manager;

#pragma mark - 更新请求头
- (void)tt_updateHTTPHeaderField:(NSDictionary *)headerField;

#pragma mark - 异步请求
- (void)tt_GET:(NSString *)URLString parameters:(nullable id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)tt_POST:(NSString *)URLString parameters:(nullable id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)tt_PUT:(NSString *)URLString parameters:(nullable id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

- (void)tt_DOWN:(NSString *)URLString progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgressBlock
    destination:(nullable NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination completionHandler:(nullable void (^)(NSURLResponse *response, NSURL * _Nullable filePath, NSError * _Nullable error))completionHandler;

// 取消所有网络已经发起的请求
- (void)cancelAllHTTPOperations;

@end

NS_ASSUME_NONNULL_END
