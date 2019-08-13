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

@end

@implementation EYCustomViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化界面
    [self setupUI];
}

//1.初始化界面
- (void)setupUI {
    
}

- (UITableView *)tableView {
    if (nil == _tableView) {
        //创建
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, EYStatusBarAndNaviBarHeight, EYScreenWidth, EYScreenHeight - EYStatusBarAndNaviBarHeight) style:UITableViewStylePlain];
        //背景颜色
        tableView.backgroundColor = EYColorClear;
        //取消分割线
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        //滚动条
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 550;
        //设置数据源和代理
        tableView.dataSource = self;
        tableView.delegate = self;
        // 添加
        [self.view addSubview:tableView];
        
//        // 设置偏移量为0
//        if (@available(iOS 11.0, *)) {
//            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        } else {
//            self.automaticallyAdjustsScrollViewInsets = NO;
//        }
        
//        [tableView registerClass:[TTMessageDetailCell class] forCellReuseIdentifier:TTMessageDetailViewControllerCellID];
        
        //赋值
        _tableView = tableView;
    }
    return _tableView;
}

@end
