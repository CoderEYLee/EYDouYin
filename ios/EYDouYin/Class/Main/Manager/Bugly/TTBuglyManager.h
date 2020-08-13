//
//  TTBuglyManager.h
//  TTEnglish
//
//  Created by 李二洋 on 2020/4/14.
//  Copyright © 2020 TaoTie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTBuglyManager : NSObject

+ (instancetype)manager;

///开始 Buglyg功能
- (void)startBugly;

/**
 *    @brief 上报自定义错误
 *
 *    @param category    类型(Cocoa=3,CSharp=4,JS=5,Lua=6)
 *    @param aName       名称
 *    @param aReason     错误原因
 *    @param aStackArray 堆栈
 *    @param info        附加数据
 *    @param terminate   上报后是否退出应用进程
 */
- (void)reportExceptionWithCategory:(NSUInteger)category
                               name:(NSString *)aName
                             reason:(NSString *)aReason
                          callStack:(NSArray *)aStackArray
                          extraInfo:(NSDictionary * _Nullable)info
                       terminateApp:(BOOL)terminate;

@end

NS_ASSUME_NONNULL_END
