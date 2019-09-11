//
//  EYWaterflowShopCell2.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/10/31.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYWaterflowShopCell2.h"
#import "EYShop.h"

@interface EYWaterflowShopCell2 ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation EYWaterflowShopCell2

+ (instancetype)waterflowShopCell2 {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)setShop:(EYShop *)shop {
    _shop = shop;

    // 1.图片
    [self.imageView ey_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"] options:SDWebImageAllowInvalidSSLCertificates];

    // 2.价格
    self.priceLabel.text = shop.price;
}

@end
