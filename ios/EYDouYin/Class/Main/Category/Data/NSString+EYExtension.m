//
//  NSString+EYExtension.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/5.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "NSString+EYExtension.h"

@implementation NSString (EYExtension)

- (nullable id)ey_loadLocalJSONFile {
    NSData * data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self ofType:nil]];
    if (data) {
        NSError *error;
        id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (!error) {
            return object;
        }
    }
    return nil;
}

- (nullable NSArray *)ey_loadLocalPlistFileArray; {
    
    return [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self ofType:nil]];
}

- (nullable NSDictionary *)ey_loadLocalPlistFileDictionary {
    return [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self ofType:nil]];
}

/**
 删除首尾空格
 
 @return 删除后的字符串
 */
- (instancetype)deleteFirstLastSpace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

/**
 图片视频拼接成为完成路径
 
 @return 拼接后的完整路径
 */
- (instancetype)insertVideoPathString {
    return [self insertAliYunPrefix];
}

/**
 图片名称拼接成为完成路径(阿里云,正常图)
 
 @return 拼接后的完整路径
 */
- (instancetype)insertImagePathString_normal {
    return [self insertAliYunPrefix];
}

/**
 图片名称拼接成为完成路径(阿里云,缩略图)
 
 @return 拼接后的完整路径
 */
- (instancetype)insertImagePathString_thumbnail {
    //  阿里云返回 jpg 图片格式 内存较小
    return [[self insertAliYunPrefix] stringByAppendingString:@"?x-oss-process=image/resize,w_248,h_316/format,jpg"];
}

/**
 拼接Document路径
 
 @return 拼接后的完整路径
 */
- (instancetype)insertDocumentPathString {
    return [EYPathDocument stringByAppendingPathComponent:self];
}

/**
 将文件名前插入对应的路径
 
 @return 拼接后的完整路径
 */
- (instancetype)insertTempPathString {
    return [EYPathTemp stringByAppendingPathComponent:self];
}

/**
 将视频拼接对应路径后,再拼接路径
 
 @return 返回视频首帧的图片地址
 */
- (instancetype)firstImageFromVideo {
    return [[self insertVideoPathString] stringByAppendingString:@"?x-oss-process=video/snapshot,t_5,m_fast"];
}

#pragma mark - 内部方法

/**
 拼接阿里云默认前缀
 
 @return 拼接后的字符串
 */
- (instancetype)insertAliYunPrefix {
    NSString *urlPath = [self stringByReplacingOccurrencesOfString:@" "withString:@"%20"];//转换空格
    return [TTOSSAPPStoreEndpoint stringByAppendingPathComponent:urlPath];
}

@end
