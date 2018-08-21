//
//  EYMessageViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/23.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYMessageViewController.h"
#import "EYLikeCell.h"

@interface EYMessageViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) UICollectionView * collectionView;

@property (assign, nonatomic) CGPoint beginDraggingPoint;

@property (strong, nonatomic) NSMutableArray * sourceArrayM;

@property (assign, nonatomic) BOOL isCanSubmit;

@end

static NSString * EYLikeViewControllerCollectionViewCellID = @"EYLikeViewControllerCollectionViewCellID";
static NSString * EYLikeViewControllerCollectionViewHeadViewID = @"EYLikeViewControllerCollectionViewHeadViewID";

@implementation EYMessageViewController

#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = EYRandomColor;
    EYLog(@"EYMessageViewController--viewDidLoad");
    [self.collectionView reloadData];
}

#pragma mark - Public Methods
#pragma mark - Private Methods
#pragma mark - Override Methods
#pragma mark - Net Work
#pragma mark - UICollectionViewDataSource
//多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每组多少个
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sourceArrayM.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EYLikeCell * cell = (EYLikeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:EYLikeViewControllerCollectionViewCellID forIndexPath:indexPath];
    cell.backgroundColor =EYRandomColor;
    cell.label.text = [NSString stringWithFormat:@"%ld组/%ld个", indexPath.section, indexPath.row];
    
    EYLog(@"李二洋---返回 cell--%ld--%ld", indexPath.section, indexPath. row);
    
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:EYLikeViewControllerCollectionViewHeadViewID forIndexPath:indexPath];
    headerView.backgroundColor =[UIColor grayColor];
    UILabel *label = [[UILabel alloc] initWithFrame:headerView.bounds];
    label.text = @"这是collectionView的头部";
    label.font = [UIFont systemFontOfSize:20];
    [headerView addSubview:label];
    return headerView;
}
#pragma mark - Delegate
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(EYScreenWidth, EYScreenHeight-EYTabBarHeight);
}

/*
 //设置每个item的UIEdgeInsets
 - (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
 return UIEdgeInsetsMake(10, 10, 10, 10);
 }
 
 //设置每个item水平间距
 - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
 return 100;
 }
 
 //设置每个item垂直间距
 - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
 return 100;
 }
 
 //header的size
 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
 return CGSizeMake(100, 100);
 }
 
 */
#pragma mark - UIScrollView
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //全局变量记录滑动前的contentOffset
    self.beginDraggingPoint = scrollView.contentOffset;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat currentX = scrollView.contentOffset.x;
    int index = (int) currentX / EYScreenWidth;
    if (index == self.sourceArrayM.count - 1) {
        self.isCanSubmit = YES;
    } else {
        self.isCanSubmit = NO;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat currentX = scrollView.contentOffset.x;
    CGFloat beginX = self.beginDraggingPoint.x;
    // 判断左右滑动时
    if (currentX < beginX){
        EYLog(@"滚动方向向右");
    } else if (currentX > beginX){
        EYLog(@"滚动方向向左--%d", self.isCanSubmit);
        if (self.isCanSubmit) {
            EYTestViewController * vc = [[EYTestViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}

#pragma mark - Getters & Setters
- (UICollectionView *)collectionView {
    if (nil == _collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, EYStatusBarAndNaviBarHeight, EYScreenWidth, EYScreenHeight - EYStatusBarAndNaviBarHeight - EYTabBarHeight) collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor blueColor];
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([EYLikeCell class]) bundle:nil] forCellWithReuseIdentifier:EYLikeViewControllerCollectionViewCellID];
        [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:EYLikeViewControllerCollectionViewHeadViewID];
        collectionView.pagingEnabled = YES;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [self.view addSubview:collectionView];
        self.collectionView = collectionView;
    }
    return _collectionView;
}

- (NSMutableArray *)sourceArrayM {
    if (nil == _sourceArrayM) {
        _sourceArrayM = [NSMutableArray arrayWithObjects:@"1", @"2", nil];
    }
    return _sourceArrayM;
}

@end
