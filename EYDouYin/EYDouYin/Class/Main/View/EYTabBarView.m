//
//  EYTabBarView.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/5.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYTabBarView.h"

@interface EYTabBarView()

/**
 进度条 label
 */
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

/**
 按钮集合
 */
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *tabBarButton;

/**
 白色线集合
 */
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *lineLabel;

@end

@implementation EYTabBarView

- (void)awakeFromNib {
    [super awakeFromNib];
    for (UIButton * button in self.tabBarButton) {
        if (button.tag == EYTabBarViewTypeHome) {
            button.selected = YES;
            button.titleLabel.font = [UIFont systemFontOfSize:17.0 weight:UIFontWeightBold];
        }
    }

    // 添加监听
    [EYNotificationCenter addObserver:self selector:@selector(shouldChangeColor:) name:EYTabbarShouldChangeColorNotification object:nil];
}

+ (instancetype)tabBarView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([EYTabBarView class]) owner:nil options:nil] firstObject];
}

- (IBAction)tapButton:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarView:didSelectedIndex:)]) {
        [self.delegate tabBarView:self didSelectedIndex:sender.tag];
    }
    
    if (sender.tag == 2) {//+按钮
        return;
    }
    
    for (UIButton *button in self.tabBarButton) {
        button.titleLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightBold];
        button.selected = NO;//恢复默认状态
    }
    
    for (UILabel *label in self.lineLabel) {
        label.hidden = YES;//恢复默认状态
        if (label.tag == sender.tag) {
            label.hidden = NO;
        }
    }
    
    //当前点击按钮为选择状态
    sender.selected = YES;
    sender.titleLabel.font = [UIFont systemFontOfSize:17.0 weight:UIFontWeightBold];
}

- (IBAction)longPressButton:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        UIButton * button = (UIButton *)sender.view;
        NSLog(@"----------%ld--", button.tag);
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        
    } else {
        
    }
}

- (void)shouldChangeColor:(NSNotification *)noti {
    NSLog(@"notinoti--%@", noti);
    NSDictionary *userInfo = noti.userInfo;
    UIColor * color = userInfo[@"color"];
    self.backgroundColor = color;
}

- (void)dealloc {
    [EYNotificationCenter removeObserver:self];
}

@end
