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

@interface EYMineViewController() <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, EYMineCellDelegate, EYMineViewControllerHeaderViewDelegate>

@property (nonatomic, weak) UIImageView *backImageView;
@property (nonatomic, weak) EYMineCell *mineInfoCell;

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrayM;

// 根据 user_id 获取的用户信息
@property (strong, nonatomic) EYUserModel *userModel;

@end

@implementation EYMineViewController
//背景图的真正高度
const CGFloat EYBackImageViewRealHeight = 310;
//背景图的开始显示的高度
const CGFloat EYBackImageViewBeginHeight = EYBackImageViewRealHeight * 0.45;
//个人信息的 cell 的高度
const CGFloat EYPersonInfoCellHeight = 300;
static NSString *EYMineViewControllerCellID = @"EYMineViewControllerCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 初始化界面
    [self setupUI];
}

//1. 初始化界面
- (void)setupUI {
    if (self.jumpType == EYJumpTypeDefault) {//自己的界面
        //1.1 右侧设置按钮
        CGFloat buttonWH = 30.0;
        UIButton *settingButton = [[UIButton alloc] initWithFrame:CGRectMake(EYScreenWidth - 50, EYStatusBarHeight + (44 - buttonWH) * 0.5, buttonWH, buttonWH)];
        [settingButton addTarget:self action:@selector(tapSettingButton:) forControlEvents:UIControlEventTouchUpInside];
        [settingButton setImage:[UIImage imageNamed:@"mine_setting"] forState:UIControlStateNormal];
        settingButton.backgroundColor = EYColorRGBHex(0x4C4D51);
        settingButton.layer.cornerRadius = 15.0;
        [self.view addSubview:settingButton];
        
        //底部 view
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, EYScreenHeight - EYTabBarHomeIndicatorHeight, EYScreenWidth, EYTabBarHomeIndicatorHeight)];
        bottomView.backgroundColor = EYColorBlack;
        [self.view addSubview:bottomView];
        
        //隐藏导航
        self.gk_navigationBar.hidden = YES;
    } else {//其他渠道进入
        if ([[EYManager manager].userModel.user_id isEqualToString:self.user_id] == NO) {
            self.gk_navRightBarButtonItem = [UIBarButtonItem itemWithImageName:@"common_arrow_right" target:self action:@selector(tapMoreButton:)];
        }
        
        self.gk_navTitle = self.user_id;
        self.gk_navTintColor = EYColorRGBHexAlpha(0xFFFFFF, 0.0);
        self.gk_navLineHidden = YES;
        
        //显示导航
        self.gk_navigationBar.hidden = NO;
    }
    
    //2.背景图片(放大)
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, EYScreenWidth, EYBackImageViewRealHeight)];
    backImageView.image = [UIImage imageNamed:@"common_placeholder_mine"];
    backImageView.layer.masksToBounds = YES;
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
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

- (void)tapMoreButton:(UIButton *)button {
    EYTestViewController *vc = [[EYTestViewController alloc] init];
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
    if (indexPath.row == 0) {//个人信息
        self.mineInfoCell = cell;
    } else {
        
    }
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
    
    //2.导航栏的颜色变化
    CGFloat beginAlphaHeight = EYPersonInfoCellHeight - 100;
    if (contentOffsetY < beginAlphaHeight) {//0.0
        self.mineInfoCell.alphaLabel.alpha = 0.0;
    } else if (contentOffsetY >= beginAlphaHeight && contentOffsetY <= EYPersonInfoCellHeight) {
        CGFloat scale = (contentOffsetY - beginAlphaHeight) / 100.0;
        self.mineInfoCell.alphaLabel.alpha = scale;
    } else {//1.0
        self.mineInfoCell.alphaLabel.alpha = 1.0;
    }
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
