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

@interface EYWaterFallViewController () <UICollectionViewDataSource, UICollectionViewDelegate, EYWaterflowLayoutDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *shops;
@end

@implementation EYWaterFallViewController

static NSString *const ID = @"EYWaterFallViewControllerCell";

- (void)viewDidLoad {
    [super viewDidLoad];

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

- (IBAction)tapSegmentedControl:(UISegmentedControl *)sender {

}

#pragma mark - 懒加载
- (NSMutableArray *)shops {
    if (nil == _shops) {
        _shops = [EYShop mj_objectArrayWithFilename:@"Shops.plist"];
    }
    return _shops;
}

@end
