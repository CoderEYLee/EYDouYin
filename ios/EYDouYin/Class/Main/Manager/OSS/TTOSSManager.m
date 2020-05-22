//
//  TTOSSManager.m
//  TTEnglish
//
//  Created by 李二洋 on 2018/12/14.
//  Copyright © 2019 TTEnglish. All rights reserved.
//

#import "TTOSSManager.h"
#import <AVFoundation/AVFoundation.h>
@interface TTOSSManager()

/**
 阿里云上传的对象
 */
@property (strong, nonatomic) OSSClient *ossClient;

@end

@implementation TTOSSManager

#pragma mark - 初始化
// 用来保存唯一的单例对象
static TTOSSManager *_OSSmanager = nil;

+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _OSSmanager = [[self alloc] init];
    });
    return _OSSmanager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _OSSmanager = [super allocWithZone:zone];
    });
    return _OSSmanager;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return _OSSmanager;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _OSSmanager;
}

- (instancetype)init {
    self = [super init];
    if (self) {// 初始化
        id<OSSCredentialProvider> credential = [[OSSFederationCredentialProvider alloc] initWithFederationTokenGetter:^OSSFederationToken * {
            // 您需要在这里实现获取一个FederationToken，并构造成OSSFederationToken对象返回
            // 下面是一些获取token的代码，比如从您的server获取

            __block NSDictionary *dictionary = nil;//返回的 json

            dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//            [[EYHTTPManager manager] ey_GetAuthFileTokenWithParameters:parameters success:^(id  _Nullable responseObject) {
//                dictionary = responseObject;
//                dispatch_semaphore_signal(semaphore);
//            } failure:^(NSError * _Nonnull error) {
                dispatch_semaphore_signal(semaphore);
//            }];
            dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER);

            NSDictionary *credentials = dictionary[@"data"][@"Credentials"];
            OSSFederationToken *token = [[OSSFederationToken alloc] init];
            token.tAccessKey = credentials[@"AccessKeyId"];
            token.tSecretKey = credentials[@"AccessKeySecret"];
            token.tToken = credentials[@"SecurityToken"];
            token.expirationTimeInGMTFormat = credentials[@"Expiration"];
            return token;
        }];
        
        _ossClient = [[OSSClient alloc] initWithEndpoint:TTOSSAPPStoreEndpoint credentialProvider:credential];
        _resumableState = TTOSSManagerResumableStateFree;//空闲状态
    }
    return self;
}

/**
 异步上传图片

 @param image 需要上传的图片
 @param progress 进度回调
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)ey_asyncPutImage:(UIImage *)image progress:(void (^)(CGFloat))progress success:(nullable void (^)(id _Nullable))success failure:(nullable void (^)(NSError * _Nonnull))failure {
    // user_id 后四位+时间戳
    NSMutableString *objectKey = [NSMutableString stringWithString:TTOSSAvatarFileDirName];
    NSString *user_id = [EYManager manager].userModel.user_id;
    if (user_id.length >= 4) {
        NSString *text = [user_id substringFromIndex:user_id.length - 4];
        [objectKey appendString:text];
    }

    [objectKey appendFormat:@"%ld", (long)[NSDate date].timeIntervalSince1970];
    [objectKey appendString:@".png"];

    // 1. 创建上传对象
    OSSPutObjectRequest * put = [[OSSPutObjectRequest alloc] init];
    put.bucketName = TTOSSAPPStoreBucketName;
    put.objectKey = objectKey;  //上传文件的名字
    put.uploadingData = UIImagePNGRepresentation(image); // 直接上传NSData
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        CGFloat totalByteSentFloat = (CGFloat)totalByteSent;
        CGFloat totalBytesExpectedToSendFloat = (CGFloat)totalBytesExpectedToSend;
        if (progress) {
            progress(totalByteSentFloat/totalBytesExpectedToSendFloat);
        }
    };

    // 2.上传任务
    OSSTask *putTask = [self.ossClient putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (task.error) {
            if (failure) {
                EYLog(@"图片上传：%@",task.error);
                failure(task.error);
            }
        } else {
            if (success) {
                NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
                dictionary[@"message"] = @"上传对象成功";
                dictionary[@"fileName"] = objectKey;
                success(dictionary);
            }
        }
        return nil;
    }];
    // 可以等待任务完成
    // [putTask waitUntilFinished];
}

/**
 断点续传

 @param localFilePath 需要上传的本地文件路径
 @param parameters 字典 (task_id & task_name & firstImage)
 @param progress 上传进度
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)ey_resumableUploadWithLocalFilePath:(NSString *)localFilePath parameters:(NSDictionary *)parameters progress:(void (^)(CGFloat))progress success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {

    if (self.resumableState == TTOSSManagerResumableStateUploading) {//正在上传状态
        dispatch_async(dispatch_get_main_queue(), ^{
            [EYProgressHUD showInfoWithStatus:@"有视频正在上传~"];
            if (failure) {
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
                userInfo[@"error_reason"] = @"有视频正在上传~";
                NSError *error = [NSError errorWithDomain:@"视频上传" code:0 userInfo:userInfo];
                failure(error);
            }
        });

        return;
    }
    
    NSString *video_location_id = parameters[@"video_location_id"];
    // 0:开始 1:正在进行上传 2:成功 3:失败
    NSMutableDictionary *dictionaryM = [NSMutableDictionary dictionary];
    dictionaryM[@"state"] = @"0";
    dictionaryM[@"firstImage"] = parameters[@"firstImage"];

    dispatch_async(dispatch_get_main_queue(), ^{
        // [EYNotificationCenter postNotificationName:CLSendVideoProgressNotification object:nil userInfo:dictionaryM];
    });

    // user_id 后四位+时间戳
    NSMutableString *objectKey = [NSMutableString stringWithString:TTOSSVideoFileDirName];
    NSString *user_id = [EYManager manager].userModel.user_id;
    if (user_id.length >= 4) {
        NSString *text = [user_id substringFromIndex:user_id.length - 4];
        [objectKey appendString:text];
    }

    [objectKey appendFormat:@"%ld", (long)[NSDate date].timeIntervalSince1970];
    [objectKey appendString:@".mp4"];

    // 获得UploadId进行上传，如果任务失败并且可以续传，利用同一个UploadId可以上传同一文件到同一个OSS上的存储对象
    OSSResumableUploadRequest *resumableUpload = [OSSResumableUploadRequest new];
    resumableUpload.bucketName = TTOSSAPPStoreBucketName;
    resumableUpload.objectKey = objectKey;
    resumableUpload.partSize = 1024 * 1024;
    resumableUpload.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        CGFloat totalByteSentFloat = (CGFloat)totalByteSent;
        CGFloat totalBytesExpectedToSendFloat = (CGFloat)totalBytesExpectedToSend;
        CGFloat precent = totalByteSentFloat/totalBytesExpectedToSendFloat;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progress) {
                progress(precent);
            }
            dictionaryM[@"state"] = @"1";
            dictionaryM[@"progress"] = @(precent);
            // [EYNotificationCenter postNotificationName:CLSendVideoProgressNotification object:nil userInfo:dictionaryM];
        });
    };

//    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
//    //设置断点记录文件
//    resumableUpload.recordDirectoryPath = cachesDir;
//    //设置NO,取消时，不删除断点记录文件，如果不进行设置，默认YES，是会删除断点记录文件，下次再进行上传时会重新上传。
//    resumableUpload.deleteUploadIdOnCancelling = NO;

    resumableUpload.uploadingFileURL = [NSURL fileURLWithPath:localFilePath];
    OSSTask *resumeTask = [self.ossClient resumableUpload:resumableUpload];

    // 设置回调参数
    resumableUpload.callbackParam = @{
            @"callbackUrl": @"https://m.chinlab.com/userApi/comment_UserUploadCallback.php",
            @"callbackBody": @"filename=${object}&size=${size}&user_id=${x:user_id}&user_image=${x:user_image}&video_from=${x:video_from}&user_nikename=${x:user_nikename}&task_id=${x:task_id}&task_name=${x:task_name}"
            };
    // 设置自定义变量
    resumableUpload.callbackVar = @{
            @"x:user_id": [EYManager manager].userModel.user_id,
            @"x:user_image": [EYManager manager].userModel.user_image ?:@"",
            @"x:video_from": @"2",
            @"x:user_nikename": [EYManager manager].userModel.user_nikename,
            @"x:task_id": parameters[@"task_id"],
            @"x:task_name": parameters[@"task_name"]
        };

    [resumeTask continueWithBlock:^id(OSSTask *task) {
        if (task.error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                EYLog(@"断点续传上传失败: %@", task.error);
                if ([task.error.domain isEqualToString:OSSClientErrorDomain] && task.error.code == OSSClientErrorCodeCannotResumeUpload) {
                    // 该任务无法续传，需要获取新的uploadId重新上传
                }
                //1.更改状态
                self.resumableState = TTOSSManagerResumableStateFree;

                //2.发出通知
                dictionaryM[@"state"] = @"3";
                // [EYNotificationCenter postNotificationName:CLSendVideoProgressNotification object:nil userInfo:dictionaryM];

                //3.提示信息
                // [EYProgressHUD showInfoWithStatus:@"上传视频失败"];

                //4.回调 block
                if (failure) {
                    failure(task.error);
                }
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                EYLog(@"断点续传上传成功");
                
                //0.记录上传成功的
                if (video_location_id.length > 0) {
                    [[EYManager manager]add_video_tag:video_location_id];
                }
                EYLog(@"上传成功时:%@",video_location_id);
                //1.更改状态
                self.resumableState = TTOSSManagerResumableStateFree;

                //2.发出通知
                dictionaryM[@"state"] = @"2";
                // [EYNotificationCenter postNotificationName:CLSendVideoProgressNotification object:nil userInfo:dictionaryM];

                //3.提示信息
                // [EYProgressHUD showInfoWithStatus:@"上传视频成功"];

                //4.回调 block
                if (success) {
                    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
                    dictionary[@"message"] = @"上传对象成功";
                    dictionary[@"fileName"] = objectKey;
                    success(dictionary);
                }
            });
        }
        return nil;
    }];

    //正在上传状态
    self.resumableState = TTOSSManagerResumableStateUploading;

    // [resumeTask waitUntilFinished];

    // [resumableUpload cancel];
}

@end
