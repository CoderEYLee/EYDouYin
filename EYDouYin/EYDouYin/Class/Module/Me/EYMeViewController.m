//
//  EYMeViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/23.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYMeViewController.h"

@interface EYMeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *array;

@end

@implementation EYMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = EYRandomColor;
    EYLog(@"EYMeViewController--viewDidLoad");
    self.array = @"EYMeViewControllerSourceArray.plist".ey_loadLocalPlistFileArray;
    [self.tableView reloadData];
 }

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.naviBar.backgroundColor = [UIColor greenColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.array[section] valueForKeyPath:@"items"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"cell";

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView * tableView = [[UITableView alloc] initWithFrame:EYScreenBounds style:UITableViewStyleGrouped];
        if (@available(iOS 11.0, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        tableView.dataSource = self;
        tableView.delegate = self;
        _tableView = tableView;

        [self.view addSubview:tableView];
    }
    return _tableView;
}

@end
