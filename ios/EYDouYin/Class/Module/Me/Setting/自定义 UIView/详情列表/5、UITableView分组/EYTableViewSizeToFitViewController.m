//
//  EYTableViewSizeToFitViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/8/30.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYTableViewSizeToFitViewController.h"

@interface EYTableViewSizeToFitViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrayM;

@end

@implementation EYTableViewSizeToFitViewController

static NSString *EYTableViewSizeToFitViewControllerCellID = @"EYTableViewSizeToFitViewControllerCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化界面
    [self setupUI];
    
    [EYProgressHUD showInfoWithStatus:@"还没有测试完成"];
}

- (void)setupUI {
    self.view.backgroundColor = EYColorRandom;
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EYTableViewSizeToFitViewControllerCellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EYTableViewSizeToFitViewControllerCellID];
    }
    
    cell.backgroundColor = EYColorRandom;
    
    return cell;
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (nil == _tableView) {
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, EYStatusBarAndNaviBarHeight, EYScreenWidth, EYScreenHeight - EYStatusBarAndNaviBarHeight) style:UITableViewStylePlain];
        tableView.backgroundColor = EYColorClear;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 44;
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        tableView.dataSource = self;
        tableView.delegate = self;
        [self.view addSubview:tableView];
        
        _tableView = tableView;
    }
    return _tableView;
}

- (NSMutableArray *)arrayM {
    if (nil == _arrayM) {
        _arrayM = [NSMutableArray array];
        for (int i = 0; i < 100; i++) {
            [_arrayM addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
    return _arrayM;
}

@end
