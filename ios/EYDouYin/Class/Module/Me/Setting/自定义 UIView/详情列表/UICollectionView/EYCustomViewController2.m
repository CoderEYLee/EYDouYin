//
//  EYCustomViewController2.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/8/13.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYCustomViewController2.h"
#import "EYCustomFitView2.h"

@interface EYCustomViewController2 () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *arrayM;


@end

@implementation EYCustomViewController2

static NSString *EYCustomViewController2CellID = @"EYCustomViewController2CellID";

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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:EYCustomViewController2CellID forIndexPath:indexPath];;
    cell.backgroundColor = EYColorRandom;
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (EYScreenWidth - 6) / 3;
    CGFloat height = width * 4 / 3;
    return CGSizeMake(width, height);
}

// 设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(1, 1, 0, 1);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2;
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
         layout.scrollDirection = UICollectionViewScrollDirectionVertical;
         layout.headerReferenceSize = CGSizeMake(EYScreenWidth, 100);
         UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, EYStatusBarAndNaviBarHeight, EYScreenWidth, EYScreenHeight - EYStatusBarAndNaviBarHeight) collectionViewLayout:layout];
         collectionView.backgroundColor = EYColorClear;
         collectionView.showsVerticalScrollIndicator = YES;
         collectionView.dataSource = self;
         collectionView.delegate = self;
         [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:EYCustomViewController2CellID];
        
         EYCustomFitView2 *headView = [[EYCustomFitView2 alloc] init];
         EYVideoModel *videoModel = [[EYVideoModel alloc] init];
         videoModel.video_name = @"的熔岩区为我阿萨德刚放假的沙龙课聚光科技打给偶然间管他呢可根据滑动块就够了国家队进口国的接口规范和欧气软管田炯而过电动机开关机爱干净康拉德设计风格为偶家饿哦为要噶哈到付款了吗的熔岩区为我阿萨德刚放假的沙龙课聚光科技打给偶然间管他呢可根据滑动块就够了国家队进口国的接口规范和欧气软管田炯而过电动机开关机爱干净康拉德设计风格为偶家饿哦为要噶哈到付款了吗的熔岩区为我阿萨德刚放假的沙龙课聚光科技打给偶然间管他呢可根据滑动块就够了国家队进口国的接口规范和欧气软管田炯而过电动机开关机爱干净康拉德设计风格为偶家饿哦为要噶哈到付款了吗";
         headView.videoModel = videoModel;
         [collectionView addSubview:headView];
        
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
