//
//  EYClickPointModel.m
//  TTEnglish
//
//  Created by 李二洋 on 2019/6/21.
//  Copyright © 2019 TaoTie. All rights reserved.
//

#import "EYClickPointModel.h"

#pragma mark - 具体信息模型
@implementation TTClickPointParamModel

@end

#pragma mark - 上报模型
@implementation EYClickPointModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _user_id = [EYManager manager].userModel.user_id;
        _create_time = [NSDate ey_stringPhoneTimeStampWithCurrentDate];
    }
    return self;
}

@end
