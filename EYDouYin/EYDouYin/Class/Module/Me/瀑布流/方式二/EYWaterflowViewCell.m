//
//  EYWaterflowViewCell.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/10/29.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYWaterflowViewCell.h"

@interface EYWaterflowViewCell()

@property (nonatomic, readwrite, copy) NSString *reuseIdentifier;

@end

@implementation EYWaterflowViewCell

- (__kindof EYWaterflowViewCell *)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super init];
    if (self) {
        self.reuseIdentifier = reuseIdentifier;
    }
    return self;
}

@end
