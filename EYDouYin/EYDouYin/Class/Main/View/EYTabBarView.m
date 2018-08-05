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

+ (instancetype)tabBarView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([EYTabBarView class]) owner:nil options:nil] lastObject];
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
        button.titleLabel.font = [UIFont systemFontOfSize:17.0];
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
    sender.titleLabel.font = [UIFont systemFontOfSize:19.0];
}

@end
