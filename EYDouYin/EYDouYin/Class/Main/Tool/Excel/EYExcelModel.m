//
//  EYExcelModel.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/6/14.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYExcelModel.h"

@implementation EYExcelModel

- (id)copyWithZone:(NSZone *)zone {
    EYVideoModel *model = [[[self class] allocWithZone:zone] init];
    model.tt_name = self.tt_name;
    model.tt_count = self.tt_count;
    return model;
}

@end
