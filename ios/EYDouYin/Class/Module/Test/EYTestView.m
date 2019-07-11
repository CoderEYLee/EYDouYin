//
//  EYTestView.m
//  EYDouYin
//
//  Created by 李二洋 on 2019/7/10.
//  Copyright © 2019 李二洋. All rights reserved.
//

#import "EYTestView.h"

@implementation EYTestView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        EYLog(@"redview==%@", NSStringFromCGRect(frame));
        
        self.frame = CGRectMake(0, 0, 400, 400);
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = EYColorWhite;
        titleLabel.numberOfLines = 0;
        titleLabel.text = @"第四十第十四乘时乘势沉思时出差地传递出地址场地和场地传递出待会彻底传递出匆匆地传递出的彻底彻底是还低ID就彻底警察局地产及传递出地处吃得好次当皇帝好多次传递出地 #x2  #Playground or amusement park";
        titleLabel.backgroundColor = EYColorBlue;
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.topMargin.leftMargin.mas_equalTo(10);
            make.bottomMargin.rightMargin.mas_equalTo(-10);
        }];
    }
    return self;
}
    
- (void)setVideoModel:(EYVideoModel *)videoModel {
    _videoModel = videoModel;
    
    
}

@end
