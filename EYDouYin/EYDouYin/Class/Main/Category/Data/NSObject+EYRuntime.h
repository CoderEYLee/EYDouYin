//
//  NSObject+EYRuntime.h
//  CategoryDemo
//
//  Created by lieryang on 2017/3/12.
//  Copyright © 2017年 lieryang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (EYRuntime)

/**
 使用字典数组创建当前类对象的数组

 @param array 字典数组
 @return 当前类对象的数组
 */
+ (NSArray *)ey_objectsWithArray:(NSArray *)array;

/**
 返回当前类的属性数组

 @return 属性数组
 */
+ (NSArray *)ey_propertiesList;

/**
 返回当前类的成员变量数组

 @return 成员变量数组
 */
+ (NSArray *)ey_ivarsList;
@end
