//
//  EYUserModelTool.h
//  TTEnglish
//
//  Created by 李二洋 on 2018/11/28.
//  Copyright © 2019 TTEnglish. All rights reserved.
//  用户模型存储的工具类

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EYUserModelTool : NSObject

+ (void)saveUserModel:(EYUserModel *)userModel;

+ (EYUserModel *)userModel;

+ (void)removeUserModel;

@end

NS_ASSUME_NONNULL_END
