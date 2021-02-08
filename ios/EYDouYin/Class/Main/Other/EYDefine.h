//
//  EYDefine.h
//  EYDouYin
//
//  Created by 李二洋 on 2019/5/20.
//  Copyright © 2019 李二洋. All rights reserved.
//  宏定义文件

#pragma mark - 宏定义
#ifdef DEBUG

#define EYLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#define EYLogError EYLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,error)

#else

#define EYLog(...)
#define EYLogError

#endif

#pragma mark - 偏好设置
#define EYUserDefaults [NSUserDefaults standardUserDefaults]
//赋值
#define EYSetObjectForKey(value, key) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize]
//取值
#define EYObjectForKey(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
//移除值
#define EYRemoveObjectForKey(key)  [[NSUserDefaults standardUserDefaults] removeObjectForKey:(key)];\
[[NSUserDefaults standardUserDefaults] synchronize]

#pragma mark - 尺寸相关
#define EYUI_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define EYUI_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define EYUI_IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define EYSCREENSIZE_IS_IPhoneX GK_IS_iPhoneX

//获取当前屏幕的尺寸
#define EYScreenBounds  ([UIScreen mainScreen].bounds)
#define EYScreenSize    ([UIScreen mainScreen].bounds.size)
#define EYScreenWidth   ([UIScreen mainScreen].bounds.size.width)
#define EYScreenHeight  ([UIScreen mainScreen].bounds.size.height)

//状态栏高度
#define EYStatusBarHeight GK_STATUSBAR_HEIGHT
//状态栏+导航栏高度
#define EYStatusBarAndNaviBarHeight GK_STATUSBAR_NAVBAR_HEIGHT

//TabBar 的高度
#define EYTabBarHeight (49)
//底部安全区域
#define EYHomeIndicatorHeight GK_SAFEAREA_BTM
//tabbar高度+底部安全区域
#define EYTabBarHomeIndicatorHeight GK_TABBAR_HEIGHT

// 设备系统版本
#define EYDeviceSystemVersion ([[UIDevice currentDevice].systemVersion doubleValue])

#define EYiOS12 (EYDeviceSystemVersion >= 12.0)
#define EYiOS11 (EYDeviceSystemVersion >= 11.0)

//获取通知中心
#define EYNotificationCenter [NSNotificationCenter defaultCenter]

#define EYKeyWindow [UIApplication sharedApplication].keyWindow

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


#pragma mark - 常量
#define EYBackViewHeight 100 //首页中, 后面正在直播的 view 高度

