//
//  EYCollectionViewOtherController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/10/31.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYCollectionViewOtherController.h"
#import "EYCircleLayout.h"
#import "EYFlowLayout.h"
#import "EYShopCell.h"
#import "EYShop.h"

@interface EYCollectionViewOtherController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *collectionViewShops;

@end

@implementation EYCollectionViewOtherController

static NSString *const EYCollectionViewOtherControllerCellID = @"EYCollectionViewOtherControllerCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.自定义布局
    EYCircleLayout *layout = [[EYCircleLayout alloc] init];

    // 2.创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, EYScreenWidth, 300) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(EYShopCell.class) bundle:nil] forCellWithReuseIdentifier:EYCollectionViewOtherControllerCellID];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

- (IBAction)tapSegmentdCotrol:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0: {//圆圈
            [self.collectionView setCollectionViewLayout:[[EYCircleLayout alloc] init] animated:YES];
            break;
        }
        case 1: {//线性
            [self.collectionView setCollectionViewLayout:[[EYFlowLayout alloc] init] animated:YES];
            break;
        }
        case 2: {//待定
            break;
        }

        default:
            break;
    }
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionViewShops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EYShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:EYCollectionViewOtherControllerCellID forIndexPath:indexPath];
    cell.shop = self.collectionViewShops[indexPath.item];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

#pragma mark - 懒加载
- (NSMutableArray *)collectionViewShops {
    if (nil == _collectionViewShops) {
        _collectionViewShops = [EYShop mj_objectArrayWithFilename:@"Shops.plist"];
    }
    return _collectionViewShops;
}

@end
