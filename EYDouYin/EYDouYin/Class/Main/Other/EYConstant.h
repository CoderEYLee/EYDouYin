//
//  EYConstant.h
//  今日新闻
//
//  Created by lieryang on 2016/11/5.
//  Copyright © 2016年 lieryang. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef DEBUG

#define EYLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#define EYLogError EYLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,error)

#else

#define EYLog(...)
#define EYLogError

#endif

//获取通知中心
#define EYNotificationCenter [NSNotificationCenter defaultCenter]

// RGB颜色 可以设置透明度
#define EYColorAlpha(r, g, b ,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

// RGB颜色 不可以设置透明度
#define EYColor(r, g, b) EYColorAlpha(r, g, b ,1.0)

// 随机色
#define EYRandomColor EYColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

//获取当前屏幕的尺寸
#define EYScreenBounds [UIScreen mainScreen].bounds
#define EYScreenWidth [[UIScreen mainScreen] bounds].size.width
#define EYScreenHeight [[UIScreen mainScreen] bounds].size.height

// 判断是否为 iPhone 4S
#define EYiPhone4S [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 480.0f

// 判断是否为 iPhone 5SE
#define EYiPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f

// 判断是否为iPhone 6
#define EYiPhone6 [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f

// 判断是否为iPhone 6Plus
#define EYiPhone6Plus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f


#define EYiOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

//获取temp
#define EYPathTemp NSTemporaryDirectory()

//获取沙盒 Document
#define EYPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

#define EYPathLibrary [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒 Cache
#define EYPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#define EYMainBundle [NSBundle mainBundle]

#define EYUserDefaults [NSUserDefaults standardUserDefaults]

#define EYFileManager [NSFileManager defaultManager]

#define EYStringIsEmpty(string) ([string isKindOfClass:[NSNull class]] || string.length == 0 ? YES : NO)

#define EYArrayIsEmpty(array) ([array isKindOfClass:[NSNull class]] || array.count == 0 ? YES : NO)

#define EYDictionaryIsEmpty(dictionary) ([dictionary isKindOfClass:[NSNull class]] || dictionary.allKeys == 0 ? YES : NO)
