//
//  EYHomeItemModel.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/9/12.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EYHomeItemLikeModel.h"
#import "EYHomeItemCommentModel.h"

@interface EYHomeItemModel : NSObject

@property (copy, nonatomic) NSString *userId;

@property (copy, nonatomic) NSString *userName;

@property (copy, nonatomic) NSString *itemId;

@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) NSArray <EYHomeItemLikeModel *>*likes;

@property (copy, nonatomic) NSArray <EYHomeItemLikeModel *>*comments;

@end
