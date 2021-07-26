//
//  EYRouteManager.m
//  EYDouYin
//
//  Created by bytedance on 2021/3/5.
//  Copyright © 2021 李二洋. All rights reserved.
//

#import "EYMGJRouteManager.h"
#import <MGJRouter.h>

NSString *RouteKey1 = @"MGJ://Test2/getMainVC";

@interface EYMGJRouteManager()

@end

@implementation EYMGJRouteManager

+ (void)load {
    [MGJRouter registerURLPattern:RouteKey1 toObjectHandler:^id(NSDictionary *routerParameters) {
        NSLog(@"李二洋---%@", routerParameters);
        return [NSObject new];
//        NSString *labelText = routerParameters[MGJRouterParameterUserInfo][@"text"];
//        Test2ViewController *vc = [[Test2ViewController alloc] init];
//        vc.labelText = labelText;
//        return vc;
    }];
}

@end
