//
//  EYRouteManager.m
//  EYDouYin
//
//  Created by bytedance on 2021/3/5.
//  Copyright © 2021 李二洋. All rights reserved.
//

#import "EYMGJRouteManager.h"
#import "EYMineViewController.h"

@interface EYMGJRouteManager()

@end

@implementation EYMGJRouteManager

+ (void)load {
    [MGJRouter registerURLPattern:EYMGJRouteKeyTestA toObjectHandler:^id(NSDictionary *routerParameters) {
        NSLog(@"李二洋---%@", routerParameters);
        
        UINavigationController *navi = routerParameters[MGJRouterParameterUserInfo][EYMGJRouteKeyNavigationVC];
        [navi pushViewController:[[EYMineViewController alloc] init] animated:YES];
        
        return navi;
    }];
}

@end
