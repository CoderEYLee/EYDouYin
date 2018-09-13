//
//  EYConstant.h
//  EYDouYin
//
//  Created by lieryang on 2016/11/5.
//  Copyright © 2016年 lieryang. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 通知名称

//
UIKIT_EXTERN NSString *const EYTabbarShouldChangeColorNotification;







#pragma mark - 宏定义
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
#define EYScreenBounds ([UIScreen mainScreen].bounds)
#define EYScreenSize  (EYScreenBounds.size)
#define EYScreenWidth (EYScreenSize.width)
#define EYScreenHeight (EYScreenSize.height)

//电池栏的高度
#define EYStatusBarHeight (EYiPhoneX ? (44) : (20))
//电池栏+导航栏的高度
#define EYStatusBarAndNaviBarHeight (EYiPhoneX ? (88) : (64))
//TabBar 的高度
#define EYTabBarHeight (49)
//HomeIndicator的高度(只有 X 有)
#define EYHomeIndicatorHeight (EYiPhoneX ? (34) : (0))

// 判断是否为 iPhone 4S
#define EYiPhone4S ((EYScreenWidth == 320.0f) && (EYScreenHeight == 480.0f) || (EYScreenWidth == 480.0f) && (EYScreenHeight == 320.0f))

// 判断是否为 iPhone 5SE
#define EYiPhone5SE ((EYScreenWidth == 320.0f) && (EYScreenHeight == 568.0f) || (EYScreenWidth == 568.0f) && (EYScreenHeight == 320.0f))

// 判断是否为iPhone 6
#define EYiPhone6 ((EYScreenWidth == 375.0f) && (EYScreenHeight == 667.0f) || (EYScreenWidth == 667.0f) && (EYScreenHeight == 375.0f))

// 判断是否为iPhone 6Plus
#define EYiPhone6Plus ((EYScreenWidth == 414.0f) && (EYScreenHeight == 736.0f) || (EYScreenWidth == 736.0f) && (EYScreenHeight == 414.0f))

// 判断是否为iPhone X
#define EYiPhoneX ((EYScreenWidth == 375.f) && (EYScreenHeight == 812.f) || (EYScreenWidth == 812.f) && (EYScreenHeight == 375.f))

// 设备系统版本
#define EYDeviceSystemVersion ([[UIDevice currentDevice].systemVersion doubleValue])

#define EYiOS12 (EYDeviceSystemVersion >= 12.0)
#define EYiOS11 (EYDeviceSystemVersion >= 11.0)
#define EYiOS10 (EYDeviceSystemVersion >= 10.0)
#define EYiOS9 (EYDeviceSystemVersion >= 9.0)
#define EYiOS8 (EYDeviceSystemVersion >= 8.0)

#define EYKeyWindow [UIApplication sharedApplication].keyWindow

#define EYKeyWindowRootViewController EYKeyWindow.rootViewController

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

#define EYAppLanguage @"EYAppLanguage"

#define EYLocalized(key) [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:EYAppLanguage]] ofType:@"lproj"]] localizedStringForKey:(key) value:nil table:nil]
