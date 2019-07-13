//
//  NSDate+EYFormat.m
//  TTEnglish
//
//  Created by 李二洋 on 2018/12/6.
//  Copyright © 2019 TTEnglish. All rights reserved.
//

#import "NSDate+EYFormat.h"

@implementation NSDate (EYFormat)

#pragma mark - NSString
/**
 将'时间戳'按照'对应是格式'就行格式化, 返回最终的结果'字符串'

 @param interval 1970-1-1 的时间戳
 @param formatterString 需要格式化的标准
 @return 返回格式化后的字符串
 */
+ (NSString *)ey_stringWithTimeIntervalSince1970:(NSTimeInterval)interval withDateFormatter:(NSString *)formatterString {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    return [self ey_stringWithDate:date withDateFormatter:formatterString];
}

/**
 将'时间'按照'对应是格式'就行格式化, 返回最终的结果'字符串'

 @param date 任意时间
 @param formatterString 需要格式化的标准
 @return 返回格式化后的字符串
 */
+ (NSString *)ey_stringWithDate:(NSDate *)date withDateFormatter:(NSString *)formatterString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatterString;
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

/**
 yyyy-MM-dd HH:mm:ss

 @param date 任意时间
 @return 返回格式化后的字符串
 */
+ (NSString *)ey_stringyyyyMMddHHmmssWithDate:(NSDate *)date {
    return [self ey_stringWithDate:date withDateFormatter:@"yyyy-MM-dd HH:mm:ss"];
}

/**
 yyyy-MM-dd HH:mm

 @param date 任意时间
 @return 返回格式化后的字符串
 */
+ (NSString *)ey_stringyyyyMMddHHmmWithDate:(NSDate *)date {
    return [self ey_stringWithDate:date withDateFormatter:@"yyyy-MM-dd HH:mm"];
}

/**
 yyyy-MM-dd

 @param date 任意时间
 @return 返回格式化后的字符串
 */
+ (NSString *)ey_stringyyyyMMddWithDate:(NSDate *)date {
    return [self ey_stringWithDate:date withDateFormatter:@"yyyy-MM-dd"];
}

/**
 HH:mm:ss

 @param date 任意时间
 @return 返回格式化后的字符串
 */
+ (NSString *)ey_stringHHmmssWithDate:(NSDate *)date {
    return [self ey_stringWithDate:date withDateFormatter:@"HH:mm:ss"];
}

#pragma mark - 当前手机时间

/**
 yyyy-MM-dd HH:mm:ss

 @return 格式化后的字符串
 */
+ (NSString *)ey_stringyyyyMMddHHmmssWithCurrentDate {
    return [self ey_stringWithDate:[NSDate date] withDateFormatter:@"yyyy-MM-dd HH:mm:ss"];
}

/**
 yyyy-MM-dd HH:mm

 @return 格式化后的字符串
 */
+ (NSString *)ey_stringyyyyMMddHHmmWithCurrentDate {
    return [self ey_stringWithDate:[NSDate date] withDateFormatter:@"yyyy-MM-dd HH:mm"];
}

/**
 yyyy-MM-dd

 @return 格式化后的字符串
 */
+ (NSString *)ey_stringyyyyMMddWithCurrentDate {
    return [self ey_stringWithDate:[NSDate date] withDateFormatter:@"yyyy-MM-dd"];
}

/**
 HH:mm:ss

 @return 格式化后的字符串
 */
+ (NSString *)ey_stringHHmmssWithCurrentDate {
    return [self ey_stringWithDate:[NSDate date] withDateFormatter:@"HH:mm:ss"];
}

/**
 当前手机设置的时间的 UNIX 时间戳
 
 @return 字符串
 */
+ (NSString *)ey_stringPhoneTimeStampWithCurrentDate {
    return [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
}

#pragma mark - NSDate

@end
