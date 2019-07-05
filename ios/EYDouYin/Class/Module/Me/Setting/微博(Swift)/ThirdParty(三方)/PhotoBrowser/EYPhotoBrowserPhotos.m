//
//  EYPhotoBrowserPhotos.m
//  EYPhotoBrowser
//
//  Created by lieryang on 16/3/13.
//  Copyright © 2016年 lieryang. All rights reserved.
//

#import "EYPhotoBrowserPhotos.h"

@implementation EYPhotoBrowserPhotos

- (NSString *)description {
    NSArray *keys = @[@"selectedIndex", @"urls", @"parentImageViews"];
    
    return [self dictionaryWithValuesForKeys:keys].description;
}

@end
