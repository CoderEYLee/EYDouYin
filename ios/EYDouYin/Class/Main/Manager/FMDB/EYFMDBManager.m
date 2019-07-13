//
//  EYFMDBManager.m
//  TTEnglish
//
//  Created by 李二洋 on 2019/6/21.
//  Copyright © 2019 TaoTie. All rights reserved.
//

#import "EYFMDBManager.h"
#import "EYFMDBTool.h"

#define EYFMDBManagerSerialQueueName @"EYFMDBManagerSerialQueueName"
#define EYFMDBManagerReportMinCount 10000

@interface EYFMDBManager()

// 内存中数据数组
@property (strong, nonatomic) NSMutableArray <EYClickPointModel *>*mermoryResults;

// 操作队列(串行)
@property (strong, nonatomic) dispatch_queue_t serialQueue;

@end

@implementation EYFMDBManager

#pragma mark - 初始化
// 用来保存唯一的单例对象
static EYFMDBManager *_FMDBManager = nil;

+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _FMDBManager = [[self alloc] init];
    });
    return _FMDBManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _FMDBManager = [super allocWithZone:zone];
    });
    return _FMDBManager;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return _FMDBManager;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _FMDBManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //1.创建串行操作队列
        self.serialQueue = dispatch_queue_create(EYFMDBManagerSerialQueueName.UTF8String, DISPATCH_QUEUE_SERIAL);
        
        //2.读取所有数据到内存
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

        [EYFMDBTool getAllModelWithBlock:^(NSArray <EYClickPointModel *> * _Nonnull results) {
            [self.mermoryResults addObjectsFromArray:results];
            dispatch_semaphore_signal(semaphore);
        }];
        dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER);

        EYLog(@"单例加载==%@", self.mermoryResults);
    }
    return self;
}

/**
 保存一条日志
 
 @param clickPointModel 需要保存的模型信息
 */
- (void)saveClickPointModelWithModel:(EYClickPointModel *)clickPointModel {
    if (clickPointModel.user_id.length == 0) {
        // EYLog(@"游客模式不需要存储");
        return;
    }
    
    dispatch_async(self.serialQueue, ^{
        [self.mermoryResults addObject:clickPointModel];            //更新内存
        [EYFMDBTool saveClickPointModelWithModel:clickPointModel];  //更新数据库
        
        if (self.mermoryResults.count >= EYFMDBManagerReportMinCount) {//需要上报数据
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            parameters[@"results"] = [EYClickPointModel mj_keyValuesArrayWithObjectArray:self.mermoryResults];
            if ([[EYHTTPManager manager] tt_RecordUserClickWithParameters:parameters]) {
                [self.mermoryResults removeAllObjects]; //删除内存
                [EYFMDBTool deleteAllClickPointModel];  //删除数据库
            }
        }
    });
}

#pragma mark - 懒加载
- (NSMutableArray <EYClickPointModel *>*)mermoryResults {
    if (nil == _mermoryResults) {
        _mermoryResults = [NSMutableArray array];
    }
    return _mermoryResults;
}

@end
