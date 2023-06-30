//
//  EYFlutterViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2023/7/3.
//  Copyright © 2023 李二洋. All rights reserved.
//

#import "EYFlutterViewController.h"
#import <Flutter/Flutter.h>

@interface EYFlutterViewController ()

@end

@implementation EYFlutterViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化 UI
    [self setupUI];
}

//1.初始化 UI
- (void)setupUI {
    self.gk_interactivePopDisabled = YES;
    self.gk_navLeftBarButtonItem = nil;
    self.gk_navLineHidden = YES;
    self.gk_navRightBarButtonItem = [UIBarButtonItem gk_itemWithTitle:@"关闭" color:UIColor.redColor target:self action:@selector(closeVC)];
    
    self.view.backgroundColor = EYColorWhite;
}

- (void)closeVC {
    EYLog(@"closeVC");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
