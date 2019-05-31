//
//  EYTabBarView.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/5.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYTabBarView.h"

// 内部使用的按钮
@interface EYTabBarViewButton : UIButton

// 标题
@property (copy, nonatomic) NSString *ey_title;
@property (weak, nonatomic) UILabel *ey_titleLabel;

// 下划线
@property (weak, nonatomic) UILabel *lineLabel;

@end

@implementation EYTabBarViewButton

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        self.ey_titleLabel.font = EYSizeFont16;
        self.ey_titleLabel.textColor = EYColorWhite;
        self.lineLabel.hidden = NO;
    } else {
        self.ey_titleLabel.font = EYSizeFont15;
        self.ey_titleLabel.textColor = EYColorWhite0_2;
        self.lineLabel.hidden = YES;
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        CGFloat width = frame.size.width;
//        CGFloat height = frame.size.height;
        
        //1.标题
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = EYColorWhite;
        [self addSubview:label];
        self.ey_titleLabel = label;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
        
        //2.下划线
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.layer.cornerRadius = 1.0;
        lineLabel.layer.masksToBounds = YES;
        lineLabel.backgroundColor = EYColorWhite;
        [self addSubview:lineLabel];
        self.lineLabel = lineLabel;
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.centerX.mas_equalTo(0);
            make.width.mas_equalTo(label.mas_width);
            make.height.mas_equalTo(2);
        }];
    }
    return self;
}

- (void)setEy_title:(NSString *)ey_title {
    _ey_title = ey_title;
    
    self.ey_titleLabel.text = ey_title;
}

@end

@interface EYTabBarView()

@property (strong, nonatomic) NSMutableArray <EYTabBarViewButton *>*buttons;

// 当前选中的下标
@property (assign, nonatomic) NSUInteger selectedIndex;

@end

@implementation EYTabBarView

+ (instancetype)tabBarView {
    return [[EYTabBarView alloc] initWithFrame:CGRectMake(0, 0, EYScreenWidth, EYTabBarHomeIndicatorHeight)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //1.设置背景颜色
        self.backgroundColor = EYColorRGBHexAlpha(0x1A1B20, 0.1);
        
        //2.初始化组件
        int count = 5;
        CGFloat buttonWidth = EYScreenWidth / count;
        NSArray *array = @"TabBar.json".ey_loadLocalJSONFile;
        
        for (int i = 0; i < count; i++) {
            EYTabBarViewButton *button = [[EYTabBarViewButton alloc] initWithFrame:CGRectMake(i * buttonWidth, 0, buttonWidth, EYTabBarHeight)];
            button.tag = i;
            NSString *title = array[i][@"title"];
            if (title.length) {
                button.ey_title = title;
            } else {
                [button setImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
            }
            // 添加事件
            [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [self.buttons addObject:button];
        }
        
        // 默认选中第 0 个
        self.buttons.firstObject.selected = YES;
        self.selectedIndex = 0;
    }
    return self;
}

- (void)tapButton:(UIButton *)button {
    NSUInteger willSelectedIndex = button.tag;
    if (self.selectedIndex == willSelectedIndex) {//重复点击
        return;
    }
    
    // 默认能够选择对应的下标
    BOOL isCanSelected = YES;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarView:shouldSelectedIndex:)]) {
        isCanSelected = [self.delegate tabBarView:self shouldSelectedIndex:button.tag];
    }
    
    // 允许选择
    if (isCanSelected) {
        self.selectedIndex = willSelectedIndex;
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    //取消选中状态
    for (UIButton *button in self.buttons) {
        button.selected = NO;
    }
    
    //设置选中状态
    if (selectedIndex < self.buttons.count) {
        self.buttons[selectedIndex].selected = YES;
    }
}

#pragma mark - 懒加载
- (NSMutableArray<EYTabBarViewButton *> *)buttons {
    if (nil == _buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

@end
