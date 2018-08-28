//
//  EYHomeViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/23.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYHomeViewController.h"
#import "EYRootViewController.h"
#import "EYHomeItemView.h"

@interface EYHomeViewController ()

@property (weak, nonatomic) UIButton * button;

@end

@implementation EYHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = EYRandomColor;
    EYLog(@"EYHomeViewController--viewDidLoad");
    
//    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    button.backgroundColor = EYRandomColor;
//    [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//    self.button = button;

    [self setupUI];
}

- (void)setupUI {
    [self setupTopView];
    [self setupItemView];
}

- (void)setupTopView {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(search) image:@"home_search" highImage:@"home_search"];
    //右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(refresh) image:@"home_more_h" highImage:@"home_more_v"];
    //中间文字
    UILabel * label = [[UILabel alloc] init];
    label.text = @"首页";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:18.0];
    self.navigationItem.titleView = label;
}

- (void)setupItemView {
    EYHomeItemView * itemView = [EYHomeItemView homeItemView];
    [self.view addSubview:itemView];
}

- (void)search {
    EYRootViewController * rootViewController = (EYRootViewController *)EYKeyWindowRootViewController;
    [rootViewController.scrollView setContentOffset:CGPointZero animated:YES];
}

- (void)refresh {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)tapButton:(UIButton *)sender {
    EYTestViewController * vc =[[EYTestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
