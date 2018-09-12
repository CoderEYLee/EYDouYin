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
#import "EYHomeItemModel.h"

@interface EYHomeViewController () <EYHomeTitleViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) UIScrollView * scrollView;


@property (strong, nonatomic) NSMutableArray *itemArrayM;

@end

@implementation EYHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    EYLog(@"EYHomeViewController--viewDidLoad");

    [self setupUI];

    // 模拟网络数据
    [self loadNetData];
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

    // 2.scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:EYScreenBounds];
    scrollView.contentSize = CGSizeMake(EYScreenWidth, EYScreenHeight * 3);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    [self.view insertSubview:scrollView atIndex:0];
    self.scrollView = scrollView;
}

- (void)loadNetData {
    NSString *jsonName = @"Items.json";
    NSArray *jsonArray = jsonName.ey_loadLocalFile;

    for (int i = 0; i < jsonArray.count; i++) {
        NSDictionary * dictionary = jsonArray[i];
        [self.itemArrayM addObject:[EYHomeItemModel modelWithDictionary:dictionary]];
        EYHomeItemView * itemView = [[EYHomeItemView alloc] initWithFrame:CGRectMake(0, EYScreenHeight * i, EYScreenWidth, EYScreenHeight)];
        itemView.backgroundColor = EYRandomColor;
        [self.scrollView addSubview:itemView];
    }

//    for (EYHomeItemModel * model in self.itemArrayM) {
//
//    }
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

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    EYLog(@"scrollView滚动到顶部了");
}

#pragma mark - 懒加载
- (NSMutableArray *)itemArrayM {
    if (nil == _itemArrayM) {
        _itemArrayM = [NSMutableArray array];
    }
    return _itemArrayM;
}

@end
