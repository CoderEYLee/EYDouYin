//
//  NSString+EYExtension.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/5.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "NSString+EYExtension.h"

@implementation NSString (EYExtension)

- (nullable id)ey_loadLocalFile
{
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

@end
