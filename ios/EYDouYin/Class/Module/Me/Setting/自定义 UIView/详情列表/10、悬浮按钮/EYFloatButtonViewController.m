//
//  EYFloatButtonViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2020/7/27.
//  Copyright © 2020 李二洋. All rights reserved.
//

#import "EYFloatButtonViewController.h"

@interface EYFloatButtonViewController ()

@property (weak, nonatomic) UICountingLabel *countingLabel;

@end

@implementation EYFloatButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 初始化界面
    [self setupUI];
}

//1. 初始化界面
- (void)setupUI {
    UICountingLabel *countingLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 13)];
    countingLabel.format = @"%d";
    countingLabel.textAlignment = NSTextAlignmentRight;
    countingLabel.textColor = EYColorWhite;
    countingLabel.font = [UIFont systemFontOfSize:30];
    countingLabel.method = UILabelCountingMethodEaseInOut;
    [countingLabel countFrom:0 to:100];
    [self.view addSubview:countingLabel];
    self.countingLabel = countingLabel;
    [countingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
}

@end
