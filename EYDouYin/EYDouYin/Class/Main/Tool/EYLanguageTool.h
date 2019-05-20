//
//  EYLanguageTool.h
//  EYDouYin
//
//  Created by 李二洋 on 2019/5/20.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, EYAppLanguageToolType) {
    EYAppLanguageToolTypeEnglish = 0, //默认英文
    EYAppLanguageToolTypeChinese,     //中文
    EYAppLanguageToolTypeKorean,      //韩文
};

@interface EYLanguageTool : NSObject

/**
 设置App 默认的语言
 */
+ (void)setDefaultAppLanguage;

/**
 改变App 语言
 */
+ (void)changeAppLanguageWithType:(EYAppLanguageToolType)type;

/**
 获取App 语言
 */
+ (EYAppLanguageToolType)getAppLanguage;

@end

NS_ASSUME_NONNULL_END
