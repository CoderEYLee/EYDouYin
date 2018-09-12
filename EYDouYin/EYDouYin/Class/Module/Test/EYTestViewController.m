//
//  EYTestViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/12.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYTestViewController.h"

@interface EYTestViewController ()

@end

@implementation EYTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel * label = [[UILabel alloc] init];
    label.text = @"这是一个测试界面";
    [label sizeToFit];
    label.center = self.view.center;
    [self.view addSubview:label];

    NSString * jsonName = @"ChinLab_en.json";
    NSDictionary *dictionary = jsonName.ey_loadLocalFile;
    NSString * value1 = dictionary[@"key1"];

    NSLog(@"------dictionary:%@------", dictionary);

    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, EYScreenWidth, 200)];
    label1.backgroundColor = EYRandomColor;
    label1.text = [NSString stringWithFormat:value1, @"AAAA", @"BBBB"];
    label1.numberOfLines = 0;
    [self.view addSubview:label1];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];

    [self.navigationController popViewControllerAnimated:YES];
}

@end
