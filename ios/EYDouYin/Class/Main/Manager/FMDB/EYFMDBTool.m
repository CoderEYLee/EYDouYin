//
//  EYFMDBTool.m
//  TTEnglish
//
//  Created by 李二洋 on 2019/6/25.
//  Copyright © 2019 TaoTie. All rights reserved.
//

#import "EYFMDBTool.h"
#import <FMDB.h>

@implementation EYFMDBTool

static FMDatabaseQueue *_queue;

+ (void)load {
    //1.数据库存储路径
    NSString *SQLitePath = TTReportSQLiteName.insertDocumentPathString;
    EYLog(@"FMDB存储路径==%@", SQLitePath);
    
    //2.创建数据库队列，同时`创建或者打开`数据库
    _queue = [FMDatabaseQueue databaseQueueWithPath:SQLitePath];
    
    //3.创表 params
    NSString *deleteTableSQL = @"CREATE TABLE IF NOT EXISTS t_report (id integer PRIMARY KEY AUTOINCREMENT, user_id text NOT NULL, action_id integer NOT NULL, create_time text NOT NULL, param text);";
    [_queue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db executeUpdate:deleteTableSQL]) {
            EYLog(@"FMDB创建表成功");
        } else {
            EYLog(@"FMDB创建表失败");
        }
    }];
}

/**
 获取数据库中的所有存储数据
 
 @param block 数据数组
 */
+ (void)getAllModelWithBlock:(void (^)(NSArray <EYClickPointModel *>* _Nonnull))block {
//    EYLog(@"数据库执行读取操作");
    // 执行读取操作
    [_queue inDatabase:^(FMDatabase * _Nonnull db) {
        NSMutableArray <EYClickPointModel *>*results = [NSMutableArray array];
        FMResultSet *set = [db executeQueryWithFormat:@"SELECT * FROM t_report ORDER BY id ASC LIMIT 100;"];
        while (set.next) {
            [results addObject:[EYClickPointModel mj_objectWithKeyValues:set.resultDictionary]];
        }

        if (block) {
            block([NSArray arrayWithArray:results]);
        }
    }];
}

/**
 保存一条日志到数据库
 
 @param clickPointModel 需要保存的模型信息
 */
+ (void)saveClickPointModelWithModel:(EYClickPointModel *)clickPointModel {
    // 执行插入操作
//    EYLog(@"执行插入操作");
    [_queue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db executeUpdateWithFormat:@"INSERT INTO t_report(user_id, action_id, create_time, param) VALUES (%@, %ld, %@, %@);", clickPointModel.user_id, (long)clickPointModel.action_id, clickPointModel.create_time, clickPointModel.param.mj_JSONString]) {
//            EYLog(@"FMDB数据库执行插入操作成功==%@", clickPointModel.param.mj_JSONString);
        } else {
//            EYLog(@"FMDB数据库执行插入操作失败");
        }
    }];
}

/**
 删除表中的所有数据
 */
+ (void)deleteAllClickPointModel {
//    EYLog(@"数据库删除数据");
    [_queue inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db executeUpdate:@"DELETE FROM t_report;"]) {
//            EYLog(@"FMDB数据库删除操作成功");
        } else {
//            EYLog(@"FMDB数据库删除操作失败");
        }
    }];
}

@end
