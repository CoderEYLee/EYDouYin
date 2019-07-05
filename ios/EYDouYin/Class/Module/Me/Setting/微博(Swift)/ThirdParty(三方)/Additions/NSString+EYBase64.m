//
//  NSString+EYBase64.m
//
//  Created by lieryang on 16/6/7.
//  Copyright © 2016年 lieryang. All rights reserved.
//

#import "NSString+EYBase64.h"

@implementation NSString (EYBase64)

- (NSString *)ey_base64Encode {
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)ey_base64Decode {
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
