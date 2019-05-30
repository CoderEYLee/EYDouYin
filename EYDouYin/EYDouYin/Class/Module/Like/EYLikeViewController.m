//
//  EYLikeViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/23.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYLikeViewController.h"

@interface EYLikeViewController () <UIScrollViewDelegate>

// 关注按钮
@property (weak, nonatomic) UIButton *followButton;

// 朋友按钮
@property (weak, nonatomic) UIButton *friendButton;

// 滚动条
@property (weak, nonatomic) UILabel *lineLabel;


// 滚动视图
@property (weak, nonatomic) UIScrollView *scrollView;

@end

@implementation EYLikeViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 初始化界面
    [self setupUI];
}

//1. 初始化界面
- (void)setupUI {
    //1.导航
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    self.gk_navTitleView = titleView;
    
    //1.1关注
    UIButton *followButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [followButton setTitle:@"关注" forState:UIControlStateNormal];
    [followButton setTitleColor:EYColorWhite0_5 forState:UIControlStateNormal];
    
    [followButton setTitle:@"关注" forState:UIControlStateSelected];
    [followButton setTitleColor:EYColorWhite forState:UIControlStateSelected];
    followButton.selected = YES;
    
    [followButton addTarget:self action:@selector(tapFollowButton:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:followButton];
    self.followButton = followButton;
    
    //1.2好友
    UIButton *friendButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 0, 50, 44)];
    [friendButton setTitle:@"好友" forState:UIControlStateNormal];
    [friendButton setTitleColor:EYColorWhite0_5 forState:UIControlStateNormal];
    
    [friendButton setTitle:@"好友" forState:UIControlStateSelected];
    [friendButton setTitleColor:EYColorWhite forState:UIControlStateSelected];
    friendButton.selected = NO;
    
    [friendButton addTarget:self action:@selector(tapFriendButton:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:friendButton];
    self.friendButton = friendButton;
    
    //1.3 "滚动条"
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 42, 40, 2)];
    lineLabel.backgroundColor = EYColorFFCC00;
    lineLabel.layer.cornerRadius = 2.0;
    lineLabel.layer.masksToBounds = YES;
    [titleView addSubview:lineLabel];
    self.lineLabel = lineLabel;
    
    //2.滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, EYStatusBarAndNaviBarHeight, EYScreenWidth, EYScreenHeight - EYStatusBarAndNaviBarHeight - EYTabBarHomeIndicatorHeight)];
    scrollView.backgroundColor = EYColorRandom;
    scrollView.contentSize = CGSizeMake(EYScreenWidth * 2, 0);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
//    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    //2.1 关注 view
    UIView *followView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, EYScreenWidth, scrollView.mj_h)];
    followView.backgroundColor = EYColorRed;
    [scrollView addSubview:followView];
    
    //2.2 好友 view
    UIView *friendView = [[UIView alloc] initWithFrame:CGRectMake(EYScreenWidth, 0, EYScreenWidth, scrollView.mj_h)];
    friendView.backgroundColor = EYColorBlue;
    [scrollView addSubview:friendView];
    
    //3.底部 view
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, EYScreenHeight - EYTabBarHomeIndicatorHeight, EYScreenWidth, EYTabBarHomeIndicatorHeight)];
    bottomView.backgroundColor = EYColorBlack;
    [self.view addSubview:bottomView];
}

#pragma mark - Public Methods
#pragma mark - Private Methods
// 点击关注按钮
- (void)tapFollowButton:(UIButton *)button {
    EYLog(@"点击关注按钮");
    if (button.isSelected) {
        EYLog(@"刷新关注列表");
    } else {
        EYLog(@"展示关注列表");
        [self.scrollView setContentOffset:CGPointZero animated:YES];
    }
    
    self.followButton.selected = YES;
    self.friendButton.selected = NO;
}

// 点击好友按钮
- (void)tapFriendButton:(UIButton *)button {
    EYLog(@"点击好友按钮");
    if (button.isSelected) {
        EYLog(@"刷新好友列表");
    } else {
        EYLog(@"展示好友列表");
        [self.scrollView setContentOffset:CGPointMake(EYScreenWidth, 0) animated:YES];
    }
    
    self.followButton.selected = NO;
    self.friendButton.selected = YES;
}

#pragma mark - Override Methods
#pragma mark - Net Work
#pragma mark - DataSource
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.lineLabel.mj_x = (scrollView.contentOffset.x / EYScreenWidth) * 50;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat index = scrollView.contentOffset.x / EYScreenWidth;
    
    self.followButton.selected = !index;
    self.friendButton.selected = index;
}

#pragma mark - Getters & Setters

@end
