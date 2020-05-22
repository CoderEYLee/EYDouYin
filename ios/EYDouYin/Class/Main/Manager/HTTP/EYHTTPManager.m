//
//  EYHTTPManager.m
//  TTEnglish
//
//  Created by 李二洋 on 2018/11/19.
//  Copyright © 2019 TTEnglish. All rights reserved.
//

#import "EYHTTPManager.h"
#import <AFNetworking.h>
#import "EYTabBarController.h"
#import "EYServiceUpdateView.h"

@interface EYHTTPManager()

@property (strong, nonatomic) AFURLSessionManager *afDownManager;
@property (strong, nonatomic) AFHTTPSessionManager *afManager;

@property (weak, nonatomic) EYServiceUpdateView *serviceUpdateView;

@end

@implementation EYHTTPManager

#pragma mark - 初始化
// 用来保存唯一的单例对象
static EYHTTPManager *_HTTPManager = nil;

+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _HTTPManager = [[self alloc] init];
    });
    return _HTTPManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _HTTPManager = [super allocWithZone:zone];
    });
    return _HTTPManager;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return _HTTPManager;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _HTTPManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.afDownManager = [[AFURLSessionManager alloc] init];
        self.afManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:TTAPPStoreURLString]];
//        [self.afManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//        self.afManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", @"application/x-www-form-urlencoded", @"text/plain", nil];
        //设置请求头
        NSMutableDictionary *deviceInfo = [NSMutableDictionary dictionary];
        deviceInfo[@"AppName"] = @"FreshLanguage";
        deviceInfo[@"AppVersion"] = [EYDeviceInformation getAPPVerion];
        deviceInfo[@"AppType"] = @"ios";
        deviceInfo[@"AppDeviceId"] = [EYDeviceInformation getUUID];
        deviceInfo[@"muid"] = [EYDeviceInformation getIDFA];
#ifdef DEBUG
        deviceInfo[@"AppIp"] = @"192.168.0.0";
#else
        deviceInfo[@"AppIp"] = [EYDeviceInformation getDeviceIPAdress];
#endif
        
        deviceInfo[@"AppOsName"] = [EYDeviceInformation getDeviceName];
        deviceInfo[@"AppOsVersion"] = [EYDeviceInformation getSystemVersion];
        deviceInfo[@"ver"] = @"1.2.0";//学习端标志
        deviceInfo[@"UserId"] = [EYManager manager].userModel.user_id;
        deviceInfo[@"Authorization"] = [EYManager manager].userModel.access_token;
        
        for (NSString *key in deviceInfo.allKeys) {
            [self.afManager.requestSerializer setValue:deviceInfo[key] forHTTPHeaderField:key];
        }

        //监听网络状态
        [self ey_netWorkState];
    }
    return self;
}

#pragma mark - 更新请求头
- (void)ey_updateHTTPHeaderField:(NSDictionary *)headerField {
    for (NSString *key in headerField.allKeys) {
        [self.afManager.requestSerializer setValue:[headerField valueForKey:key] forHTTPHeaderField:key];
    }
}

#pragma mark - 公共方法
- (void)ey_POST:(NSString *)URLString parameters:(nullable id)parameters success:(nullable void (^)(id _Nullable))success failure:(nullable void (^)(NSError * _Nonnull))failure {
    [self.afManager POST:URLString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        EYLog(@"POST请求回调成功\nURL--->%@%@\nresponseObject--->%@", self.afManager.baseURL, URLString, responseObject);
        [self handle:URLString parameters:parameters response:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        EYLog(@"POST请求回调失败\nURL--->%@%@\nerror--->%@", self.afManager.baseURL, URLString, error);
        if (failure) {
            failure(error);
        }
    }];
}

- (void)ey_DOWN:(NSString *)URLString progress:(void (^)(NSProgress * _Nonnull))downloadProgressBlock destination:(NSURL * _Nonnull (^)(NSURL * _Nonnull, NSURLResponse * _Nonnull))destination completionHandler:(void (^)(NSURLResponse * _Nonnull, NSURL * _Nullable, NSError * _Nullable))completionHandler {
    EYLog(@"发起下载请求--->\nURL--->%@", URLString);
    [[self.afDownManager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URLString]] progress:downloadProgressBlock destination:destination completionHandler:completionHandler] resume];
}

#pragma mark - 处理数据
- (void)handle:(NSString *)URLString parameters:(id)parameters response:(id)responseObject success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    NSInteger stateValue = [responseObject[@"state"] integerValue];
    switch (stateValue) {
        case 9001: {//服务器维护
            // 1.回调失败
            if (failure) {
                NSError *error;
                failure(error);
            }

            // 2.取消所有已经发起的请求
            [self cancelAllHTTPOperations];

            if (nil == self.serviceUpdateView) {
                EYServiceUpdateView *view = [[EYServiceUpdateView alloc] initWithFrame:CGRectMake(0, 0, EYScreenWidth, EYScreenHeight)];
                if (EYKeyWindow) {
                    self.serviceUpdateView = view;
                    [EYKeyWindow addSubview:view];
                }
            }

            break;
        }
        case 10000: {//系统错误
            // 回调失败
            if (failure) {
                NSError *error;
                failure(error);
            }
            break;
        }
        case 10030: { //访问过于频繁
            EYLog(@"EYHTTPManager==访问过于频繁");
            if (success) {
                success(responseObject);
            }
            break;
        }
        case 10031:  //登录会话失败(请求头没有 token)
        case 10032:  //sessionKey不存在
        case 10029: {//sessionKey不正确,请重新登录
            //1.更新请求头
            [self.afManager.requestSerializer setValue:@"" forHTTPHeaderField:@"Authorization"];

            //2.取消所有已经发起的请求
            [self cancelAllHTTPOperations];

            //3.清除数据
            [[EYManager manager] clearAllMemoryData];

            //4.切换界面
//            [EYKeyWindow switchRootViewController];

            //5.回调成功
            if (failure) {
                NSError *error;
                failure(error);
            }
            break;
        }
        case 10025: {// access_token过期
            [self getTokenSuccess:^(id  _Nullable responseObject) {
                EYLog(@"请求 access_token 成功了--%@--> 发起上次请求--", responseObject);
                [self ey_POST:URLString parameters:parameters success:success failure:failure];
            } failure:failure];
            break;
        }

        default: {//其他状态
            if (success) {
                success(responseObject);
            }
            break;
        }
    }
}

- (void)getTokenSuccess:(void (^)(id _Nullable))success failure:(void (^)(NSError *))failure {

    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    
    NSString *URLString = @"";

    EYLog(@"getToken请求--%@%@--%@-", self.afManager.baseURL, URLString, parameters);
    [self.afManager POST:URLString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger stateValue = [responseObject[@"state"] integerValue];
        EYLog(@"getToken请求回来数据-----%@", responseObject);
        switch (stateValue) {
            case 0: {
                NSDictionary *data = responseObject[@"data"];
                //1.更新 请求头
                NSString *access_token = data[@"access_token"];
                [self.afManager.requestSerializer setValue:access_token forHTTPHeaderField:@"Authorization"];

                //2.更新用户
                NSMutableDictionary *dictionaryM = [EYManager manager].userModel.mj_keyValues;
                [dictionaryM addEntriesFromDictionary:data];
                [[EYManager manager] saveUserModel:[EYUserModel mj_objectWithKeyValues:dictionaryM]];

                //3.回调成功
                if (success) {
                    success(responseObject);
                }

                break;
            }
            case 10000: {//系统错误
                // 回调失败
                if (failure) {
                    NSError *error;
                    failure(error);
                }
                break;
            }
//            case 10001: //参数不能为空
//            case 10005: //发送过于频繁
//            case 10030: //访问过于频繁
            case 10031: //登录会话失败
            case 10032: //sessionKey不存在
            case 10029: {//sessionKey不正确,请重新登录
                //1.更新请求头
                [self.afManager.requestSerializer setValue:@"" forHTTPHeaderField:@"Authorization"];

                //2.取消所有已经发起的请求
                [self cancelAllHTTPOperations];

                //3.清除数据
                [[EYManager manager] clearAllMemoryData];

                //4.切换界面
//                [EYKeyWindow switchRootViewController];

                //5.回调失败
                if (failure) {
                    NSError *error;
                    failure(error);
                }
                break;
            }

            default: {//其他状态
                if (success) {
                    success(responseObject);
                }
                break;
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 取消所有网络已经发起的请求
- (void)cancelAllHTTPOperations {
    [self.afManager.operationQueue cancelAllOperations];
    for (NSURLSessionDataTask *task in self.afManager.dataTasks) {
        [task cancel];
    }
}

//监听网络状态
- (void)ey_netWorkState {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                EYLog(@"未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                EYLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [EYProgressHUD showInfoWithStatus:EYLocalized(@"tt_0101_0")];
                EYLog(@"手机流量网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                EYLog(@"wifi");
                break;
                
            default:
                break;
        }
    }];
    //3.开始监听
    [manager startMonitoring];
    
}

@end
