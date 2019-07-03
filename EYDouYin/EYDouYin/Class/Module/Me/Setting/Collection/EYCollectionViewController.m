
//
//  EYCollectionViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/11/2.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYCollectionViewController.h"
#import "EYCollectionDetailViewController.h"

@interface EYCollectionViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *array;

@end

@implementation EYCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.array = [EYManager manager].collectionArray;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"EYCollectionViewControllerCellID";

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    NSDictionary *item = self.array[indexPath.row];
    cell.textLabel.text = item[@"title"];

    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *item = self.array[indexPath.row];
    EYCollectionDetailViewController *vc = [[EYCollectionDetailViewController alloc] init];
    vc.content_url = item[@"content_url"];
    if (item[@"lock"]) {
        //添加提示框
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您正在访问内部优惠券" preferredStyle:UIAlertControllerStyleAlert];
        __weak typeof(alert) weakAlert = alert;
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.secureTextEntry = YES;
            textField.keyboardType = UIKeyboardTypeNumberPad;
        }];
        [alert addTextFieldWithConfigurationHandler:nil];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            __strong typeof(weakAlert) alert = weakAlert;
            NSString *password = alert.textFields.firstObject.text;
            if ([password.md2String isEqualToString:@"ec959feaadc86988b166247cd670dbaf"]) {
                NSString *text = alert.textFields.lastObject.text;
                if (text.length) {
                    NSString *urlString = item[@"content_url"];
                    urlString = [urlString stringByReplacingOccurrencesOfString:@"baidu" withString:text options:NSRegularExpressionSearch range:NSMakeRange(0, urlString.length - 1)];
                    vc.content_url = urlString;
                }
                [self.navigationController pushViewController:vc animated:YES];
            }
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, EYStatusBarAndNaviBarHeight, EYScreenWidth, EYScreenHeight - EYStatusBarAndNaviBarHeight - EYHomeIndicatorHeight) style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        if (@available(iOS 11.0, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

@end
