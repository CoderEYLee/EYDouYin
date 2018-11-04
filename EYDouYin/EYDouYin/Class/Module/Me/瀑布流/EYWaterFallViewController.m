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
#import "EYWaterflowShopCell1.h"
#import "EYWaterflowShopCell2.h"

@interface EYWaterFallViewController () <UICollectionViewDataSource, UICollectionViewDelegate, EYWaterflowLayoutDelegate, EYWaterflowViewDataSource, EYWaterflowViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

// 方式一
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *collectionViewShops;

// 方式二
@property (weak, nonatomic) EYWaterflowView * waterflowView;
@property (nonatomic, strong) NSMutableArray *waterflowViewShops;

@end

@implementation EYWaterFallViewController

static NSString *const ID = @"EYWaterFallViewControllerCell";
static NSString *const EYWaterFallViewControllerShopCell1 = @"EYWaterFallViewControllerShopCell1";
static NSString *const EYWaterFallViewControllerShopCell2 = @"EYWaterFallViewControllerShopCell2";

- (void)viewDidLoad {
    [super viewDidLoad];

    // 方式一: UICollectionView控件, 通过布局实现效果
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMorecollectionViewShops)];
    self.collectionView.hidden = NO;

    // 方式二: 自定义继承 UIScrollView 的EYWaterflowView控件,
    self.waterflowView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMorewaterflowViewShops)];
    self.waterflowView.hidden = YES;
}

- (void)loadMorecollectionViewShops {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionViewShops addObjectsFromArray:self.collectionViewShops];
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
    });
}

- (void)loadMorewaterflowViewShops {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.waterflowViewShops addObjectsFromArray:self.waterflowViewShops];
        [self.waterflowView reloadData];
        [self.waterflowView.mj_footer endRefreshing];
    });
}

#pragma mark - 方式一
#pragma mark -- EYWaterflowLayoutDelegate
- (CGFloat)waterflowLayout:(EYWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath {
    EYShop *shop = self.collectionViewShops[indexPath.item];
    return shop.h / shop.w * width;
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionViewShops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EYShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.shop = self.collectionViewShops[indexPath.item];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

#pragma mark - 方式二
#pragma mark -- EYWaterflowViewDataSource
- (NSUInteger)numberOfCellsInWaterflowView:(EYWaterflowView *)waterflowView {
     return self.waterflowViewShops.count;
}

- (EYWaterflowViewCell *)waterflowView:(EYWaterflowView *)waterflowView cellAtIndex:(NSUInteger)index {

//    EYWaterflowShopCell1 *cell = [waterflowView dequeueReusableCellWithIdentifier:EYWaterFallViewControllerShopCell1];
//    if (cell == nil) {
//        cell = [[EYWaterflowShopCell1 alloc] initWithReuseIdentifier:EYWaterFallViewControllerShopCell1];
//        cell.backgroundColor = [UIColor redColor];
//    }

    EYWaterflowShopCell2 *cell = [waterflowView dequeueReusableCellWithIdentifier:EYWaterFallViewControllerShopCell2];
    if (cell == nil) {
        cell = [EYWaterflowShopCell2 waterflowShopCell2];
        cell.reuseIdentifier = EYWaterFallViewControllerShopCell2;
        cell.backgroundColor = [UIColor redColor];
    }

    cell.shop = self.waterflowViewShops[index];

    return cell;
}

#pragma mark -- EYWaterflowViewDelegate
- (CGFloat)waterflowView:(EYWaterflowView *)waterflowView heightAtIndex:(NSUInteger)index {
    EYShop *shop = self.waterflowViewShops[index];
    return shop.h / shop.w * [waterflowView cellWidth]; //默认70
}

- (CGFloat)waterflowView:(EYWaterflowView *)waterflowView marginForType:(EYWaterflowViewMarginType)type {
    return 10; //默认10
}

- (IBAction)tapSegmentedControl:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.collectionView.hidden = NO;
        self.waterflowView.hidden = YES;
    } else {
        self.collectionView.hidden = YES;
        self.waterflowView.hidden = NO;
    }
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    if (nil == _collectionView) {
        // 1.自定义流水布局
        EYWaterflowLayout *layout = [[EYWaterflowLayout alloc] init];
        layout.delegate = self;
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
//        layout.columnMargin = 20;
//        layout.rowMargin = 30;
//        layout.columnsCount = 4;

        // 2.创建UICollectionView
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, EYStatusBarAndNaviBarHeight, EYScreenWidth, EYScreenHeight - EYStatusBarAndNaviBarHeight) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        if (@available(iOS 11.0, *)) {
            collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [collectionView registerNib:[UINib nibWithNibName:@"EYShopCell" bundle:nil] forCellWithReuseIdentifier:ID];
        [self.view addSubview:collectionView];
        self.collectionView = collectionView;
    }
    return _collectionView;
}

- (EYWaterflowView *)waterflowView {
    if (nil == _waterflowView) {
        EYWaterflowView *waterflowView = [[EYWaterflowView alloc] initWithFrame:CGRectMake(0, EYStatusBarAndNaviBarHeight, EYScreenWidth, EYScreenHeight - EYStatusBarAndNaviBarHeight)];
        waterflowView.dataSource = self;
        waterflowView.delegate = self;
        [self.view addSubview:waterflowView];
        self.waterflowView = waterflowView;
    }
    return _waterflowView;
}

- (NSMutableArray *)collectionViewShops {
    if (nil == _collectionViewShops) {
        _collectionViewShops = [EYShop mj_objectArrayWithFilename:@"Shops.plist"];
    }
    return _collectionViewShops;
}

- (NSMutableArray *)waterflowViewShops {
    if (nil == _waterflowViewShops) {
        _waterflowViewShops = [EYShop mj_objectArrayWithFilename:@"Shops.plist"];
    }
    return _waterflowViewShops;
}

@end
