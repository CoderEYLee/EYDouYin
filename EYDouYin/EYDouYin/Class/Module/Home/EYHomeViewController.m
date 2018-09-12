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

@end

@implementation EYHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = EYRandomColor;
    EYLog(@"EYHomeViewController--viewDidLoad");

    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [UIApplication sharedApplication].statusBarHidden = YES;
    EYRootViewController * rootViewController = (EYRootViewController *)EYKeyWindowRootViewController;
    rootViewController.scrollView.scrollEnabled = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [UIApplication sharedApplication].statusBarHidden = NO;

    EYRootViewController * rootViewController = (EYRootViewController *)EYKeyWindowRootViewController;
    rootViewController.scrollView.scrollEnabled = NO;
}

- (void)setupUI {
    self.naviBar.hidden = NO;
    // 1.titleView
    EYHomeTitleView * titleView = [EYHomeTitleView homeTitleView];
    titleView.delegate = self;
    [self.naviBar addSubview:titleView];

    //具体展示的 view
    EYHomeItemView * itemView = [EYHomeItemView homeItemView];
    [self.view insertSubview:itemView atIndex:0];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    EYTestViewController * vc= [[EYTestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Life Cycle
#pragma mark - Public Methods
#pragma mark - Private Methods
- (void)search {
    EYRootViewController * rootViewController = (EYRootViewController *)EYKeyWindowRootViewController;
    [rootViewController.scrollView setContentOffset:CGPointZero animated:YES];
}

- (void)recommend {

}

- (void)city {

}

- (void)more {

}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - EYHomeTitleViewDelegate
- (void)homeTitleView:(EYHomeTitleView *)view didSelectedButton:(EYHomeTitleViewButtonType)buttonType {
    switch (buttonType) {
        case EYHomeTitleViewButtonTypeSearch: {
            EYLog(@"搜索");
            [self search];
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
