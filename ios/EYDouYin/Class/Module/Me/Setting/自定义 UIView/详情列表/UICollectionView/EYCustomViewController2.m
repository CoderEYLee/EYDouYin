//
//  EYCustomViewController2.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/8/13.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYCustomViewController2.h"
#import "EYCustom2CollectionViewCell1.h"
#import "EYCustom2CollectionViewCell2.h"

@interface EYCustomViewController2 () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *arrayM;


@end

@implementation EYCustomViewController2

static NSString *EYCustomViewController2CellID1 = @"EYCustomViewController2CellID1";
static NSString *EYCustomViewController2CellID2 = @"EYCustomViewController2CellID2";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化界面
    [self setupUI];
}

//1.初始化界面
- (void)setupUI {
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayM.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        EYCustom2CollectionViewCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:EYCustomViewController2CellID1 forIndexPath:indexPath];
        
        return cell;
    } else {
        EYCustom2CollectionViewCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:EYCustomViewController2CellID2 forIndexPath:indexPath];
        
        return cell;
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    EYLog(@"点击了 cell==%ld", indexPath.row);
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    if (nil == _collectionView) {
        #pragma mark - 方式一
        /*
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, EYStatusBarAndNaviBarHeight, EYScreenWidth, EYScreenHeight - EYStatusBarAndNaviBarHeight) collectionViewLayout:layout];
        collectionView.backgroundColor = EYColorClear;
        collectionView.showsVerticalScrollIndicator = YES;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:EYCustomViewController2CellID];
        
        collectionView.contentInset = UIEdgeInsetsMake(300, 0, 0, 0);
        
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, -300, collectionView.bounds.size.width, 300)];
        headView.backgroundColor = EYColorRandom;
        [collectionView addSubview:headView];
        
        [self.view addSubview:collectionView];
        _collectionView = collectionView;
         */
        
#pragma mark - 方式二
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat width = (EYScreenWidth - 16.0) / 3.0;
        layout.estimatedItemSize = CGSizeMake(width, width * 4.0 / 3.0);
        layout.minimumLineSpacing = 4.0;
        layout.minimumInteritemSpacing = 1.0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(4.0, EYStatusBarAndNaviBarHeight, EYScreenWidth - 8.0, EYScreenHeight - EYStatusBarAndNaviBarHeight) collectionViewLayout:layout];
        collectionView.backgroundColor = EYColorClear;
        collectionView.showsVerticalScrollIndicator = YES;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [collectionView registerClass:[EYCustom2CollectionViewCell1 class] forCellWithReuseIdentifier:EYCustomViewController2CellID1];
        [collectionView registerClass:[EYCustom2CollectionViewCell2 class] forCellWithReuseIdentifier:EYCustomViewController2CellID2];
        [self.view addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (NSMutableArray *)arrayM {
    if (nil == _arrayM) {
        _arrayM = [NSMutableArray array];
        for (int i = 0; i < 20; i++) {
            [_arrayM addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
    return _arrayM;
}

@end
