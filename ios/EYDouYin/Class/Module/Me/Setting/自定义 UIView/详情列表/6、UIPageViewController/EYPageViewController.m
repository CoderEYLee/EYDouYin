
//
//  EYPageViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/9/11.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYPageViewController.h"

@interface EYPageViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (weak, nonatomic) UIPageViewController *pageViewController;

@end

@implementation EYPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化界面
    [self setupUI];
}

//1.初始化界面
- (void)setupUI {
    UIPageViewController *pageViewController = [[UIPageViewController alloc] init];
    pageViewController.dataSource = self;
    pageViewController.delegate = self;
    pageViewController.view.backgroundColor = EYColorRed;
    [self.view addSubview:pageViewController.view];
    [self addChildViewController:pageViewController];
    self.pageViewController = pageViewController;
}

#pragma mark - UIPageViewControllerDataSource

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    return nil;
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    return nil;
}

#pragma mark - UIPageViewControllerDelegate

@end
