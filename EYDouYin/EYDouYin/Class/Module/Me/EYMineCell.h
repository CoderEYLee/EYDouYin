//
//  EYMineCell.h
//  EYDouYin
//
//  Created by 李二洋 on 2019/6/24.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EYUserModel.h"

NS_ASSUME_NONNULL_BEGIN
@class EYMineCell;

@protocol EYMineCellDelegate<NSObject>
@optional
- (void)mineCell:(EYMineCell *)cell didSelectedButton:(EYJumpType)jumpTpye;

@end

@interface EYMineCell : UITableViewCell

@property (weak, nonatomic) id <EYMineCellDelegate> delegate;

@property (strong, nonatomic) EYUserModel *userModel;

@end

NS_ASSUME_NONNULL_END
