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

@property (weak, nonatomic) UIButton *userHeaderButton;
@property (weak, nonatomic) UIButton *profileButton;
@property (weak, nonatomic) UIButton *focusButton;
@property (weak, nonatomic) UIButton *addFriendButton;
@property (weak, nonatomic) UILabel *nickNameLabel;

@end

@implementation EYMineCell

#pragma mark - Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = EYColorTheme;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //1.顶部
        //1.1用户个人头像按钮
        UIButton *userHeaderButton = [[UIButton alloc] init];
        userHeaderButton.layer.cornerRadius = 60.0;
        [userHeaderButton addTarget:self action:@selector(tapUserHeaderButton:) forControlEvents:UIControlEventTouchUpInside];
        userHeaderButton.backgroundColor = EYColorRandom;
        [self.contentView addSubview:userHeaderButton];
        self.userHeaderButton = userHeaderButton;
        [userHeaderButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(EYMineCellMargin);
            make.top.mas_equalTo(-20);
            make.width.height.mas_equalTo(120);
        }];
        
        //1.2.1 编辑资料
        UIButton *profileButton = [[UIButton alloc] init];
        profileButton.backgroundColor = EYColorRGBHex(0x393A43);
        profileButton.layer.cornerRadius = 2.0;
        [profileButton setTitle:@"编辑资料" forState:UIControlStateNormal];
        [profileButton addTarget:self action:@selector(tapProfileButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:profileButton];
        self.profileButton = profileButton;
        [profileButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(userHeaderButton.mas_right).mas_offset(20);
            make.centerY.mas_equalTo(userHeaderButton.mas_centerY);
            make.right.mas_equalTo(-74);
            make.height.mas_equalTo(44);
        }];
        
        //1.2.2 关注/取消关注按钮
        UIButton *focusButton = [[UIButton alloc] init];
        focusButton.backgroundColor = EYColorRGBHex(0x393A43);
        focusButton.layer.cornerRadius = 2.0;
        [focusButton addTarget:self action:@selector(tapFocusButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:focusButton];
        self.focusButton = focusButton;
        [focusButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_equalTo(profileButton);
        }];
        
        //1.3 添加好友按钮
        UIButton *addFriendButton = [[UIButton alloc] init];
        addFriendButton.backgroundColor = EYColorRGBHex(0x393A43);
        addFriendButton.layer.cornerRadius = 2.0;
        [addFriendButton addTarget:self action:@selector(tapAddFriendButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:addFriendButton];
        self.addFriendButton = addFriendButton;
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
        self.nickNameLabel = nickNameLabel;
        [nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(userHeaderButton);
            make.top.mas_equalTo(userHeaderButton.mas_bottom).mas_offset(EYMineCellMargin);
            make.right.mas_equalTo(-EYMineCellMargin);
        }];
        
        //1.5抖音号
        UILabel *douyinNumberLabel = [[UILabel alloc] init];
        douyinNumberLabel.text = @"抖音号: 970478306";
        douyinNumberLabel.textColor = EYColorWhite;
        douyinNumberLabel.font = EYSizeFont15;
        [self.contentView addSubview:douyinNumberLabel];
        [douyinNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(userHeaderButton);
            make.top.mas_equalTo(nickNameLabel.mas_bottom).mas_offset(10);
        }];
        
        //1.6 分割线
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = EYColorWhite0_05;
        [self.contentView addSubview:lineLabel];
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(userHeaderButton);
            make.top.mas_equalTo(douyinNumberLabel.mas_bottom).mas_offset(EYMineCellMargin);
            make.right.mas_equalTo(-EYMineCellMargin);
            make.height.mas_equalTo(1);
            make.bottom.mas_equalTo(-300);
        }];
        
        //2.个人简介
        
        
        
    }
    return self;
}

- (void)setUserModel:(EYUserModel *)userModel {
    _userModel = userModel;
    
    [self.userHeaderButton ey_setImageWithURL:[NSURL URLWithString:userModel.tt_user_image] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@""] options:0];
//    @property (weak, nonatomic) UIButton *userHeaderButton;
//    @property (weak, nonatomic) UIButton *profileButton;
//    @property (weak, nonatomic) UIButton *focusButton;
//    @property (weak, nonatomic) UIButton *addFriendButton;
//    @property (weak, nonatomic) UILabel *nickNameLabel;
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
