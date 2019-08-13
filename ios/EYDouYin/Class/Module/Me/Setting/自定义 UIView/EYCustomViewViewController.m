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
@property (strong, nonatomic) NSMutableArray <EYLocalUseModel *>*arrayM;

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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:EYCustomViewViewControllerCellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EYCustomViewViewControllerCellID];
    }
    
    cell.backgroundColor = EYColorRandom;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EYLocalUseModel *localUseModel = self.arrayM[indexPath.row];
    EYLog(@"11111111==%@", localUseModel);
}

#pragma mark - 懒加载

- (UITableView *)tableView {
    if (nil == _tableView) {
        //创建
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, EYStatusBarAndNaviBarHeight, EYScreenWidth, EYScreenHeight - EYStatusBarAndNaviBarHeight) style:UITableViewStylePlain];
        tableView.backgroundColor = EYColorClear;
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

- (NSMutableArray<EYLocalUseModel *> *)arrayM {
    if (nil == _arrayM) {
        _arrayM = [EYLocalUseModel mj_objectArrayWithFilename:@"EYMeCustomViewArray.plist"];
    }
    return _arrayM;
}

@end
