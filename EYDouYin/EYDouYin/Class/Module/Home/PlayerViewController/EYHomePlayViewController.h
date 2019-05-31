//
//  EYHomePlayViewController.h
//  EYDouYin
//
//  Created by 李二洋 on 2019/5/31.
//  Copyright © 2019 李二洋. All rights reserved.
//  视频流中每一个界面控制器

#import "EYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EYHomePlayViewController : EYBaseViewController

- (void)startPlayWithURLString:(NSString *)URLString;

- (void)stopPlay;

@end

NS_ASSUME_NONNULL_END
