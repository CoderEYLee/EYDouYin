//
//  EYRedView.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/27.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYRedView.h"

@implementation EYRedView

+ (instancetype)redView {
//    // 方式一
//    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    // 方式二
    return [[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] instantiateWithOwner:nil options:nil].firstObject;
}
@end
