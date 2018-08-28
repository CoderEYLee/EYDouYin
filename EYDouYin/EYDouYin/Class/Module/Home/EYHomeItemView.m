//
//  EYHomeItemView.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/26.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYHomeItemView.h"
#import "EYBlueView.h"

@interface EYHomeItemView()

@property (weak, nonatomic) IBOutlet EYBlueView *blueView;

@end

@implementation EYHomeItemView

+ (instancetype)homeItemView {
    EYHomeItemView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([EYHomeItemView class]) owner:nil options:nil] lastObject];
    view.frame = EYScreenBounds;

    //方法一: 通过 xib 直接设置
/*
    //方法二: 通过 initWithFrame 👌
    EYBlueView * blueView2 = [[EYBlueView alloc] initWithFrame:CGRectMake(10, 100, 300, 100)];
    [view addSubview:blueView2];

    //方法三: 通过 [NSBundle mainBundle] loadNibNamed  👌
    EYBlueView * blueView3 = [[NSBundle mainBundle] loadNibNamed:@"EYBlueView" owner:[EYBlueView alloc] options:nil].firstObject;
    blueView3.frame = CGRectMake(10, 250, 300, 100);
    [view addSubview:blueView3];

    //方法四: 通过 UINib nibWithNibName instantiateWithOwner 👌
    EYBlueView * blueView4 = [[UINib nibWithNibName:NSStringFromClass([EYBlueView class]) bundle:nil] instantiateWithOwner:[EYBlueView alloc] options:nil].firstObject;
    blueView4.frame = CGRectMake(10, 400, 300, 100);
    [view addSubview:blueView4];

    //方法五: 通过 类方法(自定义方法) 👌
    EYBlueView * blueView5 = [EYBlueView blueView];
    blueView5.frame = CGRectMake(10, 550, 300, 100);
    [view addSubview:blueView5];
*/
    return view;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.blueView.textField.text = @"lieryang";
}

@end
