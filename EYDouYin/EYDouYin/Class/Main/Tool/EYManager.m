//
//  EYManager.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/11/5.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYManager.h"

@interface EYManager () <NSCopying, NSMutableCopying>

@property (strong, nonatomic, readwrite) NSArray *meArray;

@property (strong, nonatomic, readwrite) NSArray *collectionArray;

@end

@implementation EYManager

static NSString * const meArrayPlist = @"EYMeViewControllerSourceArray.plist";
static NSString * const collectionArrayPlist = @"collectionArray.plist";

// 用来保存唯一的单例对象
static EYManager * _manager = nil;

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    return _manager;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return _manager;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.meArray = meArrayPlist.ey_loadLocalPlistFileArray;
        self.collectionArray = collectionArrayPlist.ey_loadLocalPlistFileArray;
    }
    return self;
}

@end
