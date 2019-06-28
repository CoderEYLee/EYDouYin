//
//  EYUserModelTool.m
//  TTEnglish
//
//  Created by 李二洋 on 2018/11/28.
//  Copyright © 2019 TTEnglish. All rights reserved.
//

#define EYUserModelFileName @"TTUser.data"
#define EYUserModelFilePath [EYPathDocument stringByAppendingPathComponent:EYUserModelFileName]

#import "EYUserModelTool.h"

@implementation EYUserModelTool

+ (void)saveUserModel:(EYUserModel *)userModel {
    [NSKeyedArchiver archiveRootObject:userModel toFile:EYUserModelFilePath];
}

+ (EYUserModel *)userModel {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:EYUserModelFilePath];
}

+ (void)removeUserModel {
    if ([EYFileManager fileExistsAtPath:EYUserModelFilePath]) {
        BOOL isSuccess = [EYFileManager removeItemAtPath:EYUserModelFilePath error:nil];
        if (isSuccess) {
            EYLog(@"删除UserModel成功");
        } else {
            EYLog(@"删除UserModel失败");
        }
    }else{
        EYLog(@"文件不存在");
    }
}

@end
