//
//  EYFindTopView.h
//  EYDouYin
//
//  Created by 李二洋 on 2018/8/12.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EYFindTopViewButton) {
    EYFindTopViewButtonScan,
    EYFindTopViewButtonRight,
};

@class EYFindTopView;

@protocol EYFindTopViewDelegate <NSObject>

@optional
- (void)findTopView:(EYFindTopView *)findTopView didTapButton:(EYFindTopViewButton)buttonTpye;

@end

@interface EYFindTopView : UIView

+ (instancetype)findTopView;

@property (weak, nonatomic) id <EYFindTopViewDelegate> delegate;

@end
