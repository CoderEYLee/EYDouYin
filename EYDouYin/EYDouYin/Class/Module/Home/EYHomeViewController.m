//
//  EYHomeViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/23.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYHomeViewController.h"
#import "EYHomeCityViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "EYHomePlayViewController.h"
#import "EYVideoModel.h"

@interface EYHomeViewController () <UIScrollViewDelegate>

// 滚动视图
@property (weak, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) NSMutableArray <EYVideoModel *>*arrarM;

// 当前播放的下标
@property (assign, nonatomic) NSUInteger currentVideoIndex;

@end

@implementation EYHomeViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //0.当前播放下标
    self.currentVideoIndex = 0;
    
    //1.初始化界面
    [self setupUI];
    
    //2.模拟网络数据
    [self loadNetData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

//1.初始化界面
- (void)setupUI {
    //1.隐藏导航
    self.gk_navigationBar.hidden = YES;
    //    self.gk_navigationBar.backgroundColor = EYColorRed;
    //    [self.view clipsCornerRadius:UIRectCornerAllCorners cornerRadii:5.0];
    
    //2.添加系统声音控件
    [self.view addSubview:[self getSystemVolumSlider]];
    
    //3.底层颜色
    self.view.backgroundColor = EYColorBlack;
    
    //4.滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:EYScreenBounds];
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(EYScreenWidth, EYScreenHeight * 3);
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    //4.1 上
    EYHomePlayViewController *topVC = [[EYHomePlayViewController alloc] init];
    topVC.name = @"上";
    [self addChildViewController:topVC];
    topVC.view.frame = EYScreenBounds;
    topVC.view.backgroundColor = EYColorRed;
    [scrollView addSubview:topVC.view];
    
    //4.1 中
    EYHomePlayViewController *centerVC = [[EYHomePlayViewController alloc] init];
    centerVC.name = @"中";
    [self addChildViewController:centerVC];
    centerVC.view.frame = CGRectMake(0, EYScreenHeight, EYScreenWidth, EYScreenHeight);
    centerVC.view.backgroundColor = EYColorGreen;
    [scrollView addSubview:centerVC.view];
    
    //4.1 下
    EYHomePlayViewController *bottomVC = [[EYHomePlayViewController alloc] init];
    bottomVC.name = @"下";
    [self addChildViewController:bottomVC];
    bottomVC.view.frame = CGRectMake(0, EYScreenHeight * 2, EYScreenWidth, EYScreenHeight);
    bottomVC.view.backgroundColor = EYColorBlue;
    [scrollView addSubview:bottomVC.view];
}

//2.请求网络数据
- (void)loadNetData {
    
    NSMutableArray *array = [EYVideoModel mj_objectArrayWithFilename:@"EYVideoArray.plist"];
    
    if (array.count < 3) {
        return;
    }
    
    [self.arrarM addObjectsFromArray:[array subarrayWithRange:NSMakeRange(0, 12)]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //开始播放第0个
        //        EYHomePlayViewController *topVC = self.childViewControllers.firstObject;
        //        [topVC startPlayWithURLString:self.arrarM.firstObject.tt_video_name];
    });
}

#pragma mark - Private Methods

//动画
- (void)changeFrameWithPOP:(UIView *)view offsetY:(CGFloat)y {
    POPBasicAnimation * anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.fromValue = @(view.centerY);
    anim.toValue = @(view.centerY + y);
    anim.duration = 0.5;
    [view pop_addAnimation:anim forKey:nil];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    EYLog(@"scrollView滚动到顶部了");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.arrarM.count <= 3) {//小于等于3个不做处理
        return;
    }
    
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    
    // 第一个
    if (self.currentVideoIndex == 0 && contentOffsetY <= EYScreenHeight) {
        EYLog(@"第一个");
        return;
    }
    
    // 最后两个
    if (self.currentVideoIndex == self.arrarM.count - 1 && contentOffsetY > EYScreenHeight) {
        EYLog(@"最后两个");
        return;
    }
//    CGFloat index = contentOffsetY / EYScreenHeight;
//    EYLog(@"======%f==%f", contentOffsetY, index);
    
    if (contentOffsetY >= 2 * EYScreenHeight) {//下一个视频
        //        [self.videoPlayer removeVideo];
        if (self.currentVideoIndex == 0) {//第一次向下翻动 下标从 0->2
            self.currentVideoIndex += 2;
        } else {//继续向下翻动
            self.currentVideoIndex++;
            if (self.currentVideoIndex == self.arrarM.count - 1) {//最后一个
                EYLog(@"最后一个**%lu**", self.currentVideoIndex);
                return;
            }
        }
        
        //1.修改位置
        EYHomePlayViewController *toptopVC =  self.childViewControllers.firstObject;
        EYHomePlayViewController *centerVC =  self.childViewControllers[1];
        EYHomePlayViewController *bottomVC =  self.childViewControllers.lastObject;
        if (toptopVC.view.mj_y == 0) {// 上(中)下 -> 中(下)上
            centerVC.view.mj_y = 0;
            bottomVC.view.mj_y = EYScreenHeight;
            toptopVC.view.mj_y = EYScreenHeight * 2;
        } else if (toptopVC.view.mj_y == EYScreenHeight) {// 下(上)中 -> 上(中)下
            toptopVC.view.mj_y = 0;
            centerVC.view.mj_y = EYScreenHeight;
            bottomVC.view.mj_y = EYScreenHeight * 2;
        } else {// 中(下)上 -> 下(上)中
            bottomVC.view.mj_y = 0;
            toptopVC.view.mj_y = EYScreenHeight;
            centerVC.view.mj_y = EYScreenHeight * 2;
        }
        //2.滚动位置
        scrollView.contentOffset = CGPointMake(0, EYScreenHeight);
        
        EYLog(@"下一个视频**%lu**", self.currentVideoIndex);
//        if (self.index < self.dataVideo.count - 1) {
//            self.bottom_view.videoModel = self.dataVideo[self.index + 1];
//        }
    } else if (contentOffsetY <= 0) {//上一个视频
        if (self.currentVideoIndex == 1) {
            self.currentVideoIndex = 0; EYLog(@"上滑到第一个视频**%lu**,可以进行下拉刷新的操作了", self.currentVideoIndex);
            return;
        }
        
        if (self.currentVideoIndex == self.arrarM.count - 1) {
            self.currentVideoIndex -= 2;
        }else {
            self.currentVideoIndex--;
        }
        
        //1.修改位置
        EYHomePlayViewController *toptopVC =  self.childViewControllers.firstObject;
        EYHomePlayViewController *centerVC =  self.childViewControllers[1];
        EYHomePlayViewController *bottomVC =  self.childViewControllers.lastObject;
        if (toptopVC.view.mj_y == 0) {// 上(中)下 -> 下(上)中
            //                EYLog(@"777777777777");
            bottomVC.view.mj_y = 0;
            toptopVC.view.mj_y = EYScreenHeight;
            centerVC.view.mj_y = EYScreenHeight * 2;
        } else if (toptopVC.view.mj_y == EYScreenHeight) {// 下(上)中 -> 中(下)上
            //                EYLog(@"8888888888888");
            centerVC.view.mj_y = 0;
            bottomVC.view.mj_y = EYScreenHeight;
            toptopVC.view.mj_y = EYScreenHeight * 2;
        } else {// 中(下)上 -> 上(中)下
            //                EYLog(@"9999999999999");
            toptopVC.view.mj_y = 0;
            centerVC.view.mj_y = EYScreenHeight;
            bottomVC.view.mj_y = EYScreenHeight * 2;
        }
        
        //2.滚动位置
        scrollView.contentOffset = CGPointMake(0, EYScreenHeight);
        EYLog(@"上一个视频**%lu**", self.currentVideoIndex);
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView  {// 开始拖拽
    //    EYLog(@"111111111111111");
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
    //        NSArray *jsonArray = @"EYVideoArray.plist".ey_loadLocalJSONFile;
    //
    //        [self.videoModelArrayM addObjectsFromArray:[EYHomeVideoModel mj_objectArrayWithKeyValuesArray:jsonArray]];
    //    }
    //
    //    if (self.currentVideoIndex <= 0) {
    //        EYLog(@"可以请求最新的一组哈哈哈");
    //        NSArray *jsonArray = @"EYVideoArray.plist".ey_loadLocalJSONFile;
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
- (NSMutableArray<EYVideoModel *> *)arrarM {
    if (nil == _arrarM) {
        _arrarM = [NSMutableArray array];
    }
    return _arrarM;
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
