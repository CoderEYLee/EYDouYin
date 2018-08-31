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
 根据文件全名在 MainBundle 中查询,并且序列化返回
 如果查询不到该文件返回nil
 @return 文件中的信息
 */
- (nullable id)ey_loadLocalFile;

@end
