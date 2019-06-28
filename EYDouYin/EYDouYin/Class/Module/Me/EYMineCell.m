//
//  EYMineCell.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/6/24.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYMineCell.h"

#define EYMineCellMargin 20

@interface EYMineCell()

@end

@implementation EYMineCell

#pragma mark - Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = EYColorRandom;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //1.顶部
        //1.1用户个人头像按钮
        UIButton *userHeaderButton = [[UIButton alloc] init];
        userHeaderButton.layer.cornerRadius = 60.0;
        [userHeaderButton addTarget:self action:@selector(tapUserHeaderButton:) forControlEvents:UIControlEventTouchUpInside];
        userHeaderButton.backgroundColor = EYColorRandom;
        [self.contentView addSubview:userHeaderButton];
        [userHeaderButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(EYMineCellMargin);
            make.top.mas_equalTo(-20);
            make.width.height.mas_equalTo(120);
        }];
        
        //1.2.1 编辑资料
        UIButton *profileButton = [[UIButton alloc] init];
        [profileButton addTarget:self action:@selector(tapProfileButton:) forControlEvents:UIControlEventTouchUpInside];
        profileButton.backgroundColor = EYColorRandom;
        [self.contentView addSubview:profileButton];
        [profileButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(userHeaderButton.mas_right).mas_offset(20);
            make.centerY.mas_equalTo(userHeaderButton.mas_centerY);
            make.right.mas_equalTo(-74);
            make.height.mas_equalTo(44);
        }];
        
        //1.2.2 关注/取消关注按钮
        UIButton *focusButton = [[UIButton alloc] init];
        [focusButton addTarget:self action:@selector(tapFocusButton:) forControlEvents:UIControlEventTouchUpInside];
        focusButton.backgroundColor = EYColorRandom;
        [self.contentView addSubview:focusButton];
        [focusButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_equalTo(profileButton);
        }];
        
        //1.3 添加好友按钮
        UIButton *addFriendButton = [[UIButton alloc] init];
        [addFriendButton addTarget:self action:@selector(tapAddFriendButton:) forControlEvents:UIControlEventTouchUpInside];
        addFriendButton.backgroundColor = EYColorRandom;
        [self.contentView addSubview:addFriendButton];
        [addFriendButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(profileButton);
            make.right.mas_equalTo(-EYMineCellMargin);
            make.width.height.mas_equalTo(44);
        }];
        
        //1.4 昵称
        UILabel *nickNameLabel = [[UILabel alloc] init];
        nickNameLabel.text = @"没有女朋友的程序员";
        nickNameLabel.textColor = EYColorWhite;
        nickNameLabel.font = EYSizeFont25;
        [self.contentView addSubview:nickNameLabel];
        [nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(userHeaderButton);
            make.top.mas_equalTo(userHeaderButton.mas_bottom).mas_offset(20);
            make.bottom.mas_equalTo(-320);
        }];
        
        //2.个人简介
        
        
        
    }
    return self;
}

#pragma mark - Private Methods

- (void)tapUserHeaderButton:(UIButton *)button {
    [self tapButtonWithJumpType:EYJumpTypeMineUserHeaderButton];
}

- (void)tapProfileButton:(UIButton *)button {
    [self tapButtonWithJumpType:EYJumpTypeMineProfileButton];
}

- (void)tapFocusButton:(UIButton *)button {
    [self tapButtonWithJumpType:EYJumpTypeMineFocusButton];
}

- (void)tapAddFriendButton:(UIButton *)button {
    [self tapButtonWithJumpType:EYJumpTypeMineAddFriendButton];
}

#pragma mark - 回调 delegate
- (void)tapButtonWithJumpType:(EYJumpType)jumpType {
    if (self.delegate && [self.delegate respondsToSelector:@selector(mineCell:didSelectedButton:)]) {
        [self.delegate mineCell:self didSelectedButton:jumpType];
    }
}

@end
