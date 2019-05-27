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
        self.ey_titleLabel.font = EYSizeFont14;
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

// 当前选中的下表
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
        self.backgroundColor = EYColorRGBHexAlpha(0x1A1B20, 0.3);
        
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

//@interface EYTabBarView()
//
///**
// 进度条 label
// */
//@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
//
///**
// 按钮集合
// */
//@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *tabBarButton;
//
///**
// 白色线集合
// */
//@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *lineLabel;
//
//@end
//
//@implementation EYTabBarView
//
//- (void)awakeFromNib {
//    [super awakeFromNib];
//    for (UIButton * button in self.tabBarButton) {
//        if (button.tag == EYTabBarViewTypeHome) {
//            button.selected = YES;
//            button.titleLabel.font = [UIFont systemFontOfSize:17.0 weight:UIFontWeightBold];
//        }
//    }
//
//    // 添加监听
//    [EYNotificationCenter addObserver:self selector:@selector(shouldChangeColor:) name:EYTabbarShouldChangeColorNotification object:nil];
//}
//
//+ (instancetype)tabBarView {
//    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([EYTabBarView class]) owner:nil options:nil] firstObject];
//}
//
//- (IBAction)tapButton:(UIButton *)sender
//{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarView:didSelectedIndex:)]) {
//        [self.delegate tabBarView:self didSelectedIndex:sender.tag];
//    }
//    
//    if (sender.tag == 2) {//+按钮
//        return;
//    }
//    
//    for (UIButton *button in self.tabBarButton) {
//        button.titleLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightBold];
//        button.selected = NO;//恢复默认状态
//    }
//    
//    for (UILabel *label in self.lineLabel) {
//        label.hidden = YES;//恢复默认状态
//        if (label.tag == sender.tag) {
//            label.hidden = NO;
//        }
//    }
//    
//    //当前点击按钮为选择状态
//    sender.selected = YES;
//    sender.titleLabel.font = [UIFont systemFontOfSize:17.0 weight:UIFontWeightBold];
//}
//
//- (IBAction)longPressButton:(UILongPressGestureRecognizer *)sender {
//    if (sender.state == UIGestureRecognizerStateBegan) {
////        UIButton * button = (UIButton *)sender.view;
//    } else if (sender.state == UIGestureRecognizerStateEnded) {
//        
//    } else {
//        
//    }
//}
//
//- (void)shouldChangeColor:(NSNotification *)noti {
//    NSLog(@"notinoti--%@", noti);
//    NSDictionary *userInfo = noti.userInfo;
//    UIColor * color = userInfo[@"color"];
//    self.backgroundColor = color;
//}
//
//- (void)dealloc {
//    [EYNotificationCenter removeObserver:self];
//}
