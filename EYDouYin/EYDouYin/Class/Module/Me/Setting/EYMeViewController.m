//
//  EYMeViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/23.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYMeViewController.h"
#import "EYExcelTool.h"
#import "EYDouYin-Swift.h"

@interface EYMeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *array;

@end

@implementation EYMeViewController

static NSString *EYMeViewControllerCellID = @"EYMeViewControllerCellID";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.array = [EYManager manager].meArray;
    
    //1. 初始化界面
    [self setupUI];
    
    [self.tableView reloadData];
    
    [EYExcelTool startParseExcel];
 }

//1. 初始化界面
- (void)setupUI {
    //1.隐藏分割线
    self.gk_navLineHidden = YES;
    self.gk_navTitle = @"我的";
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.array[section] valueForKeyPath:@"items"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EYMeViewControllerCellID];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EYMeViewControllerCellID];
        cell.backgroundColor = EYColorClear;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = EYColorWhite;
    }

    NSArray *items = [self.array[indexPath.section] valueForKeyPath:@"items"];
    NSDictionary *item = items[indexPath.row];
    cell.textLabel.text = item[@"name"];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDictionary *group = self.array[section];
    return group[@"groupName"];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.array valueForKeyPath:@"groupName"];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    return;
    NSArray *items = [self.array[indexPath.section] valueForKeyPath:@"items"];
    NSDictionary *item = items[indexPath.row];
    NSString *vcName = item[@"vcName"];
    GKNavigationBarViewController *vc = [[NSClassFromString(vcName) alloc] init];
    if ([vc isKindOfClass:GKNavigationBarViewController.class]) {
       vc.gk_navTitle = item[@"name"];
    }
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, EYStatusBarAndNaviBarHeight, EYScreenWidth, EYScreenHeight - EYStatusBarAndNaviBarHeight - EYTabBarHeight - EYHomeIndicatorHeight) style:UITableViewStyleGrouped];
        if (@available(iOS 11.0, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = EYColorClear;
        tableView.dataSource = self;
        tableView.delegate = self;
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

@end
