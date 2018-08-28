//
//  EYMeViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/7/23.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYMeViewController.h"
#import <YYKit.h>

@interface EYMeViewController ()

@end

@implementation EYMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = EYRandomColor;
    EYLog(@"EYMeViewController--viewDidLoad");

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    label.backgroundColor = EYRandomColor;
    [self.view addSubview:label];
 }

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];

    NSString * document = EYPathDocument;

    NSString * fileName = @"a/b/c/d/e/f.mp3";

    NSString * filePath = [document stringByAppendingPathComponent:fileName];

    if ([EYFileManager fileExistsAtPath:filePath]) {
        EYLog(@"1111111111111111");
    } else {
        EYLog(@"222222222222222");
        [EYFileManager createDirectoryAtPath:[filePath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

@end
