//
//  EYCollectionModel.h
//  EYDouYin
//
//  Created by 李二洋 on 2019/7/5.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EYCollectionModel : NSObject

/**
 标题
 */
@property (copy, nonatomic) NSString *title;

/**
 链接网址
 */
@property (copy, nonatomic) NSString *content_url;

/**
 是否加密
 */
@property (assign, nonatomic) BOOL lock;

@end

NS_ASSUME_NONNULL_END
