//
//  EYLanguageTool.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/5/20.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYLanguageTool.h"

@implementation EYLanguageTool

/**
 设置App 默认的语言
 */
+ (void)setDefaultAppLanguage {
    NSString *language = EYObjectForKey(EYAppLanguage);
    if (language.length == 0) {
        language = NSLocale.preferredLanguages.firstObject;
        if ([language hasPrefix:@"en"]) {
            [self changeAppLanguageWithType:EYAppLanguageToolTypeEnglish];
        } else if ([language hasPrefix:@"zh"]) {
            [self changeAppLanguageWithType:EYAppLanguageToolTypeChinese];
        } else {
            [self changeAppLanguageWithType:EYAppLanguageToolTypeEnglish];
        }
    }
}

/**
 改变App 语言
 */
+ (void)changeAppLanguageWithType:(EYAppLanguageToolType)type {
    NSString *language = @"en";
    switch (type) {
        case EYAppLanguageToolTypeEnglish: {
            language = @"en";
            break;
        }
        case EYAppLanguageToolTypeChinese: {
            language = @"zh-Hans";
            break;
        }
        case EYAppLanguageToolTypeKorean: {
            language = @"ko";
            break;
        }
            
        default:
            break;
    }
    EYSetObjectForKey(language, EYAppLanguage);
}

+ (EYAppLanguageToolType)getAppLanguage {
    NSString *language = EYObjectForKey(EYAppLanguage);
    if (language.length == 0) {
        [self changeAppLanguageWithType:EYAppLanguageToolTypeEnglish];
        return EYAppLanguageToolTypeEnglish;
    }
    
    if ([language isEqualToString:@"en"]) {
        return EYAppLanguageToolTypeEnglish;
    } else if ([language isEqualToString:@"zh-Hans"]) {
        return EYAppLanguageToolTypeChinese;
    } else {
        return EYAppLanguageToolTypeEnglish;
    }
}

@end
