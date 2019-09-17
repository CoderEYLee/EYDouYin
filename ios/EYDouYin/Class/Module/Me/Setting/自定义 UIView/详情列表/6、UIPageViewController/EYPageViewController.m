
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
@property (strong, nonatomic) NSMutableArray *arrayM;

@end

@implementation EYPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化界面
    [self setupUI];
}

//1.初始化界面
- (void)setupUI {
    UIPageViewController *pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionInterPageSpacingKey: @(-100)}];
    pageViewController.dataSource = self;
    pageViewController.delegate = self;
    pageViewController.view.backgroundColor = EYColorRed;
    [self.view addSubview:pageViewController.view];
    [self addChildViewController:pageViewController];
    self.pageViewController = pageViewController;
    
    [pageViewController setViewControllers:@[self.arrayM.firstObject] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}

#pragma mark - UIPageViewControllerDataSource

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    EYLog(@"33333333333");
    NSUInteger index = [self.arrayM indexOfObject:viewController];
    if (index == 0 || (index == NSNotFound)) {
        return nil;
    }
    return self.arrayM[--index];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    EYLog(@"4444444444444");
    NSUInteger index = [self.arrayM indexOfObject:viewController];
    if (index == self.arrayM.count - 1 || (index == NSNotFound)) {
        return nil;
    }

    return self.arrayM[++index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.arrayM.count;
}
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    UIViewController *nextVC = [pendingViewControllers firstObject];
    NSInteger index = [self.arrayM indexOfObject:nextVC];
    
     EYLog(@"开始==%@==%ld", pendingViewControllers, index);
}

// Sent when a gesture-initiated transition ends. The 'finished' parameter indicates whether the animation finished, while the 'completed' parameter indicates whether the transition completed or bailed out (if the user let go early).
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    UIViewController *nextVC = [previousViewControllers firstObject];
    NSInteger index = [self.arrayM indexOfObject:nextVC];
    EYLog(@"结束==%@==上一个下标:%ld==是否结束:%d==是否完成:%d", previousViewControllers, index, finished, completed);
}

//- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
//
//}

//- (UIInterfaceOrientationMask)pageViewControllerSupportedInterfaceOrientations:(UIPageViewController *)pageViewController {
//
//}
//- (UIInterfaceOrientation)pageViewControllerPreferredInterfaceOrientationForPresentation:(UIPageViewController *)pageViewController {
//
//}

#pragma mark - 懒加载

- (NSMutableArray *)arrayM {
    if (nil == _arrayM) {
        _arrayM = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            EYTestViewController *vc = [[EYTestViewController alloc] init];
            vc.view.backgroundColor = EYColorRandom;
            vc.label.text = [NSString stringWithFormat:@"%d", i];
            [_arrayM addObject:vc];
        }
    }
    return _arrayM;
}

@end
