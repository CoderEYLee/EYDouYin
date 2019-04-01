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
#import "EYHomeVideoView.h"
#import "EYHomeVideoModel.h"
#import "EYHomeCityViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AppDelegate.h"
#import "EYHomeBackView.h"
#import "EYHomeBackItemModel.h"

@interface EYHomeViewController () <EYHomeTitleViewDelegate, EYHomeBackViewDelegate, UIScrollViewDelegate>

@property (assign, nonatomic, readwrite) EYHomeViewControllerButtonType type;

// 后面的背景 view
@property (weak, nonatomic) EYHomeBackView *backView;

// 主页的滚动视图
@property (weak, nonatomic) UIScrollView *scrollView;

// 上滑的 view, 用来恢复 scrollView 的位置
@property (weak, nonatomic) UIView *upSwipeView;

// 3个 view 视图
@property (strong, nonatomic) NSMutableArray <EYHomeVideoView *> *videoViewArrayM;
// 数据数组
@property (strong, nonatomic) NSMutableArray <EYHomeVideoModel *>*videoModelArrayM;

// 同城
@property (weak, nonatomic) UIView *homeCityView;

@property (strong, nonatomic) NSMutableArray *modelArrayM;

// 当前视频控件的下标
@property (assign, nonatomic) NSUInteger currentVideoIndex;

@end

@implementation EYHomeViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];

    // 模拟网络数据
    [self loadNetData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (EYSCREENSIZE_IS_IPhoneX_All) {
        [UIApplication sharedApplication].statusBarHidden = NO;
    } else {
        [UIApplication sharedApplication].statusBarHidden = YES;
    }

    //开始播放第0个
//    EYHomeVideoView *videoView = self.videoViewArrayM.firstObject;
//    videoView.videoModel = self.videoModelArrayM.firstObject;
//    [videoView playVideo];
}

- (void)setupUI {
    [self.view clipsCornerRadius:UIRectCornerAllCorners cornerRadii:5.0];
    [self.view addSubview:[self getSystemVolumSlider]];

    self.view.backgroundColor = [UIColor blackColor];
    // 1.底层的 view
    EYHomeBackView *backView = [EYHomeBackView homeBackView];
    backView.frame = CGRectMake(0, 0, EYScreenWidth, EYBackViewHeight);
    backView.delegate = self;
    backView.backgroundColor = [UIColor blackColor];
    [self.view insertSubview:backView atIndex:0];
    self.backView = backView;

    self.naviBar.hidden = NO;
    // 2.titleView
    EYHomeTitleView * titleView = [EYHomeTitleView homeTitleView];
    titleView.delegate = self;
    [self.naviBar addSubview:titleView];

    // 3.scrollView
    self.scrollView.hidden = NO;

    // 4.同城 view
    self.homeCityView.hidden = YES;
}

- (void)loadNetData {
    NSString *jsonName = @"Items.json";
    NSArray *jsonArray = jsonName.ey_loadLocalJSONFile;

    if (jsonArray.count < 3) {
        return;
    }

//    self.currentVideoIndex = 0;
//    self.videoModelArrayM = [EYHomeVideoModel mj_objectArrayWithKeyValuesArray:jsonArray];
}

#pragma mark - Private Methods


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - EYHomeTitleViewDelegate
- (void)homeTitleView:(EYHomeTitleView *)view didSelectedButton:(EYHomeTitleViewButtonType)buttonType {
    switch (buttonType) {
        case EYHomeTitleViewButtonTypeSearch: {
            [self search];
            break;
        }case EYHomeTitleViewButtonTypeMore: {
            [self more];
            break;
        }case EYHomeTitleViewButtonTypeRecommend: {
            [self recommend];
            break;
        }case EYHomeTitleViewButtonTypeCity: {
            [self city];
            break;
        }
        default:
            break;
    }
}


//搜索
- (void)search {
    EYLog(@"搜索");
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.rootViewController.scrollView setContentOffset:CGPointZero animated:YES];
}

//推荐
- (void)recommend {
    EYLog(@"推荐");
    self.scrollView.hidden = NO;
    self.homeCityView.hidden = YES;
    self.type = EYHomeViewControllerButtonTypeRecommend;
    [self changTabbarBackgroundColor:[UIColor clearColor]];
}

//城市
- (void)city {
    EYLog(@"同城");
    self.scrollView.hidden = YES;
    self.homeCityView.hidden = NO;
    self.type = EYHomeViewControllerButtonTypeCity;
    [self changTabbarBackgroundColor:[UIColor blackColor]];
}

- (void)changTabbarBackgroundColor:(UIColor *)color {
    [EYNotificationCenter postNotificationName:EYTabbarShouldChangeColorNotification object:nil userInfo:@{@"color" : color}];
}

//更多
- (void)more {
    CGFloat naviBarY = self.naviBar.mj_y;
    EYLog(@"更多");
    if (naviBarY == EYStatusBarHeight) {// scrollView向下滚动
        [self changeFrameWithPOP:self.naviBar offsetY:EYBackViewHeight];
        [self changeFrameWithPOP:self.scrollView offsetY:EYBackViewHeight];
        self.upSwipeView.hidden = NO;
        for (EYHomeVideoView *view in self.videoViewArrayM) {
            view.homeInfoView.hidden = YES;
            view.homeSharedView.hidden = YES;
        }

        [self.backView showWithArray:self.modelArrayM];
    } else {// scrollView恢复原始位置
        [self changeFrameWithPOP:self.naviBar offsetY:-EYBackViewHeight];
        [self changeFrameWithPOP:self.scrollView offsetY:-EYBackViewHeight];
        self.upSwipeView.hidden = YES;
        for (EYHomeVideoView *view in self.videoViewArrayM) {
            view.homeInfoView.hidden = NO;
            view.homeSharedView.hidden = NO;
        }
        [self.backView close];
    }
}

//动画
- (void)changeFrameWithPOP:(UIView *)view offsetY:(CGFloat)y {
    POPBasicAnimation * anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.fromValue = @(view.centerY);
    anim.toValue = @(view.centerY + y);
    anim.duration = 0.5;
    [view pop_addAnimation:anim forKey:nil];
}

#pragma mark - EYHomeBackViewDelegate
- (void)homeBackViewDidSelectedModel:(EYHomeBackItemModel *)model {
    EYLog(@"----1111--%@-", model);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    EYLog(@"scrollView滚动到顶部了");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat index = scrollView.contentOffset.y / EYScreenHeight;
    CGFloat width = scrollView.width;
    CGFloat height = scrollView.height;

    CGFloat y = [scrollView.panGestureRecognizer translationInView:scrollView.superview].y;
    if (y < 0) {//向上滚动(下一个)
//        EYLog(@"scrollView滚动了(下一个)");
    } else {//向下滚动(上一个)
//        EYLog(@"scrollView滚动了(上一个)");
    }

    if (index == self.videoViewArrayM.count - 1) {// 最后一个
        [self.videoViewArrayM insertObject:self.videoViewArrayM.firstObject atIndex:self.videoViewArrayM.count];
        [self.videoViewArrayM removeFirstObject];

        for (int i = 0; i < self.videoViewArrayM.count; i++) {
            EYHomeVideoView *itemView = self.videoViewArrayM[i];
            itemView.frame = CGRectMake(0, height * i, width, height);
        }
        scrollView.contentOffset = CGPointMake(0, height);
    }

    if (index == 0.0) {
        [self.videoViewArrayM insertObject:self.videoViewArrayM.lastObject atIndex:0];
        [self.videoViewArrayM removeLastObject];

        for (int i = 0; i < self.videoViewArrayM.count; i++) {
            EYHomeVideoView *itemView = self.videoViewArrayM[i];
            itemView.frame = CGRectMake(0, height * i, width, height);
        }
        scrollView.contentOffset = CGPointMake(0, height);
    }
    //    EYLog(@"scrollView滚动了==%f", scrollView.contentOffset.y);




}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView  {// 开始拖拽
    EYLog(@"111111111111111");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {// 结束拖拽
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {//结束拖拽后立即开始减速
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {// 滚动停止了
//    int index = scrollView.contentOffset.y / EYScreenHeight;
//    CGFloat contentOffY = scrollView.contentOffset.y;
    // EYLog(@"scrollView已经结束减速:%d--位置为:%f", index, scrollView.contentOffset.y);

//    CGFloat y = [scrollView.panGestureRecognizer translationInView:scrollView.superview].y;
//
//    if (y < 0) {//向上滚动
//        self.currentVideoIndex++;
//
//    } else {//向下滚动
//        if (self.currentVideoIndex) {
//            self.currentVideoIndex--;
//        }
//    }
//
//    EYLog(@"当前的index--%ld", self.currentVideoIndex);
//
//    EYHomeVideoView *videoView = self.videoViewArrayM[self.currentVideoIndex % 3];
//    videoView.indexLabel.text = [NSString stringWithFormat:@"%lu", self.currentVideoIndex];
////    videoView.videoModel = self.videoModelArrayM[self.currentVideoIndex];
////    [videoView playVideo];
//
//    if (self.currentVideoIndex + 1 >= self.videoModelArrayM.count) {
//        EYLog(@"可以请求下一组啦啦啦");
//        NSString *jsonName = @"Items.json";
//        NSArray *jsonArray = jsonName.ey_loadLocalJSONFile;
//
//        [self.videoModelArrayM addObjectsFromArray:[EYHomeVideoModel mj_objectArrayWithKeyValuesArray:jsonArray]];
//    }
//
//    if (self.currentVideoIndex <= 0) {
//        EYLog(@"可以请求最新的一组哈哈哈");
//        NSString *jsonName = @"Items.json";
//        NSArray *jsonArray = jsonName.ey_loadLocalJSONFile;
//
//        self.currentVideoIndex = 0;
//        NSMutableArray *array = [EYHomeVideoModel mj_objectArrayWithKeyValuesArray:jsonArray];
//        [self.videoModelArrayM insertObjects:array atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, array.count)]];
//    }
//

//    CGFloat width = self.scrollView.width;
//    CGFloat height = self.scrollView.height;
//    if (y < 0 && index == self.videoViewArrayM.count - 1) {// 最后一个
//        [self.videoViewArrayM insertObject:self.videoViewArrayM.firstObject atIndex:self.videoViewArrayM.count];
//        [self.videoViewArrayM removeFirstObject];
//
//        for (int i = 0; i < self.videoViewArrayM.count; i++) {
//            EYHomeVideoView *itemView = self.videoViewArrayM[i];
//            itemView.frame = CGRectMake(0, height * i, width, height);
//        }
//        [scrollView setContentOffset:CGPointMake(0, height) animated:NO];
//    }
//
//    if (y > 0 && index == 0) {
//        [self.videoViewArrayM insertObject:self.videoViewArrayM.lastObject atIndex:0];
//        [self.videoViewArrayM removeLastObject];
//
//        for (int i = 0; i < self.videoViewArrayM.count; i++) {
//            EYHomeVideoView *itemView = self.videoViewArrayM[i];
//            itemView.frame = CGRectMake(0, height * i, width, height);
//        }
//        [scrollView setContentOffset:CGPointMake(0, height) animated:NO];
//    }
}

#pragma mark - 懒加载
- (NSMutableArray *)videoModelArrayM {
    if (nil == _videoModelArrayM) {
        _videoModelArrayM = [NSMutableArray array];
    }
    return _videoModelArrayM;
}

- (NSMutableArray *)videoViewArrayM {
    if (nil == _videoViewArrayM) {
        _videoViewArrayM = [NSMutableArray array];
    }
    return _videoViewArrayM;
}

- (UIScrollView *)scrollView {
    if (nil == _scrollView) {
        CGFloat width = EYScreenWidth;
        CGFloat height = 0;
        if (EYSCREENSIZE_IS_IPhoneX_All) {
            height = EYScreenHeight -EYTabBarHeight - EYHomeIndicatorHeight;
        } else {
            height = EYScreenHeight;
        }
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        scrollView.layer.cornerRadius = 5.0;
        scrollView.contentSize = CGSizeMake(width, height * 3);
        if (@available(iOS 11.0, *)) {
            scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        [self.view insertSubview:scrollView belowSubview:self.naviBar];

        for (int i = 0; i < 3; i++) {
            EYHomeVideoView *videoView = [EYHomeVideoView homeItemView];
            videoView.frame = CGRectMake(0, height * i, width, height);
            if (i == 0) {
                videoView.backgroundColor = [UIColor redColor];
            } else if (i == 1) {
                videoView.backgroundColor = [UIColor greenColor];
            } else {
                videoView.backgroundColor = [UIColor blueColor];
            }
            [scrollView addSubview:videoView];
            [self.videoViewArrayM addObject:videoView];
        }
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (UIView *)upSwipeView {
    if (nil == _upSwipeView) {
        // 创建蒙层view
        UIView * swipeView = [[UIView alloc] initWithFrame:CGRectMake(0, EYBackViewHeight, EYScreenWidth, EYScreenHeight - EYBackViewHeight - EYTabBarHeight)];
        swipeView.backgroundColor = [UIColor clearColor];
        [self.view insertSubview:swipeView belowSubview:self.naviBar];
        _upSwipeView = swipeView;

        // 滑动手势
        UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(more)];
        upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
        [swipeView addGestureRecognizer:upSwipe];
    }
    return _upSwipeView;
}

- (UIView *)homeCityView {
    if (nil == _homeCityView) {
        EYHomeCityViewController *homeCityViewController = [[EYHomeCityViewController alloc] init];
        UIView *homeCityView = homeCityViewController.view;
        [self.view insertSubview:homeCityView belowSubview:self.naviBar];
        _homeCityView = homeCityView;
        [self addChildViewController:homeCityViewController];
    }
    return _homeCityView;
}

- (NSMutableArray *)modelArrayM {
    if (nil == _modelArrayM) {
        _modelArrayM = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            EYHomeBackItemModel * model = [[EYHomeBackItemModel alloc] init];
            [_modelArrayM addObject:model];
        }
    }
    return _modelArrayM;
}

#pragma mark - 音量控制
/*
 * 获取系统音量滑块
 */
- (UIView *)getSystemVolumSlider{
    UIView * view = nil;
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    for (UIView *newView in volumeView.subviews) {
        if ([newView.class.description isEqualToString:@"MPVolumeSlider"]){
            newView.frame = CGRectMake(-300, -300, 1, 1);
            view = newView;
            break;
        }
    }
    return view;
}

@end
