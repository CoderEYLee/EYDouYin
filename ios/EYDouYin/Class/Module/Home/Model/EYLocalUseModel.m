//
//  EYLocalUseModel.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/8/13.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYLocalUseModel.h"

@implementation EYMeItemsModel

@end

@implementation EYLocalUseModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"items": EYMeItemsModel.class};
}

@end
