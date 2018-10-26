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

@end
