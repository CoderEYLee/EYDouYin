//
//  EYMeModel.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/7/5.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYMeModel.h"

@implementation EYMeItemsModel

@end

@implementation EYMeModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"items": EYMeItemsModel.class};
}

@end
