//
//  EYMineViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/6/18.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYMineViewController.h"

@interface EYMineViewController() <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) UIImageView *backImageView;

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrayM;

@end

@implementation EYMineViewController
//背景图的最大高度
const CGFloat EYBackImageViewHeight = 300;
static NSString *EYMineViewControllerCellID = @"EYMineViewControllerCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 初始化界面
    [self setupUI];
}

//1. 初始化界面
- (void)setupUI {
    //1.隐藏分割线
    self.gk_navLineHidden = YES;
//    self.gk_navTitle = @"我的";
    
    if (self.jumpType == EYJumpTypeDefault) {
        //背景图片(放大)
        UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, EYScreenWidth, EYBackImageViewHeight)];
        backImageView.image = [UIImage imageNamed:@"common_placeholder_mine"];
        backImageView.contentMode = UIViewContentModeScaleAspectFill;
        backImageView.layer.anchorPoint = CGPointMake(0.5, 0);
        backImageView.center = CGPointMake(EYScreenWidth * 0.5, 0);
        backImageView.size = CGSizeMake(EYScreenWidth, EYBackImageViewHeight);
        [self.view addSubview:backImageView];
        self.backImageView = backImageView;
        
        //2.UITableView
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, EYScreenWidth, EYScreenHeight - EYTabBarHomeIndicatorHeight) style:UITableViewStylePlain];
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
        // 设置偏移量为0
        if (@available(iOS 11.0, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        tableView.contentInset = UIEdgeInsetsMake(EYBackImageViewHeight * 0.4, 0, 0, 0);
        [self.view addSubview:tableView];
        self.tableView = tableView;
        
        //3.底部 view
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, EYScreenHeight - EYTabBarHomeIndicatorHeight, EYScreenWidth, EYTabBarHomeIndicatorHeight)];
        bottomView.backgroundColor = EYColorBlack;
        [self.view addSubview:bottomView];
    } else {
        //2.UITableView
        UITableView *tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, EYScreenWidth, EYScreenHeight - EYTabBarHomeIndicatorHeight) style:UITableViewStyleGrouped];
        [self.view addSubview:tabelView];
        self.tableView = tabelView;
    }
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
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EYMineViewControllerCellID];
    }
    
    cell.backgroundColor = EYColorRandom;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EYLog(@"12345678943==%ld", indexPath.row);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 向下拽了多少距离
    CGFloat contentOffsetY = -scrollView.contentOffset.y;
    if (contentOffsetY <= EYBackImageViewHeight * 0.4) {//起始位置
        EYLog(@"起始位置==%f", contentOffsetY);
        self.backImageView.bounds = CGRectMake(0, 0, EYScreenWidth, EYBackImageViewHeight);
    } else if (contentOffsetY >= EYBackImageViewHeight) {//向下拽的最大位置
        scrollView.contentOffset = CGPointMake(0, -EYBackImageViewHeight);
        CGFloat scale = 0.3;
        self.backImageView.bounds = CGRectMake(0, 0, EYScreenWidth * (1 + scale), EYBackImageViewHeight * (1 + scale));
    } else {//需要放大图片
        CGFloat scale = (1 - (EYBackImageViewHeight - contentOffsetY) / (EYBackImageViewHeight * 0.6)) * 0.3;
        self.backImageView.bounds = CGRectMake(0, 0, EYScreenWidth * (1 + scale), EYBackImageViewHeight * (1 + scale));
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)arrayM {
    if (nil == _arrayM) {
        _arrayM = [NSMutableArray array];
        for (int i = 0; i < 100; i++) {
            [_arrayM addObject:@"1"];
            [_arrayM addObject:@"2"];
        }
    }
    return _arrayM;
}

@end
