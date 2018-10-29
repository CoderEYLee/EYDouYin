//
//  EYShopCell.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/10/29.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYShopCell.h"
#import "EYShop.h"

@interface EYShopCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation EYShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setShop:(EYShop *)shop {
    _shop = shop;

    // 1.图片 现在图片链接f的服务器增加了证书验证! 使用不了了!!
   // [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];

    // 2.价格
    self.priceLabel.text = shop.price;
}

@end
