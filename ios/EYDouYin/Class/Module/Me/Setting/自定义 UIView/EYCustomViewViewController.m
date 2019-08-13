//
//  EYCustomViewViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/8/13.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYCustomViewViewController.h"

@interface EYCustomViewViewController() <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrayM;

@end

@implementation EYCustomViewViewController

static NSString *EYCustomViewViewControllerCellID = @"EYCustomViewViewControllerCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化界面
    [self setupUI];
}

//1.初始化界面
- (void)setupUI {
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:EYCustomViewViewControllerCellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EYCustomViewViewControllerCellID];
    }
    
    cell.backgroundColor = EYColorRandom;
    
    return cell;
}

- (UITableView *)tableView {
    if (nil == _tableView) {
        //创建
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, EYStatusBarAndNaviBarHeight, EYScreenWidth, EYScreenHeight - EYStatusBarAndNaviBarHeight) style:UITableViewStylePlain];
        tableView.backgroundColor = EYColorClear;
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 100;
        //设置数据源和代理
        tableView.dataSource = self;
        tableView.delegate = self;
        [self.view addSubview:tableView];
        
        //赋值
        _tableView = tableView;
    }
    return _tableView;
}

- (NSMutableArray *)arrayM {
    if (nil == _arrayM) {
        _arrayM = [NSMutableArray array];
    }
    return _arrayM;
}

@end
