//
//  EYFindViewController.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/22.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYBaseViewController.h"

@class EYFindViewController;

@protocol EYFindViewControllerDelegate<NSObject>

@optional
- (void)findViewController:(EYFindViewController *)findViewController didTapButton:(UIButton *)button;

@end

@interface EYFindViewController : EYBaseViewController

@property (weak, nonatomic) id <EYFindViewControllerDelegate> delegate;

@end
