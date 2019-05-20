//
//  EYManager.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/11/5.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EYManager : NSObject

+ (instancetype)sharedManager;

// EYMeViewController控制器使用
@property (strong, nonatomic, readonly) NSArray *meArray;

// EYCollectionViewController控制器使用
@property (strong, nonatomic, readonly) NSArray *collectionArray;

@end

NS_ASSUME_NONNULL_END
