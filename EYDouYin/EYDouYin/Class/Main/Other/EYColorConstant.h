//
//  EYColorConstant.h
//  EYDouYin
//
//  Created by 李二洋 on 2019/5/20.
//  Copyright © 2019 李二洋. All rights reserved.
//

#pragma mark - 颜色
#define EYColorRGB(r, g, b)     [UIColor colorWithRed:((r)/255.0) green:((g)/255.0) blue:((b)/255.0) alpha:1.0]
#define EYColorRGBA(r, g, b, a) [UIColor colorWithRed:((r)/255.0) green:((r)/255.0) blue:((r)/255.0) alpha:(a)]
#define EYColorRandom           EYColorRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define EYColorRGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define EYColorRGBHexAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define EYColorClear        [UIColor clearColor]
#define EYColorRed          [UIColor redColor]
#define EYColorGreen        [UIColor greenColor]
#define EYColorBlue         [UIColor blueColor]
#define EYColorYellow       [UIColor yellowColor]
#define EYColorWhite        [UIColor whiteColor]
#define EYColorBlack        [UIColor blackColor]
#define EYColorDarkGray     [UIColor darkGrayColor]
#define EYColorLightGray    [UIColor lightGrayColor]
#define EYColorGray         [UIColor grayColor]
#define EYColorCyan         [UIColor cyanColor]
#define EYColorMagenta      [UIColor magentaColor]
#define EYColorOrange       [UIColor orangeColor]
#define EYColorPurple       [UIColor purpleColor]
#define EYColorBrown        [UIColor brownColor]

#define EYColorWhite0_05    [UIColor colorWithWhite:1.0 alpha:0.05] //分割线
#define EYColorWhite0_1    [UIColor colorWithWhite:1.0 alpha:0.1]
#define EYColorWhite0_2    [UIColor colorWithWhite:1.0 alpha:0.2]
#define EYColorWhite0_3    [UIColor colorWithWhite:1.0 alpha:0.3]
#define EYColorWhite0_4    [UIColor colorWithWhite:1.0 alpha:0.4]
#define EYColorWhite0_5    [UIColor colorWithWhite:1.0 alpha:0.5]
#define EYColorWhite0_6    [UIColor colorWithWhite:1.0 alpha:0.6]
#define EYColorWhite0_7    [UIColor colorWithWhite:1.0 alpha:0.7]
#define EYColorWhite0_8    [UIColor colorWithWhite:1.0 alpha:0.8]
#define EYColorWhite0_9    [UIColor colorWithWhite:1.0 alpha:0.9]

#define EYColor333333       EYColorRGBHex(0x333333)
#define EYColor666666       EYColorRGBHex(0x666666)
#define EYColor999999       EYColorRGBHex(0x999999)
#define EYColor2A2B33       EYColorRGBHex(0x2A2B33) //主题背景色
#define EYColorFFCC00       EYColorRGBHex(0xFFCC00) //主题黄色
#define EYColorFFCC00_0_3   EYColorRGBHexAlpha(0xFFCC00, 0.3) //主题黄色0.3
