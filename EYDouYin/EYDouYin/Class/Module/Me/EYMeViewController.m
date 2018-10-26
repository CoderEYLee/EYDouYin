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
    self.array = @[@"1", @"2"];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"cell";

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    cell.backgroundColor = [UIColor redColor];

    return cell;
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView * tableView = [[UITableView alloc] initWithFrame:EYScreenBounds style:UITableViewStylePlain];
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
