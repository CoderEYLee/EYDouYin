//
//  EYFloatButton.h
//  TTEnglish
//
//  Created by 李二洋 on 2020/2/4.
//  Copyright © 2020 TaoTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EYFloatButton : UIButton

/**传入父View*/
@property(nonatomic,weak) UIView *parentView;

/**安全边距，主要是针对有Navbar 以及 tabbar的*/
@property(nonatomic,assign)UIEdgeInsets safeInsets;

@end

NS_ASSUME_NONNULL_END
