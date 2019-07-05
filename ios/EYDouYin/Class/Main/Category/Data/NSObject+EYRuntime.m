//
//  NSObject+EYRuntime.m
//  CategoryDemo
//
//  Created by lieryang on 2017/3/12.
//  Copyright © 2017年 lieryang. All rights reserved.
//

#import "NSObject+EYRuntime.h"
#import <objc/runtime.h>

@implementation NSObject (EYRuntime)

+ (NSArray *)ey_objectsWithArray:(NSArray *)array {
    if (array.count == 0) {
        return nil;
    }
    
    // 断言是字典数组
    NSAssert([array[0] isKindOfClass:[NSDictionary class]], @"必须传入字典数组");
    
    // 1. 获得属性数组
    NSArray *list = [self ey_propertiesList];
    
    // 2. 遍历数组
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dictionary in array) {
        // 3. 创建对象
        id obj = [self new];
        
        // 4. 遍历字典
        for (NSString *key in dictionary) {
            // 判断字典中的 key 是否在成员变量中存在
            if (![list containsObject:key]) {
                continue;
            }
            
            [obj setValue:dictionary[key] forKey:key];
        }
        
        // 5. 将对象添加到数组
        [arrayM addObject:obj];
    }
    
    return arrayM.copy;
}

void *propertiesKey = "propertiesList";

+ (NSArray *)ey_propertiesList {
    // 获取关联对象
    NSArray *result = objc_getAssociatedObject(self, propertiesKey);
    
    if (result != nil) {
        return result;
    }
    
    unsigned int count = 0;
    objc_property_t *list = class_copyPropertyList([self class], &count);
    
    // 遍历所有的属性
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (unsigned int i = 0; i < count; i++) {
        objc_property_t pty = list[i];
        
        // 获取 ivar 名称
        const char *cName = property_getName(pty);
        NSString *name = [NSString stringWithUTF8String:cName];
        
        [arrayM addObject:name];
    }
    
    free(list);
    
    // 设置关联对象
    objc_setAssociatedObject(self, propertiesKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return objc_getAssociatedObject(self, propertiesKey);
}

void *ivarsKey = "ivarsList";

+ (NSArray *)ey_ivarsList {
    // 获取关联对象
    NSArray *result = objc_getAssociatedObject(self, ivarsKey);
    
    if (result != nil) {
        return result;
    }
    
    unsigned int count = 0;
    Ivar *list = class_copyIvarList([self class], &count);
    
    // 遍历所有的属性
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (unsigned int i = 0; i < count; i++) {
        
        Ivar ivar = list[i];
        
        // 获取 ivar 名称
        const char *cName = ivar_getName(ivar);
        NSString *name = [NSString stringWithUTF8String:cName];
        
        [arrayM addObject:name];
    }
    
    free(list);
    
    // 设置关联对象
    objc_setAssociatedObject(self, ivarsKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return objc_getAssociatedObject(self, ivarsKey);
}

@end
