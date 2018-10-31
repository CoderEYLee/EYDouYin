//
//  EYWaterflowShopCell1.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/10/31.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYWaterflowShopCell1.h"
#import "EYShop.h"

@interface EYWaterflowShopCell1()

@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) UILabel *priceLabel;

@end

@implementation EYWaterflowShopCell1

- (EYWaterflowViewCell *)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self commitInit];
    }
    return self;
}

- (void)commitInit {
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    self.imageView = imageView;

    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];//设置背景透明色
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.textColor = [UIColor blackColor];
    [self addSubview:priceLabel];
    self.priceLabel = priceLabel;
}

- (void)setShop:(EYShop *)shop {
    _shop = shop;

    // 1.图片 现在图片链接f的服务器增加了证书验证! 使用不了了!!
    // [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];

    // 2.价格
    self.priceLabel.text = shop.price;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.imageView.frame = self.bounds;

    CGFloat priceH = 30;
    CGFloat priceY = self.bounds.size.height - priceH;
    CGFloat priceW = self.bounds.size.width;
    self.priceLabel.frame = CGRectMake(0, priceY, priceW, priceH);
}

@end
