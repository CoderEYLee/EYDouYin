//
//  EYHomeVideoModel.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/9/12.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYHomeVideoModel.h"

@implementation EYHomeVideoModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"likes" : [EYHomeItemLikeModel class],
             @"comments" : EYHomeItemCommentModel.class};
}

- (NSString *)description {
    return  self.yy_modelDescription;
}

@end