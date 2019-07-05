//
//  EYDeviceInformation.h
//  TTEnglish
//
//  Created by 李二洋 on 2018/11/28.
//  Copyright © 2019 TTEnglish. All rights reserved.
//  获取 iPhone 收集各种信息

#import <UIKit/UIKit.h>

@interface EYDeviceInformation : NSObject

/// 获取设备版本号
+ (nullable NSString *)getDeviceName;

/// 获取iPhone名称
+ (nonnull NSString *)getiPhoneName;

/// 获取app版本号
+ (nullable NSString *)getAPPVerion;

/// 获取app build版本号
+ (nullable NSString *)getAPPBuildVerion;

/// 获取电池电量
+ (CGFloat)getBatteryLevel;

/// 当前系统名称
+ (nonnull NSString *)getSystemName;

/// 当前系统版本号
+ (nonnull NSString *)getSystemVersion;

/// 通用唯一识别码UUID
+ (nonnull NSString *)getUUID;

/// 获取app IDFA版本号
+ (nullable NSString *)getIDFA;

/// 获取当前设备IP
+ (nonnull NSString *)getDeviceIPAdress;

/// 获取当前wifi的SSID
+ (nullable NSString *)getCurrentWiFiSSID;

/// 获取总内存大小
+ (long long)getTotalMemorySize;

/// 获取当前可用内存
+ (long long)getAvailableMemorySize;

/// 获取电池当前的状态，共有4种状态
+ (nullable NSString *)getBatteryState;

/// 获取当前语言
+ (nullable NSString *)getDeviceLanguage;

@end
