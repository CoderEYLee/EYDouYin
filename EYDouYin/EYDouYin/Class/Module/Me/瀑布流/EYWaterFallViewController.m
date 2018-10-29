//
//  EYWaterFallViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/10/29.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYWaterFallViewController.h"
#import "EYWaterflowLayout.h"
#import "EYShop.h"
#import "EYShopCell.h"
#import "EYWaterflowView.h"
#include "EYWaterflowViewCell.h"

@interface EYWaterFallViewController () <UICollectionViewDataSource, UICollectionViewDelegate, EYWaterflowLayoutDelegate, EYWaterflowViewDataSource, EYWaterflowViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

// 方式一
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *shops;

// 方式二
@property (weak, nonatomic) EYWaterflowView * waterflowView;

@end

@implementation EYWaterFallViewController

static NSString *const ID = @"EYWaterFallViewControllerCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    // 方式一: UICollectionView控件, 通过布局实现效果
    [self setupConllectionView];

    // 方式二: 自定义继承 UIScrollView 的EYWaterflowView控件,
    [self setupWaterflowView];
    self.collectionView.hidden = NO;
    self.waterflowView.hidden = YES;
}

- (void)setupConllectionView {
    EYWaterflowLayout *layout = [[EYWaterflowLayout alloc] init];
    layout.delegate = self;
    //    layout.sectionInset = UIEdgeInsetsMake(100, 20, 20, 30);
    layout.columnMargin = 20;
    //    layout.rowMargin = 30;
    //    layout.columnsCount = 4;

    // 2.创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, EYStatusBarAndNaviBarHeight, EYScreenWidth, EYScreenHeight) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerNib:[UINib nibWithNibName:@"EYShopCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;

    // 3.增加刷新控件
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
}

- (void)loadMoreShops {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.shops addObjectsFromArray:self.shops];
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
    });
}

#pragma mark - HMWaterflowLayoutDelegate
- (CGFloat)waterflowLayout:(EYWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath {
    EYShop *shop = self.shops[indexPath.item];
    return shop.h / shop.w * width;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EYShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.shop = self.shops[indexPath.item];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (void)setupWaterflowView {
    EYWaterflowView *waterflowView = [[EYWaterflowView alloc] initWithFrame:CGRectMake(0, EYStatusBarAndNaviBarHeight, EYScreenWidth, EYScreenHeight)];
    waterflowView.dataSource = self;
    waterflowView.delegate = self;
    [self.view addSubview:waterflowView];
    self.waterflowView = waterflowView;
}

#pragma mark - EYWaterflowViewDataSource
- (NSUInteger)numberOfCellsInWaterflowView:(EYWaterflowView *)waterflowView {
    return 100;
}

- (EYWaterflowViewCell *)waterflowView:(EYWaterflowView *)waterflowView cellAtIndex:(NSUInteger)index {
    static NSString * cellID = @"cellID";

    EYWaterflowViewCell * cell = [waterflowView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[EYWaterflowViewCell alloc] initWithReuseIdentifier:cellID];

        cell.backgroundColor = [UIColor redColor];
    }

    return cell;
}

#pragma mark - EYWaterflowViewDelegate
- (CGFloat)waterflowView:(EYWaterflowView *)waterflowView heightAtIndex:(NSUInteger)index {
    return 100 + arc4random_uniform(100);
}

- (IBAction)tapSegmentedControl:(UISegmentedControl *)sender {
    NSLog(@"---%ld", sender.selectedSegmentIndex);
    if (sender.selectedSegmentIndex == 0) {
        self.collectionView.hidden = NO;
        self.waterflowView.hidden = YES;
    } else {
        self.collectionView.hidden = YES;
        self.waterflowView.hidden = NO;
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)shops {
    if (nil == _shops) {
        _shops = [EYShop mj_objectArrayWithFilename:@"Shops.plist"];
    }
    return _shops;
}

@end
