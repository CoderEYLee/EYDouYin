//
//  EYMineViewController.h
//  EYDouYin
//
//  Created by 李二洋 on 2019/6/18.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EYMineViewController : EYBaseViewController

// 跳转方式
@property (assign, nonatomic) EYJumpType jumpType;

// 传递过来的 user_id
@property (copy, nonatomic) NSString *user_id;

@end

NS_ASSUME_NONNULL_END
