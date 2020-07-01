//
//  EYArithmeticViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2020/6/17.
//  Copyright © 2020 李二洋. All rights reserved.
//

#import "EYArithmeticViewController.h"

@interface EYArithmeticViewController ()

@end

@implementation EYArithmeticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 初始化界面
    [self setupUI];
    
    //2.算法测试
    [self test];
}

//1. 初始化界面
- (void)setupUI {
    self.view.backgroundColor = EYColorRandom;
    
}

//2.算法测试
- (void)test {
    //2.1BF算法
    [self testSubString_BF];
    
    //2.2RK算法
    [self testSubString_RK];
}

#pragma mark - BF算法
- (void)testSubString_BF {
    NSInteger result = [self findSubstringInStringBFWithAllString:@"abcdefgh" subString:@"fg"];
    EYLog(@"BF算法======%ld", result);
}

///BF算法(暴力算法)
- (NSInteger)findSubstringInStringBFWithAllString:(NSString *)allString subString:(NSString *)subString {
    EYLog(@"BF算法(暴力算法)======start");
    if (allString.length == 0 || subString.length == 0) {
        EYLog(@"BF算法(暴力算法)======end 空");
        return -1;
    }
    
    int i = 0;//主串
    int j = 0;//子串
    
    while (1) {
        if (j >= subString.length) {
            EYLog(@"BF算法(暴力算法)======end子串结束");
            return i - j;
        }
        
        if (i >= allString.length) {//主串结束
            EYLog(@"BF算法(暴力算法)======end主串结束");
            return -1;
        }
        
        unichar a = [allString characterAtIndex:i];
        unichar b = [subString characterAtIndex:j];
        if (a == b) {
            j++;
        } else {
            j = 0;
        }
        i++;
    }
}

#pragma mark - RK算法
- (void)testSubString_RK {
    //是将对比字符变成了对比hash值。pow(x, y) x的y次方
    NSInteger result = [self findSubstringInStringRKWithAllString:@"abcdefgh" subString:@"abcdefgh"];
    EYLog(@"RK算法======%ld", result);
}

///RK算法
- (NSInteger)findSubstringInStringRKWithAllString:(NSString *)allString subString:(NSString *)subString {
    EYLog(@"RK算法======start");
    NSUInteger allLength = allString.length;
    NSUInteger subLength = subString.length;
    if (allLength == 0 || subLength == 0 || (allLength < subLength)) {
        EYLog(@"RK算法======end 空");
        return -1;
    }
    
    NSUInteger leftLength = allLength - subLength;
    double subHash = [self hashString:subString]; // 子串hash
    
    int i = 0;//主串
    while (i <= leftLength) {
        if (subHash == [self hashString:[allString substringWithRange:NSMakeRange(i, subLength)]]) {
            return i;
        }
        i++;
    }
    
    return -1;
}

/// 计算一个字符串的 hash 值
/// @param string 需要计算的字符串
- (double)hashString:(NSString *)string {
    NSUInteger length = string.length;
    double sum = 0.0;
    for (NSUInteger i = 0; i < length; i++) {
        unichar charString = [string characterAtIndex:i];
        double charDouble = charString - 'a' + 1;
        sum += charDouble * pow(26, length - 1 - i);
    }
    
    return sum;
}

@end
