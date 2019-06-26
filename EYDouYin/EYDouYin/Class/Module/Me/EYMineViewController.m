//
//  EYMineViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/6/18.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYMineViewController.h"
#import "EYMineCell.h"
#import "EYMeViewController.h"

@interface EYMineViewController() <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) UIImageView *backImageView;

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrayM;

@end

@implementation EYMineViewController
//背景图的真正高度
const CGFloat EYBackImageViewRealHeight = 310;
//背景图的开始显示比例
const CGFloat EYBackImageViewBeginScale = 0.5;
static NSString *EYMineViewControllerCellID = @"EYMineViewControllerCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 初始化界面
    [self setupUI];
}

//1. 初始化界面
- (void)setupUI {
    if (self.jumpType == EYJumpTypeDefault) {//自己的界面
        //1.隐藏导航
        self.gk_navigationBar.hidden = YES;
        //1.1 顶部视图
        UIButton *settingButton = [[UIButton alloc] initWithFrame:CGRectMake(EYScreenWidth - 64, EYStatusBarHeight, 44, 44)];
        settingButton.backgroundColor = EYColorRandom;
        [settingButton addTarget:self action:@selector(trapSettingButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:settingButton];
        
        //4.底部 view
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, EYScreenHeight - EYTabBarHomeIndicatorHeight, EYScreenWidth, EYTabBarHomeIndicatorHeight)];
        bottomView.backgroundColor = EYColorBlack;
        [self.view addSubview:bottomView];
    } else {
        //1.隐藏分割线
        self.gk_navLineHidden = YES;
    }
    
    //2.背景图片(放大)
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, EYScreenWidth, EYBackImageViewRealHeight)];
    backImageView.image = [UIImage imageNamed:@"common_placeholder_mine"];
    backImageView.contentMode = UIViewContentModeScaleAspectFit;
    backImageView.layer.anchorPoint = CGPointMake(0.5, 0);
    backImageView.center = CGPointMake(EYScreenWidth * 0.5, 0);
    backImageView.size = CGSizeMake(EYScreenWidth, EYBackImageViewRealHeight);
    [self.view insertSubview:backImageView atIndex:0];
    self.backImageView = backImageView;
    
    //3.UITableView
    CGFloat tableViewHeight = EYScreenHeight;
    if (self.jumpType == EYJumpTypeDefault) {
        tableViewHeight -= EYTabBarHomeIndicatorHeight;
    }
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, EYScreenWidth, tableViewHeight) style:UITableViewStylePlain];
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.dataSource = self;
    tableView.delegate = self;
    //背景颜色
    tableView.backgroundColor = EYColorClear;
    //取消分割线
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 100;
    [tableView registerClass:[EYMineCell class] forCellReuseIdentifier:EYMineViewControllerCellID];
    // 设置偏移量为0
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    tableView.contentInset = UIEdgeInsetsMake(EYBackImageViewRealHeight * EYBackImageViewBeginScale, 0, 0, 0);
    [self.view insertSubview:tableView aboveSubview:backImageView];
    self.tableView = tableView;
}

#pragma mark - Private Methods
- (void)trapSettingButton:(UIButton *)button {
    EYMeViewController *vc = [[EYMeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:EYMineViewControllerCellID];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EYLog(@"12345678943==%ld", indexPath.row);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //偏移量
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    
    // 1.背景图放大效果
    CGFloat distance = -contentOffsetY;
    if (distance <= EYBackImageViewRealHeight * EYBackImageViewBeginScale) {//起始位置
        self.backImageView.bounds = CGRectMake(0, 0, EYScreenWidth, EYBackImageViewRealHeight);
    } else if (distance >= EYBackImageViewRealHeight) {//向下拽的最大位置
        scrollView.contentOffset = CGPointMake(0, -EYBackImageViewRealHeight);
        CGFloat scale = 0.2;
        self.backImageView.bounds = CGRectMake(0, 0, EYScreenWidth * (1 + scale), EYBackImageViewRealHeight * (1 + scale));
    } else {//需要放大图片
        CGFloat scale = (1 - (EYBackImageViewRealHeight - distance) / (EYBackImageViewRealHeight * (1 - EYBackImageViewBeginScale))) * 0.2;
        self.backImageView.bounds = CGRectMake(0, 0, EYScreenWidth * (1 + scale), EYBackImageViewRealHeight * (1 + scale));
    }
    
    EYLog(@"00000000000==%f", contentOffsetY);
    //2.导航栏的颜色变化
    if (contentOffsetY < 100) {//0
        EYLog(@"111111111111");
        self.gk_navBarAlpha = 0.0;
    } else if (contentOffsetY >= 100 && contentOffsetY <= 200) {
        EYLog(@"222222222222");
        self.gk_navBarAlpha = 0.5;
    } else {//1
        EYLog(@"333333333333");
        self.gk_navBarAlpha = 1.0;
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)arrayM {
    if (nil == _arrayM) {
        _arrayM = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            [_arrayM addObject:@"1"];
            [_arrayM addObject:@"2"];
        }
    }
    return _arrayM;
}

@end
