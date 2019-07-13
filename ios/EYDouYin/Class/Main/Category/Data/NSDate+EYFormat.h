//
//  NSDate+EYFormat.h
//  TTEnglish
//
//  Created by 李二洋 on 2018/12/6.
//  Copyright © 2019 TTEnglish. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (EYFormat)

#pragma mark - NSString
#pragma mark - date 时间
/**
 将'时间戳'按照'对应是格式'就行格式化, 返回最终的结果'字符串'

 @param interval 1970-1-1 的时间戳
 @param formatterString 需要格式化的标准
 @return 返回格式化后的字符串
 */
+ (NSString *)ey_stringWithTimeIntervalSince1970:(NSTimeInterval)interval withDateFormatter:(NSString *)formatterString;

/**
 将'时间'按照'对应是格式'就行格式化, 返回最终的结果'字符串'

 @param date 任意时间
 @param formatterString 需要格式化的标准
 @return 返回格式化后的字符串
 */
+ (NSString *)ey_stringWithDate:(NSDate *)date withDateFormatter:(NSString *)formatterString;

/**
 yyyy-MM-dd HH:mm:ss

 @param date 任意时间
 @return 返回格式化后的字符串
 */
+ (NSString *)ey_stringyyyyMMddHHmmssWithDate:(NSDate *)date;

/**
 yyyy-MM-dd HH:mm

 @param date 任意时间
 @return 返回格式化后的字符串
 */
+ (NSString *)ey_stringyyyyMMddHHmmWithDate:(NSDate *)date;

/**
 yyyy-MM-dd

 @param date 任意时间
 @return 返回格式化后的字符串
 */
+ (NSString *)ey_stringyyyyMMddWithDate:(NSDate *)date;

/**
 HH:mm:ss

 @param date 任意时间
 @return 返回格式化后的字符串
 */
+ (NSString *)ey_stringHHmmssWithDate:(NSDate *)date;

#pragma mark - 当前手机时间

/**
 yyyy-MM-dd HH:mm:ss

 @return 格式化后的字符串
 */
+ (NSString *)ey_stringyyyyMMddHHmmssWithCurrentDate;

/**
 yyyy-MM-dd HH:mm

 @return 格式化后的字符串
 */
+ (NSString *)ey_stringyyyyMMddHHmmWithCurrentDate;

/**
 yyyy-MM-dd

 @return 格式化后的字符串
 */
+ (NSString *)ey_stringyyyyMMddWithCurrentDate;

/**
 HH:mm:ss

 @return 格式化后的字符串
 */
+ (NSString *)ey_stringHHmmssWithCurrentDate;

/**
  当前手机设置的时间的 UNIX 时间戳
 
 @return 字符串
 */
+ (NSString *)ey_stringPhoneTimeStampWithCurrentDate;

#pragma mark - NSDate

@end

NS_ASSUME_NONNULL_END
