//
//  EYMeModel.h
//  EYDouYin
//
//  Created by 李二洋 on 2019/7/5.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EYMeItemsModel : NSObject

/**
 标题
 */
@property (copy, nonatomic) NSString *name;

/**
 控制器名称
 */
@property (copy, nonatomic) NSString *vcName;

@end

@interface EYMeModel : NSObject

/**
 分组名称
 */
@property (copy, nonatomic) NSString *groupName;

/**
 具体信息数组
 */
@property (strong, nonatomic) NSArray <EYMeItemsModel *>*items;

@end

NS_ASSUME_NONNULL_END
