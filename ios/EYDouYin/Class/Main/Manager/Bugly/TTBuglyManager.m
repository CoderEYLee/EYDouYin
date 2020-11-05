//
//  TTBuglyManager.m
//  TTEnglish
//
//  Created by 李二洋 on 2020/4/14.
//  Copyright © 2020 TaoTie. All rights reserved.
//

#import "TTBuglyManager.h"
#import <Bugly/Bugly.h>
#import "EYDeviceInformation.h"

@interface TTBuglyManager() <BuglyDelegate>

@end

@implementation TTBuglyManager

static NSString *const TTBuglyAppID = @"123";

#pragma mark - 初始化
// 用来保存唯一的单例对象
static TTBuglyManager *_BuglyManager = nil;

+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _BuglyManager = [[self alloc] init];
    });
    return _BuglyManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _BuglyManager = [super allocWithZone:zone];
    });
    return _BuglyManager;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return _BuglyManager;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _BuglyManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //1.添加通知
        [self addNotification];
    }
    return self;
}

///开始 Buglyg功能
- (void)startBugly {
    BuglyConfig *config = [[BuglyConfig alloc] init];
    config.version = [EYDeviceInformation getAPPVerion];
    config.deviceIdentifier = [EYDeviceInformation getUUID];
    config.blockMonitorEnable = YES;
    config.blockMonitorTimeout = 5;
    config.unexpectedTerminatingDetectionEnable = YES;
    config.reportLogLevel = BuglyLogLevelVerbose;
    config.excludeModuleFilter = @[@"SogouInputIPhone.dylib", @"libobjc.A.dylib"];
    config.delegate = self;
    config.debugMode = NO;
    #ifdef DEBUG
        config.channel = @"DEBUG";
        [Bugly startWithAppId:TTBuglyAppID developmentDevice:YES config:config];
    #else
        config.channel = @"App Store";
        [Bugly startWithAppId:TTBuglyAppID developmentDevice:NO config:config];
    #endif
    
    ///设置标识
//    if ([TTManager manager].userModel) {
//        [Bugly setUserIdentifier:[TTManager manager].userModel.user_id];
//    }
}

//1.添加通知
- (void)addNotification {
    
}

#pragma mark - 通知

/**
 *    @brief 上报自定义错误
 *
 *    @param category    类型(Cocoa=3,CSharp=4,JS=5,Lua=6)
 *    @param aName       名称
 *    @param aReason     错误原因
 *    @param aStackArray 堆栈
 *    @param info        附加数据
 *    @param terminate   上报后是否退出应用进程
 */
- (void)reportExceptionWithCategory:(NSUInteger)category name:(NSString *)aName reason:(NSString *)aReason callStack:(NSArray *)aStackArray extraInfo:(NSDictionary *)info terminateApp:(BOOL)terminate {
    [Bugly reportExceptionWithCategory:category name:aName reason:aReason callStack:aStackArray extraInfo:info terminateApp:terminate];
}

#pragma mark - BuglyDelegate
/**
 *  发生异常时回调
 *
 *  @param exception 异常信息
 *
 *  @return 返回需上报记录，随异常上报一起上报
 */
- (NSString *)attachmentForException:(NSException *)exception {
    NSString *string = @"";
    #ifdef DEBUG
    string = @"App调试";
    #endif
    
    return string;
}

@end
