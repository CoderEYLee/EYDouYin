//
//  EYLocalUseModel.h
//  EYDouYin
//
//  Created by 李二洋 on 2019/8/13.
//  Copyright © 2019 李二洋. All rights reserved.
//  本地数据使用模型(方便界面显示)

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//"我的"界面使用
@interface EYMeItemsModel : NSObject

/**
 开发语言
 */
@property (copy, nonatomic) NSString *language;

/**
 标题
 */
@property (copy, nonatomic) NSString *name;

/**
 控制器名称
 */
@property (copy, nonatomic) NSString *vcName;

@end

@interface EYLocalUseModel : NSObject

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
