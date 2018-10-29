//
//  EYWaterflowViewCell.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/10/29.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EYWaterflowViewCell : UIView

//重用标识符
@property (nonatomic, readonly, copy) NSString *reuseIdentifier;

- (__kindof EYWaterflowViewCell *)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
