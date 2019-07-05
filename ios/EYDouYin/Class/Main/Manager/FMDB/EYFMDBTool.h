//
//  EYFMDBTool.h
//  TTEnglish
//
//  Created by 李二洋 on 2019/6/25.
//  Copyright © 2019 TaoTie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EYClickPointModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EYFMDBTool : NSObject

/**
 获取数据库存储的所有数据

 @param block 数据信息(数组)
 */
+ (void)getAllModelWithBlock:(void (^) (NSArray <EYClickPointModel *>*results))block;

/**
 保存一条日志到数据库
 
 @param clickPointModel 需要保存的模型信息
 */
+ (void)saveClickPointModelWithModel:(EYClickPointModel *)clickPointModel;

/**
 删除数据库所有数据
 */
+ (void)deleteAllClickPointModel;

@end

NS_ASSUME_NONNULL_END
