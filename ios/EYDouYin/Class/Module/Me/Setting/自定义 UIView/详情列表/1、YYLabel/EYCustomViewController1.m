//
//  EYCustomViewController1.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/7/22.
//  Copyright © 2019 李二洋. All rights reserved.
//  需求: 外界不设置 frame, 内部通过传递进来的 Model 对象 自适应大小

#import "EYCustomViewController1.h"
#import "EYCustomFitView1.h"

@interface EYCustomViewController1 ()

@end

@implementation EYCustomViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 初始化界面
    [self setupUI];
}

//1. 初始化界面
- (void)setupUI {
    EYCustomFitView1 *customFitView = [[EYCustomFitView1 alloc] init];
    customFitView.backgroundColor = EYColorRed;
    EYVideoModel *videoModel = [[EYVideoModel alloc] init];
    videoModel.video_title = @"你好!打扫房间了任务截图我几点开始发过火卡加斯额外恢复健康十多个进口纱还是看见安徽科技就开始恢复卡双离合挂号网if古尔沟环能科技速度快和是该控件撒";
    
    //2.传递数据(内部会根据Model内容设置customFitView的大小)
    customFitView.videoModel = videoModel;
    
    //3.修改起始位置(方式一)不能修改宽和高
//    customFitView.origin = CGPointMake(0, EYStatusBarAndNaviBarHeight);
    [self.view addSubview:customFitView];
    
    //3.重新设置位置(方式二)不能修改宽和高
    [customFitView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(EYStatusBarAndNaviBarHeight);
        make.height.mas_equalTo(customFitView.mj_h);
    }];
}

@end
