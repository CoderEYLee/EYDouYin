
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

@property (strong, nonatomic) NSMutableArray <EYLocalUseModel *>*arrayM;

@end

@implementation EYCollectionViewController

static NSString *EYCollectionViewControllerCellID = @"EYCollectionViewControllerCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:EYCollectionViewControllerCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EYCollectionViewControllerCellID];
        cell.backgroundColor = EYColorClear;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = EYColorWhite;
    }

    cell.textLabel.text = self.arrayM[indexPath.row].title;

    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    EYLocalUseModel *localUseModel = self.arrayM[indexPath.row];
    EYCollectionDetailViewController *vc = [[EYCollectionDetailViewController alloc] init];
    vc.localUseModel = localUseModel;
    if (localUseModel.lock) {
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
                    NSString *content_url = localUseModel.content_url;
                    localUseModel.content_url = [content_url stringByReplacingOccurrencesOfString:@"baidu" withString:text options:NSRegularExpressionSearch range:NSMakeRange(0, content_url.length - 1)];
                    vc.localUseModel = localUseModel;
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
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, EYStatusBarAndNaviBarHeight, EYScreenWidth, EYScreenHeight - EYStatusBarAndNaviBarHeight) style:UITableViewStylePlain];
        tableView.backgroundColor = EYColorClear;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.dataSource = self;
        tableView.delegate = self;
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (NSMutableArray<EYLocalUseModel *> *)arrayM {
    if (nil == _arrayM) {
        _arrayM = [EYLocalUseModel mj_objectArrayWithFilename:@"EYCollectionArray.plist"];
    }
    return _arrayM;
}

@end
