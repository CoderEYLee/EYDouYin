//
//  EYMineViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/6/18.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYMineViewController.h"
#import "EYMineCell.h"
#import "EYMeViewController.h"
#import "EYPhotoModel.h"

//tableHeaderView
@class EYMineViewControllerHeaderView;

@protocol EYMineViewControllerHeaderViewDelegate<NSObject>
@optional
- (void)mineViewControllerHeaderViewDidTapHeaderButton:(EYMineViewControllerHeaderView *)view jumpType:(EYJumpType)jumpType;

@end

@interface EYMineViewControllerHeaderView : UIView

@property (weak, nonatomic) id <EYMineViewControllerHeaderViewDelegate> delegate;

@end

@implementation EYMineViewControllerHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat height = frame.size.height;
        self.backgroundColor = EYColorClear;
        UIButton *headerButton = [[UIButton alloc] initWithFrame:CGRectMake(20, height - 20, 110, 110)];
        headerButton.backgroundColor = EYColorClear;
        headerButton.layer.cornerRadius = 55.0;
        [headerButton addTarget:self action:@selector(tapHeaderButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:headerButton];
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)tapHeaderButton:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(mineViewControllerHeaderViewDidTapHeaderButton:jumpType:)]) {
        [self.delegate mineViewControllerHeaderViewDidTapHeaderButton:self jumpType:EYJumpTypeMineUserHeaderButton];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(mineViewControllerHeaderViewDidTapHeaderButton:jumpType:)]) {
        [self.delegate mineViewControllerHeaderViewDidTapHeaderButton:self jumpType:EYJumpTypeMineUserBackImageButton];
    }
}

@end

typedef NS_ENUM(NSUInteger, NYTViewControllerPhotoIndex) {
    NYTViewControllerPhotoIndexCustomEverything = 1,
    NYTViewControllerPhotoIndexLongCaption = 2,
    NYTViewControllerPhotoIndexDefaultLoadingSpinner = 3,
    NYTViewControllerPhotoIndexNoReferenceView = 4,
    NYTViewControllerPhotoIndexCustomMaxZoomScale = 5,
    NYTViewControllerPhotoIndexGif = 6,
    NYTViewControllerPhotoCount,
};

@interface EYMineViewController() <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, EYMineCellDelegate, EYMineViewControllerHeaderViewDelegate, NYTPhotosViewControllerDelegate>

@property (nonatomic) NYTPhotoViewerArrayDataSource *dataSource;

@property (nonatomic, weak) UIImageView *backImageView;

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrayM;

// 根据 user_id 获取的用户信息
@property (strong, nonatomic) EYUserModel *userModel;

@end

@implementation EYMineViewController
//背景图的真正高度
const CGFloat EYBackImageViewRealHeight = 310;
//背景图的开始显示比例 0.4
const CGFloat EYBackImageViewBeginHeight = EYBackImageViewRealHeight * 0.45;
static NSString *EYMineViewControllerCellID = @"EYMineViewControllerCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 初始化界面
    [self setupUI];
}

//1. 初始化界面
- (void)setupUI {
    //1.隐藏导航
    self.gk_navigationBar.hidden = YES;
    
    //1.1 右侧设置按钮
    CGFloat buttonWH = 30.0;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(EYScreenWidth - 50, EYStatusBarHeight + (44 - buttonWH) * 0.5, buttonWH, buttonWH)];
    [button addTarget:self action:@selector(tapSettingButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"mine_setting"] forState:UIControlStateNormal];
    button.backgroundColor = EYColorRGBHex(0x4C4D51);
    button.layer.cornerRadius = 15.0;
    [self.view addSubview:button];
    
    if (self.jumpType == EYJumpTypeDefault) {//自己的界面
        //4.底部 view
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, EYScreenHeight - EYTabBarHomeIndicatorHeight, EYScreenWidth, EYTabBarHomeIndicatorHeight)];
        bottomView.backgroundColor = EYColorBlack;
        [self.view addSubview:bottomView];
    } else {
        
    }
    
    //2.背景图片(放大)
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, EYScreenWidth, EYBackImageViewRealHeight)];
    backImageView.image = [UIImage imageNamed:@"common_placeholder_mine"];
    backImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view insertSubview:backImageView atIndex:0];
    self.backImageView = backImageView;
    
    //3.UITableView
    CGFloat tableViewHeight = EYScreenHeight;
    if (self.jumpType == EYJumpTypeDefault) {
        tableViewHeight -= EYTabBarHomeIndicatorHeight;
    }
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, EYScreenWidth, tableViewHeight) style:UITableViewStylePlain];
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.dataSource = self;
    tableView.delegate = self;
    //背景颜色
    tableView.backgroundColor = EYColorClear;
    //取消分割线
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 100;
    [tableView registerClass:[EYMineCell class] forCellReuseIdentifier:EYMineViewControllerCellID];
    // 设置偏移量为0
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //tableHeaderView
    EYMineViewControllerHeaderView *headerView = [[EYMineViewControllerHeaderView alloc] initWithFrame:CGRectMake(0, 0, EYScreenWidth, EYBackImageViewBeginHeight)];
    headerView.delegate = self;
    tableView.tableHeaderView = headerView;
    [self.view insertSubview:tableView aboveSubview:backImageView];
    self.tableView = tableView;
}

#pragma mark - Private Methods
- (void)tapSettingButton:(UIButton *)button {
    EYMeViewController *vc = [[EYMeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EYMineCell *cell = [tableView dequeueReusableCellWithIdentifier:EYMineViewControllerCellID];
    cell.userModel = self.userModel;
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EYLog(@"12345678943==%ld", indexPath.row);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //偏移量
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    
    // 1.背景图放大效果(距离屏幕顶部的距离)
    CGFloat distance = -contentOffsetY;
//    EYLog(@"00000000000==%f", distance);//距离屏幕顶部的距离
    
    if (distance <= -EYBackImageViewBeginHeight) {//顶部视图完全遮住了
        self.backImageView.frame = CGRectMake(0, -EYBackImageViewBeginHeight * 0.5, EYScreenWidth, EYBackImageViewRealHeight);
    } else if (distance <= 0) {//顶部视图未完全展示
         self.backImageView.frame = CGRectMake(0, distance * 0.5, EYScreenWidth, EYBackImageViewRealHeight);
    } else if (distance >= EYBackImageViewRealHeight - EYBackImageViewBeginHeight) {//向下拽的最大位置
        scrollView.contentOffset = CGPointMake(0, -(EYBackImageViewRealHeight - EYBackImageViewBeginHeight));
        CGFloat scale = 1.2;
        self.backImageView.frame = CGRectMake(EYScreenWidth * 0.5 * (1 - scale), 0, EYScreenWidth * scale, EYBackImageViewRealHeight * scale);
    } else {//需要放大图片
        CGFloat scale = 1.0 + 0.2 * (distance) / (EYBackImageViewRealHeight - EYBackImageViewBeginHeight);
        self.backImageView.frame = CGRectMake(EYScreenWidth * 0.5 * (1 - scale), 0, EYScreenWidth * scale, EYBackImageViewRealHeight * scale);
    }
    
//    //2.导航栏的颜色变化
//    if (contentOffsetY < beginOffSetY) {//0
//        EYLog(@"111111111111");
//        self.gk_navBarAlpha = 0.0;
//    } else if (contentOffsetY >= 100 && contentOffsetY <= 200) {
//        EYLog(@"222222222222");
//        self.gk_navBarAlpha = 0.5;
//    } else {//1
//        EYLog(@"333333333333");
//        self.gk_navBarAlpha = 1.0;
//    }
}

#pragma mark - EYMineCellDelegate
- (void)mineCell:(EYMineCell *)cell didSelectedButton:(EYJumpType)jumpTpye {
    EYLog(@"cell--delegate 回调==%@==%lu", cell, jumpTpye);
}

#pragma mark - EYMineViewControllerHeaderViewDelegate
- (void)mineViewControllerHeaderViewDidTapHeaderButton:(EYMineViewControllerHeaderView *)view jumpType:(EYJumpType)jumpTpye {
    EYLog(@"headerView--delegate 回调==%@==%lu", view, jumpTpye);
    
    switch (jumpTpye) {
        case EYJumpTypeMineUserBackImageButton: {//用户背景图片按钮
            EYLog(@"更换背景图片");
            [EYProgressHUD showInfoWithStatus:@"更换背景图片"];
            
            self.dataSource = [self.class newTimesBuildingDataSource];
            
            EYLog(@"1231 %@", self.dataSource);
            
            NYTPhotosViewController *photosViewController = [[NYTPhotosViewController alloc] initWithDataSource:self.dataSource initialPhoto:nil delegate:self];
            
            [self presentViewController:photosViewController animated:YES completion:nil];
            
            [self updateImagesOnPhotosViewController:photosViewController afterDelayWithDataSource:self.dataSource];
            
            BOOL demonstrateDataSourceSwitchAfterTenSeconds = YES;
            if (demonstrateDataSourceSwitchAfterTenSeconds) {
                [self switchDataSourceOnPhotosViewController:photosViewController afterDelayWithDataSource:self.dataSource];
            }
            
            break;
        }
        case EYJumpTypeMineUserHeaderButton: {//用户头像按钮
            EYLog(@"更换用户头像");
            [EYProgressHUD showInfoWithStatus:@"更换用户头像"];
            break;
        }
            
        default:
            break;
    }
}

- (void)updateImagesOnPhotosViewController:(NYTPhotosViewController *)photosViewController afterDelayWithDataSource:(NYTPhotoViewerArrayDataSource *)dataSource {
    if (dataSource != self.dataSource) {
        return;
    }
    
    CGFloat updateImageDelay = 5.0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(updateImageDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (EYPhotoModel *photo in dataSource.photos) {
            if (!photo.image && !photo.imageData) {
                photo.image = [UIImage imageNamed:@"NYTimesBuilding"];
                photo.attributedCaptionSummary = [[NSAttributedString alloc] initWithString:@"Photo which previously had a loading spinner (to see the spinner, reopen the photo viewer and scroll to this photo)" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody]}];
                [photosViewController updatePhoto:photo];
                EYLog(@"1232 %@", self.dataSource);
            }
        }
    });
}

// This method simulates completely swapping out the data source, after 10 seconds.
- (void)switchDataSourceOnPhotosViewController:(NYTPhotosViewController *)photosViewController afterDelayWithDataSource:(NYTPhotoViewerArrayDataSource *)dataSource {
    if (dataSource != self.dataSource) {
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        EYPhotoModel *photoWithLongCaption = (EYPhotoModel *)dataSource[NYTViewControllerPhotoIndexLongCaption];
        photosViewController.delegate = nil; // delegate methods in this VC are intended for use with the TimesBuildingDataSource
        self.dataSource = [self.class newVariedDataSourceIncludingPhoto:photoWithLongCaption];
        photosViewController.dataSource = self.dataSource;
        EYLog(@"1233 %@", self.dataSource);
        [photosViewController reloadPhotosAnimated:YES];
    });
}

/// A second set of test photos, to demonstrate reloading the entire data source.
+ (NYTPhotoViewerArrayDataSource *)newVariedDataSourceIncludingPhoto:(EYPhotoModel *)photo {
    NSMutableArray *photos = [NSMutableArray array];
    
    [photos addObject:({
        EYPhotoModel *p = [EYPhotoModel new];
        p.image = [UIImage imageNamed:@"Chess"];
        p.attributedCaptionTitle = [self attributedTitleFromString:@"Chess"];
        p.attributedCaptionCredit = [self attributedCreditFromString:@"Photo: Chris Dzombak"];
        p;
    })];
    
    [photos addObject:({
        EYPhotoModel *p = photo;
        photo.attributedCaptionTitle = nil;
        p.attributedCaptionSummary = [self attributedSummaryFromString:@"This photo’s caption has changed in the data source."];
        p;
    })];
    
    return [NYTPhotoViewerArrayDataSource dataSourceWithPhotos:photos];
}

#pragma mark - NYTPhotosViewControllerDelegate
- (void)photosViewControllerWillDismiss:(NYTPhotosViewController *)photosViewController {
    EYLog(@"photosViewControllerWillDismiss");
}

#pragma mark - Sample Data Sources

+ (NYTPhotoViewerArrayDataSource *)newTimesBuildingDataSource {
    NSMutableArray *photos = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < 7; i++) {
        EYPhotoModel *photo = [EYPhotoModel new];
        
        if (i == NYTViewControllerPhotoIndexGif) {
            photo.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"giphy" ofType:@"gif"]];
        } else if (i == NYTViewControllerPhotoIndexCustomEverything || i == NYTViewControllerPhotoIndexDefaultLoadingSpinner) {
            // no-op, left here for clarity:
            photo.image = [UIImage imageNamed:@""];
        } else {
            photo.image = [UIImage imageNamed:@"NYTimesBuilding"];
        }
        
        if (i == NYTViewControllerPhotoIndexCustomEverything) {
            photo.placeholderImage = [UIImage imageNamed:@"NYTimesBuildingPlaceholder"];
        }
        
        NSString *caption = @"<photo summary>";
        switch ((NYTViewControllerPhotoIndex)i) {
            case NYTViewControllerPhotoIndexCustomEverything:
                caption = @"Photo with custom everything";
                break;
            case NYTViewControllerPhotoIndexLongCaption:
                caption = @"Photo with long caption.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum maximus laoreet vehicula. Maecenas elit quam, pellentesque at tempor vel, tempus non sem. Vestibulum ut aliquam elit. Vivamus rhoncus sapien turpis, at feugiat augue luctus id. Nulla mi urna, viverra sed augue malesuada, bibendum bibendum massa. Cras urna nibh, lacinia vitae feugiat eu, consectetur a tellus. Morbi venenatis nunc sit amet varius pretium. Duis eget sem nec nulla lobortis finibus. Nullam pulvinar gravida est eget tristique. Curabitur faucibus nisl eu diam ullamcorper, at pharetra eros dictum. Suspendisse nibh urna, ultrices a augue a, euismod mattis felis. Ut varius tortor ac efficitur pellentesque. Mauris sit amet rhoncus dolor. Proin vel porttitor mi. Pellentesque lobortis interdum turpis, vitae tincidunt purus vestibulum vel. Phasellus tincidunt vel mi sit amet congue.";
                break;
            case NYTViewControllerPhotoIndexDefaultLoadingSpinner:
                caption = @"Photo with loading spinner";
                break;
            case NYTViewControllerPhotoIndexNoReferenceView:
                caption = @"Photo without reference view";
                break;
            case NYTViewControllerPhotoIndexCustomMaxZoomScale:
                caption = @"Photo with custom maximum zoom scale";
                break;
            case NYTViewControllerPhotoIndexGif:
                caption = @"Animated GIF";
                break;
            case NYTViewControllerPhotoCount:
                // this case statement intentionally left blank.
                break;
        }
        
        photo.attributedCaptionTitle = [self attributedTitleFromString:@(i + 1).stringValue];
        photo.attributedCaptionSummary = [self attributedSummaryFromString:caption];
        
        if (i != NYTViewControllerPhotoIndexGif) {
            photo.attributedCaptionCredit = [self attributedCreditFromString:@"Photo: Nic Lehoux"];
        }
        
        [photos addObject:photo];
    }
    
    return [NYTPhotoViewerArrayDataSource dataSourceWithPhotos:photos];
}

+ (NSAttributedString *)attributedTitleFromString:(NSString *)caption {
    return [[NSAttributedString alloc] initWithString:caption attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody]}];
}

+ (NSAttributedString *)attributedSummaryFromString:(NSString *)summary {
    return [[NSAttributedString alloc] initWithString:summary attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor], NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody]}];
}

+ (NSAttributedString *)attributedCreditFromString:(NSString *)credit {
    return [[NSAttributedString alloc] initWithString:credit attributes:@{NSForegroundColorAttributeName: [UIColor grayColor], NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]}];
}


#pragma mark - 懒加载
- (NSMutableArray *)arrayM {
    if (nil == _arrayM) {
        _arrayM = [NSMutableArray array];
        [_arrayM addObject:@"1"];
        [_arrayM addObject:@"2"];
    }
    return _arrayM;
}

@end
