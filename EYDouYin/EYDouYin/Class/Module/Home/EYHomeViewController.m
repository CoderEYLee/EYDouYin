//
//  EYHomeViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/23.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYHomeViewController.h"
#import "EYRootViewController.h"
#import "EYHomeTitleView.h"
#import "EYHomeItemView.h"

@interface EYHomeViewController () <EYHomeTitleViewDelegate>

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
    EYHomeTitleView * titleView = [EYHomeTitleView homeTitleView];
    titleView.delegate = self;
    [self.view addSubview:titleView];
}

- (void)setupItemView {
    EYHomeItemView * itemView = [EYHomeItemView homeItemView];
    [self.view insertSubview:itemView atIndex:0];
}

- (void)search {
    EYRootViewController * rootViewController = (EYRootViewController *)EYKeyWindowRootViewController;
    [rootViewController.scrollView setContentOffset:CGPointZero animated:YES];
}

- (void)refresh {
    
}

- (void)tapButton:(UIButton *)sender {
    EYTestViewController * vc =[[EYTestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - EYHomeTitleViewDelegate
- (void)homeTitleView:(EYHomeTitleView *)view didSelectedButton:(EYHomeTitleViewButtonType)buttonType {
    switch (buttonType) {
        case EYHomeTitleViewButtonTypeSearch: {
            EYLog(@"搜索");
            break;
        }case EYHomeTitleViewButtonTypeMore: {
            EYLog(@"更多");
            break;
        }case EYHomeTitleViewButtonTypeRecommend: {
            EYLog(@"推荐");
            break;
        }case EYHomeTitleViewButtonTypeCity: {
            EYLog(@"同城");
            break;
        }
        default:
            break;
    }
}

@end
