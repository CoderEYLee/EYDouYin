//
//  NSString+EYExtension.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/5.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EYExtension)

/**
 加载本地的 JSON 文件
 根据文件全名在 MainBundle 中查询,并且序列化返回
 如果查询不到该文件返回nil
 @return 文件中的信息
 */
- (nullable id)ey_loadLocalJSONFile;

/**
 加载本地的 Plist 文件
 如果查询不到该文件返回nil
 @return 数组对象
 */
- (nullable NSArray *)ey_loadLocalPlistFileArray;

/**
 加载本地的 Plist 文件
 如果查询不到该文件返回nil
 @return 字典对象
 */
- (nullable NSDictionary *)ey_loadLocalPlistFileDictionary;

/**
 删除首尾空格
 
 @return 删除后的字符串
 */
- (instancetype _Nullable)deleteFirstLastSpace;

/**
 图片视频拼接成为完成路径
 
 @return 拼接后的完整路径
 */
- (instancetype _Nullable)insertVideoPathString;

/**
 图片名称拼接成为完成路径(阿里云,正常图)
 
 @return 拼接后的完整路径
 */
- (instancetype _Nonnull)insertImagePathString_normal;

/**
 图片名称拼接成为完成路径(阿里云,缩略图)
 
 @return 拼接后的完整路径
 */
- (instancetype _Nonnull)insertImagePathString_thumbnail;

/**
 拼接Document路径
 
 @return 拼接后的完整路径
 */
- (instancetype _Nonnull)insertDocumentPathString;

/**
 将文件名前插入对应的路径
 
 @return 拼接后的完整路径
 */
- (instancetype _Nonnull)insertTempPathString;

/**
 将视频拼接对应路径后,再拼接路径
 
 @return 返回视频首帧的图片地址
 */
- (instancetype _Nonnull)firstImageFromVideo;

@end
