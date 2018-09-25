//
//  EYHomeBackView.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/9/25.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYHomeBackView.h"

@interface EYHomeBackView()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation EYHomeBackView

+ (instancetype)homeBackView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)show {

}

@end
