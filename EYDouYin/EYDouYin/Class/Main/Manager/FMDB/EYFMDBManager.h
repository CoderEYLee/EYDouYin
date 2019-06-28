//
//  EYFMDBManager.h
//  TTEnglish
//
//  Created by 李二洋 on 2019/6/21.
//  Copyright © 2019 TaoTie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EYClickPointModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EYFMDBManager : NSObject

+ (instancetype)manager;

/**
 保存一条日志

 @param clickPointModel 需要保存的模型信息
 */
- (void)saveClickPointModelWithModel:(EYClickPointModel *)clickPointModel;

@end

NS_ASSUME_NONNULL_END
