//
//  EYTestViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/12.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYTestViewController.h"
#import "EYTestView.h"

@interface EYTestViewController ()

@end

@implementation EYTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    //1. 初始化界面
    [self setupUI];
}
    
//1. 初始化界面
- (void)setupUI {
    self.view.backgroundColor = EYColorRandom;
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.text = @"1234";
    label.textColor = EYColorRed;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    self.label = label;
    
    return;
    
    EYTestView *redView = [[EYTestView alloc] init];
    redView.backgroundColor = EYColorRed;
    EYVideoModel *videoModel = [[EYVideoModel alloc] init];
    videoModel.video_title = @"十乘势沉思接口的施工方可接受的接口的给接口时十乘势沉思接口的施工方可接受的接口的给接口时十乘势沉思接口的施工方可接受的接口的给接出差地传递出地址场地和场地传递出十乘势沉思十乘势沉思时出差地传递出地址场地和场地传递出待会彻底传递出匆匆地传递出的彻底彻底是彻底警察局局地产及传递出地处吃得好十乘势沉思接口的施工方可接受的接口的给接口时出差地传递出地址场地和场地传递出十乘势沉思十乘势沉思时出差地传递出地址场地和场地传递出待会彻底传递出匆匆地传递出的彻底彻底是彻底警察局局地产及传递出地处吃得好十乘势沉思接口的施工方可接受的接口的给接口时出差地传递出地址场地和场地传递出十乘势沉思十乘势沉思时出差地传递出地址场地和场地传递出待会彻底传递出匆匆地传递出的底传递出匆匆地传彻底彻底是彻底警察局局地产及传递出地处吃得好十乘势沉思接口的施工方可接受的接口的给接口时出差地传递出地址场地和场地传递出十乘势沉出地址场地和场地传递出十乘势沉思十乘势沉思时出差地传递出地址场地和场地传递出待会彻底传递出#x2  #Playground or amusement park";
    redView.videoModel = videoModel;
    [self.view addSubview:redView];
}

@end
