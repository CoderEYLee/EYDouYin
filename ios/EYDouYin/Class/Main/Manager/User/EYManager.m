//
//  EYManager.m
//  TTEnglish
//
//  Created by 李二洋 on 2018/11/19.
//  Copyright © 2019 TTEnglish. All rights reserved.
//

#import "EYManager.h"
#import "EYUserModelTool.h"

@interface EYManager()

@property (strong, nonatomic, readwrite) EYUserModel *userModel;

@end

@implementation EYManager

#pragma mark - 初始化
// 用来保存唯一的单例对象
static EYManager *_manager = nil;

+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    return _manager;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return _manager;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 初始化
    }
    return self;
}

/**
 存储值

 @param userModel 需要存储的数据
 */
- (void)saveUserModel:(EYUserModel *)userModel {
    _userModel = userModel;                     //更新内存
    [EYUserModelTool saveUserModel:userModel];  //更新磁盘
}

/**
 移除数据
 */
- (void)removeUserModel {
    _userModel = nil;
    [EYUserModelTool removeUserModel];
}

#pragma mark - 懒加载
- (EYUserModel *)userModel {
    if (nil == _userModel) {
        _userModel = [EYUserModelTool userModel];
    }
    return _userModel;
}

#pragma mark -- 用户上传过的视频 --
//查找是否上传过该视频，上传过返回yes未上传返回no
- (BOOL)search_video_tag:(NSString *)video_tag {
    NSArray *temp_array = [[NSUserDefaults standardUserDefaults]objectForKey:@"up_data_video"];
    if (temp_array.count > 0) {
        for (NSString *tag in temp_array) {
            if ([video_tag isEqualToString:tag]) {
                return YES;
            }
        }
    }
    return NO;
}

//添加用户上传的视频
- (void)add_video_tag:(NSString *)video_tag {
    NSArray *temp_array = [[NSUserDefaults standardUserDefaults]objectForKey:@"up_data_video"];
    if (temp_array.count > 0) {
        for (NSString *tag in temp_array) {
            if ([video_tag isEqualToString:tag]) {
                return;
            }
        }
    }
    NSMutableArray *mutable_array = [[NSMutableArray alloc]initWithArray:temp_array];
    [mutable_array addObject:video_tag];
    NSArray *finish_array = [NSArray arrayWithArray:mutable_array];
    [[NSUserDefaults standardUserDefaults]setObject:finish_array forKey:@"up_data_video"];
}

#pragma mark -- 用户搜索历史 --
//搜索内容
- (void)setSearch_history_content:(NSString *)search_history_content {
    NSArray *history_array = EYObjectForKey(TTVideoSearchHistory);
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:history_array];
    for (NSString *content in array) {
        if ([content isEqualToString:search_history_content]) {
            [array removeObject:content];
            break;
        }
    }
    [array insertObject:search_history_content atIndex:0];
    if (array.count > 10) {
        [array removeLastObject];
    }
    history_array = [NSArray arrayWithArray:array];
    [EYUserDefaults setObject:history_array forKey:TTVideoSearchHistory];
}
//获取搜索历史
- (NSArray *)search_history {
    NSArray *history_array = EYObjectForKey(TTVideoSearchHistory);
    return history_array;
}
//删除搜索历史
- (void)delete_search_history_content:(NSString *)delete_content {
    NSArray *history_array = EYObjectForKey(TTVideoSearchHistory);
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:history_array];
    for (NSString *content in array) {
        if ([content isEqualToString:delete_content]) {
            [array removeObject:content];
            break;
        }
    }
    history_array = [NSArray arrayWithArray:array];
    [EYUserDefaults setObject:history_array forKey:TTVideoSearchHistory];
}

//全部删除搜索历史
- (void)delete_search_all {
    [EYUserDefaults removeObjectForKey:TTVideoSearchHistory];
}

//清空搜索历史
- (void)remove_search_history {
    [EYUserDefaults setObject:nil forKey:TTVideoSearchHistory];
}

#pragma mark - 所有
/**
 清除该单例中所有内存数据(退出登录的时候调用)
 */
- (void)clearAllMemoryData {
    //1.清除用户信息
    [self removeUserModel];
    
    //清空历史搜索
    [self remove_search_history];
}

@end
