//
//  NSString+EYBase64.h
//
//  Created by lieryang on 16/6/7.
//  Copyright © 2016年 lieryang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EYBase64)

/// 对当前字符串进行 BASE 64 编码，并且返回结果
- (NSString *)ey_base64Encode;

/// 对当前字符串进行 BASE 64 解码，并且返回结果
- (NSString *)ey_base64Decode;

@end
