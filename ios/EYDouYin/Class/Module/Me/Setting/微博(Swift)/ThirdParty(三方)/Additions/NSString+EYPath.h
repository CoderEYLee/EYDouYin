//
//  NSString+EYPath.h
//
//  Created by lieryang on 16/6/10.
//  Copyright © 2016年 lieryang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EYPath)

/// 给当前文件追加文档路径
- (NSString *)ey_appendDocumentDir;

/// 给当前文件追加缓存路径
- (NSString *)ey_appendCacheDir;

/// 给当前文件追加临时路径
- (NSString *)ey_appendTempDir;

@end
