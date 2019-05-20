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

//获取通知中心
#define EYNotificationCenter [NSNotificationCenter defaultCenter]

// RGB颜色 可以设置透明度
#define EYColorAlpha(r, g, b ,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

// RGB颜色 不可以设置透明度
#define EYColor(r, g, b) EYColorAlpha(r, g, b ,1.0)

// 随机色
#define EYRandomColor EYColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#pragma mark - 尺寸相关
#define EYUI_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define EYUI_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define EYUI_IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define EYSCREENSIZE_IS_40  (EYUI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0 || [[UIScreen mainScreen] bounds].size.width == 568.0)
#define EYSCREENSIZE_IS_47  (EYUI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0 || [[UIScreen mainScreen] bounds].size.width == 667.0)
#define EYSCREENSIZE_IS_55  (EYUI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0 || [[UIScreen mainScreen] bounds].size.width == 736.0)

//判断iPHoneXR
#define EYSCREENSIZE_IS_XR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !EYUI_IS_IPAD : NO)

//判断iPHoneX或者iPHoneXs
#define EYSCREENSIZE_IS_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !EYUI_IS_IPAD : NO)

//判断iPhoneXs Max
#define EYSCREENSIZE_IS_XS_MAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !EYUI_IS_IPAD : NO)
//判断X系列
#define EYSCREENSIZE_IS_IPhoneX_All (EYSCREENSIZE_IS_XR || EYSCREENSIZE_IS_X || EYSCREENSIZE_IS_XS_MAX)

//获取当前屏幕的尺寸
#define EYScreenBounds ([UIScreen mainScreen].bounds)
#define EYScreenSize  (EYScreenBounds.size)
#define EYScreenWidth (EYScreenSize.width)
#define EYScreenHeight (EYScreenSize.height)

//电池栏的高度
#define EYStatusBarHeight (EYSCREENSIZE_IS_IPhoneX_All ? (44) : (20))
//电池栏+导航栏的高度
#define EYStatusBarAndNaviBarHeight (EYSCREENSIZE_IS_IPhoneX_All ? (88) : (64))
//TabBar 的高度
#define EYTabBarHeight (49)
//HomeIndicator的高度(只有 X 有)
#define EYHomeIndicatorHeight (EYSCREENSIZE_IS_IPhoneX_All ? (34) : (0))

// 设备系统版本
#define EYDeviceSystemVersion ([[UIDevice currentDevice].systemVersion doubleValue])

#define EYiOS12 (EYDeviceSystemVersion >= 12.0)
#define EYiOS11 (EYDeviceSystemVersion >= 11.0)
#define EYiOS10 (EYDeviceSystemVersion >= 10.0)
#define EYiOS9 (EYDeviceSystemVersion >= 9.0)
#define EYiOS8 (EYDeviceSystemVersion >= 8.0)

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

