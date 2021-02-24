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

@property (weak, nonatomic) UIButton *topButton;
@property (weak, nonatomic) UIButton *userHeaderButton;
@property (weak, nonatomic) UIImageView *userImageView;
@property (weak, nonatomic) UIButton *profileButton;
@property (weak, nonatomic) UIButton *focusButton;
@property (weak, nonatomic) UIButton *addFriendButton;
@property (weak, nonatomic) UILabel *nickNameLabel;
@property (weak, nonatomic, readwrite) UILabel *alphaLabel;

@end

@implementation EYMineCell

#pragma mark - Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = EYColorClear;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //1.顶部
        UIButton *topButton = [[UIButton alloc] init];
        topButton.backgroundColor = EYColorClear;
        [topButton addTarget:self action:@selector(tapTopButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:topButton];
        self.topButton = topButton;
        [topButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(110);
        }];
        
        UIView *bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = EYColorTheme;
        [self.contentView addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topButton.mas_bottom);
            make.left.right.bottom.mas_equalTo(0);
        }];
        
        //1.1用户个人头像按钮
        UIButton *userHeaderButton = [[UIButton alloc] init];
        userHeaderButton.layer.cornerRadius = 55.0;
        [userHeaderButton addTarget:self action:@selector(tapUserHeaderButton:) forControlEvents:UIControlEventTouchUpInside];
        userHeaderButton.backgroundColor = EYColorTheme;
        [bottomView addSubview:userHeaderButton];
        self.userHeaderButton = userHeaderButton;
        [userHeaderButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(EYMineCellMargin);
            make.top.mas_equalTo(topButton.mas_bottom).mas_offset(-20);
            make.width.height.mas_equalTo(110);
        }];
        //用户个人头像图片
        UIImageView *userImageView = [[UIImageView alloc] init];
        userImageView.layer.cornerRadius = 50.0;
        [userHeaderButton addSubview:userImageView];
        self.userImageView = userImageView;
        [userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.width.height.mas_equalTo(100);
        }];
        
        //1.2.1 编辑资料
        UIButton *profileButton = [[UIButton alloc] init];
        profileButton.backgroundColor = EYColorRGBHex(0x393A43);
        profileButton.layer.cornerRadius = 2.0;
        [profileButton setTitle:@"编辑资料" forState:UIControlStateNormal];
        [profileButton addTarget:self action:@selector(tapProfileButton:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:profileButton];
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
        [bottomView addSubview:focusButton];
        self.focusButton = focusButton;
        [focusButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_equalTo(profileButton);
        }];
        
        //1.3 添加好友按钮
        UIButton *addFriendButton = [[UIButton alloc] init];
        addFriendButton.backgroundColor = EYColorRGBHex(0x393A43);
        addFriendButton.layer.cornerRadius = 2.0;
        [addFriendButton addTarget:self action:@selector(tapAddFriendButton:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:addFriendButton];
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
        nickNameLabel.font = [UIFont systemFontOfSize:25.0 weight:UIFontWeightBold];
        [bottomView addSubview:nickNameLabel];
        self.nickNameLabel = nickNameLabel;
        [nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(userHeaderButton);
            make.top.mas_equalTo(userHeaderButton.mas_bottom).mas_offset(5);
            make.right.mas_equalTo(-EYMineCellMargin);
        }];
        
        //1.5抖音号
        UILabel *douyinNumberLabel = [[UILabel alloc] init];
        douyinNumberLabel.text = @"抖音号: 970478306";
        douyinNumberLabel.textColor = EYColorWhite;
        douyinNumberLabel.font = EYSizeFont12;
        [bottomView addSubview:douyinNumberLabel];
        [douyinNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(userHeaderButton);
            make.top.mas_equalTo(nickNameLabel.mas_bottom).mas_offset(5);
        }];
        
        //1.6 分割线
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = EYColorSeparateLine;
        [bottomView addSubview:lineLabel];
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(userHeaderButton);
            make.top.mas_equalTo(douyinNumberLabel.mas_bottom).mas_offset(10);
            make.right.mas_equalTo(-EYMineCellMargin);
            make.height.mas_equalTo(1);
        }];
        
        //2.个人简介
        //2.1 简介
        UIButton *signatureButton = [[UIButton alloc] init];
        [signatureButton setTitle:@"你还没有填写个人简介，点击添加..." forState:UIControlStateNormal];
        [signatureButton addTarget:self action:@selector(tapSignatureButton:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:signatureButton];
        [signatureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(userHeaderButton);
            make.top.mas_equalTo(lineLabel.mas_bottom).mas_offset(10);
        }];
        
        //2.2 年龄
        UIButton *ageButton = [[UIButton alloc] init];
        ageButton.backgroundColor = EYColorRGBHex(0x393A43);
        ageButton.layer.cornerRadius = 2.0;
        [ageButton setTitle:@"27岁" forState:UIControlStateNormal];
        [ageButton setTitleColor:EYColorWhite0_5 forState:UIControlStateNormal];
        ageButton.titleLabel.font = EYSizeFont13;
        ageButton.contentEdgeInsets = UIEdgeInsetsMake(5, 8, 5, 8);
        [ageButton addTarget:self action:@selector(tapAgeButton:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:ageButton];
        [ageButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(userHeaderButton);
            make.top.mas_equalTo(signatureButton.mas_bottom).mas_offset(10);
        }];
        
        //2.3 定位
        UIButton *locationButton = [[UIButton alloc] init];
        locationButton.backgroundColor = EYColorRGBHex(0x393A43);
        locationButton.layer.cornerRadius = 2.0;
        [locationButton setTitle:@"河南.驻马店" forState:UIControlStateNormal];
        [locationButton setTitleColor:EYColorWhite0_6 forState:UIControlStateNormal];
        locationButton.titleLabel.font = EYSizeFont13;
        locationButton.contentEdgeInsets = UIEdgeInsetsMake(5, 8, 5, 8);
        [locationButton addTarget:self action:@selector(tapLocationButton:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:locationButton];
        [locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ageButton.mas_right).mas_offset(5);
            make.top.mas_equalTo(ageButton);
        }];
        
        //2.3 学校
        UIButton *schoolButton = [[UIButton alloc] init];
        schoolButton.backgroundColor = EYColorRGBHex(0x393A43);
        schoolButton.layer.cornerRadius = 2.0;
        [schoolButton setTitle:@"青岛农业大学" forState:UIControlStateNormal];
        [schoolButton setTitleColor:EYColorWhite0_6 forState:UIControlStateNormal];
        schoolButton.titleLabel.font = EYSizeFont13;
        schoolButton.contentEdgeInsets = UIEdgeInsetsMake(5, 8, 5, 8);
        [schoolButton addTarget:self action:@selector(tapSchoolButton:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:schoolButton];
        [schoolButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(locationButton.mas_right).mas_offset(5);
            make.top.mas_equalTo(ageButton);
        }];
        
        //2.4 获赞
        UIButton *toMeLikeButton = [[UIButton alloc] init];
        [toMeLikeButton setAttributedTitle:[self createAttributedStringWithCount:@"100.3W" withTitle:@"获赞"] forState:UIControlStateNormal];
        [toMeLikeButton addTarget:self action:@selector(tapToMeLikeButton:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:toMeLikeButton];
        [toMeLikeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(userHeaderButton);
            make.top.mas_equalTo(schoolButton.mas_bottom).mas_offset(EYMineCellMargin);
            make.bottom.mas_equalTo(-300);
        }];
        
        //3.最上层颜色变化
        UILabel *alphaLabel = [[UILabel alloc] init];
        alphaLabel.backgroundColor = EYColorTheme;
        alphaLabel.alpha = 0.0;
        [bottomView addSubview:alphaLabel];
        self.alphaLabel = alphaLabel;
        [alphaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setUserModel:(EYUserModel *)userModel {
    _userModel = userModel;
    
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:userModel.ey_user_image] placeholderImage:[UIImage imageNamed:@"commom_user_default"]];
}

#pragma mark - Private Methods

- (void)tapTopButton:(UIButton *)button {
    [self tapButtonWithJumpType:EYJumpTypeMineUserBackImageButton];
}

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

- (void)tapSignatureButton:(UIButton *)button {
    [self tapButtonWithJumpType:EYJumpTypeMineSignatureButton];
}

- (void)tapAgeButton:(UIButton *)button {
    [self tapButtonWithJumpType:EYJumpTypeMineAgeButton];
}

- (void)tapLocationButton:(UIButton *)button {
    [self tapButtonWithJumpType:EYJumpTypeMineLocationButton];
}

- (void)tapSchoolButton:(UIButton *)button {
    [self tapButtonWithJumpType:EYJumpTypeMineSchoolButton];
}

- (void)tapToMeLikeButton:(UIButton *)button {
    [self tapButtonWithJumpType:EYJumpTypeMineToMeLikeButton];
}

#pragma mark - 回调 delegate
- (void)tapButtonWithJumpType:(EYJumpType)jumpType {
    if (self.delegate && [self.delegate respondsToSelector:@selector(mineCell:didSelectedButton:)]) {
        [self.delegate mineCell:self didSelectedButton:jumpType];
    }
}

#pragma mark - 富文本处理
- (NSAttributedString *)createAttributedStringWithCount:(NSString *)count withTitle:(NSString *)title {
    
    // 个数
    NSMutableDictionary *countAttributeDictionary = [NSMutableDictionary dictionary];
    countAttributeDictionary[NSForegroundColorAttributeName] = EYColorWhite;
    countAttributeDictionary[NSFontAttributeName] = EYSizeFont18;
    
    // title
    NSMutableDictionary *titleAttributeDictionary = [NSMutableDictionary dictionary];
    titleAttributeDictionary[NSForegroundColorAttributeName] = EYColorRGBHexAlpha(0xFEFEFE, 0.6);
    titleAttributeDictionary[NSFontAttributeName] = EYSizeFont13;
    
    // 最后生成的富文本
    NSMutableAttributedString *lastAttributedStringM = [[NSMutableAttributedString alloc] initWithAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ", count] attributes:countAttributeDictionary]];
    
    [lastAttributedStringM appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:titleAttributeDictionary]];
    
    return [[NSAttributedString alloc] initWithAttributedString:lastAttributedStringM];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (CGRectContainsPoint(self.userHeaderButton.bounds, [self.userHeaderButton convertPoint:point fromView:self])) {
        return self.userHeaderButton;
    }
    
    return [super hitTest:point withEvent:event];
}

@end
