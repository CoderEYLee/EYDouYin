//
//  EYSQLiteManager.swift
//  001-数据库
//
//  Created by lieryang on 16/7/13.
//  Copyright © 2016年 lieryang. All rights reserved.
//

import Foundation
import FMDB
import SwiftyJSON

/// 最大的数据库缓存时间，以 s 为单位
private let maxDBCacheTime: TimeInterval = -60 // -5 * 24 * 60 * 60

/// SQLite 管理器
/**
 1. 数据库本质上是保存在沙盒中的一个文件，首先需要创建并且打开数据库
    FMDB - 队列
 2. 创建数据表
 3. 增删改查
 
 提示：数据库开发，程序代码几乎都是一致的，区别在 SQL
 
 开发数据库功能的时候，首先一定要在 navicat 中测试 SQL 的正确性！
 */
class EYSQLiteManager {
    
    /// 单例，全局数据库工具访问点
    static let shared = EYSQLiteManager()
    
    /// 数据库队列
    let queue: FMDatabaseQueue
    
    /// 构造函数
    private init() {
        
        // 数据库的全路径 - path
        let dbName = "status.db"
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        path = (path as NSString).appendingPathComponent(dbName)
        
        EYLog("数据库的路径 " + path)
        
        // 创建数据库队列，同时`创建或者打开`数据库
        queue = FMDatabaseQueue(path: path)!
        
        // 打开数据库
        createTable()
        
        // 注册通知 - 监听应用程序进入后台
        // 模仿 SDWebImage
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(clearDBCache),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil)
    }
    
    deinit {
        // 注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
    /// 清理数据缓存 
    /// 注意细节：
    /// - SQLite 的数据不断的增加数据，数据库文件的大小，会不断的增加
    /// - 但是：如果删除了数据，数据库的大小，不会变小！
    /// - 如果要变小
    /// 1> 将数据库文件复制一个新的副本，status.db.old
    /// 2> 新建一个空的数据库文件
    /// 3> 自己编写 SQL，从 old 中将所有的数据读出，写入新的数据库！
    @objc private func clearDBCache() {
        
        let dateString = Date.ey_dateString(delta: maxDBCacheTime)
        
        EYLog("清理数据缓存 \(dateString)")
        
        // 准备 SQL
        let sql = "DELETE FROM T_Status WHERE createTime < ?;"
        
        // 执行 SQL
        queue.inDatabase { (db) in
            
            if db.executeUpdate(sql, withArgumentsIn: [dateString]) == true {
                
                EYLog("删除了 \(String(describing: db.changes)) 条记录")
            }
        }
    }
}

// MARK: - 微博数据操作
extension EYSQLiteManager {
    
    /// 从数据库加载微博数据数组
    ///
    /// - parameter userId:   当前登录的用户帐号
    /// - parameter since_id: 返回ID比since_id大的微博
    /// - parameter max_id:   返回ID小于max_id的微博
    ///
    /// - returns: 微博的字典的数组，将数据库中 status 字段对应的二进制数据反序列化，生成字典
    func loadStatus(userId: String, since_id: Int64 = 0, max_id: Int64 = 0) -> [[String: AnyObject]] {
        
        // 1. 准备 SQL
        var sql = "SELECT statusId, userId, status FROM T_Status \n"
        sql += "WHERE userId = \(userId) \n"
        
        // 上拉／下拉，都是针对同一个 id 进行判断
        if since_id > 0 {
            sql += "AND statusId > \(since_id) \n"
        } else if max_id > 0 {
            sql += "AND statusId < \(max_id) \n"
        }
        
        sql += "ORDER BY statusId DESC LIMIT 20;"
        
        // 拼接 SQL 结束后，一定一定一定要测试！
//        EYLog(sql)
		
        // 2. 执行 SQL
        let array = execRecordSet(sql: sql)
        
        // 3. 遍历数组，将数组中的 status 反序列化 -> 字典的数组
        var result = [[String: AnyObject]]()
        
        for dict in array {
            
            // 反序列化
//            guard let jsonData = dict["status"] as? Data,
//                let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: AnyObject]
//                else {
//                    continue
//            }
            guard let jsonData = dict["status"] as? Data,
                let json = JSON(jsonData).dictionaryObject as [String: AnyObject]?
                else {
                    continue
            }

            // 追加到数组
            result.append(json)
        }
        
        return result
    }
    
    /**
     思考：从网路加载结束后，返回的是微博的`字典数组`，每一个字典对应一个完整的微博记录
     - 完整的微博记录中，包含微博的代号
     - 微博记录中，没有`当前登录的用户代号`
    */
    /// 新增或者修改微博数据，微博数据在刷新的时候，可能会出现重叠
    ///
    /// - parameter userId: 当前登录用户的 id
    /// - parameter array:  从网路获取的`字典的数组`
    func updateStatus(userId: String, array: [[String: AnyObject]]) {
        
        // 1. 准备 SQL
        /**
         statusId:  要保存的微博代号
         userId:    当前登录用户的 id
         status:    完整微博字典的 json 二进制数据
         */
        let sql = "INSERT OR REPLACE INTO T_Status (statusId, userId, status) VALUES (?, ?, ?);"
        
        // 2. 执行 SQL
        queue.inTransaction { (db, rollback) in
            
            // 遍历数组，逐条插入微博数据
            for dict in array {
                
                // 从字典获取微博代号／将字典序列化成二进制数据
                guard let statusId = dict["idstr"] as? String,
                    let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
                    else {
                        continue
                }
                
                // 执行 SQL
                if db.executeUpdate(sql, withArgumentsIn: [statusId, userId, jsonData]) == false {
                    
                    // 需要回滚 *rollback = YES;
                    // Xcode 的自动语法转换，不会处理此处！
                    // Swift 1.x & 2.x => rollback.memory = true;
                    // Swift 3.0 的写法
                    rollback.pointee = true
                    
                    break
                }
            }
        }
    }
}

// MARK: - 创建数据表以及其他私有方法
extension EYSQLiteManager {
    
    /// 执行一个 SQL，返回字典的数组
    ///
    /// - parameter sql: sql
    ///
    /// - returns: 字典的数组
    func execRecordSet(sql: String) -> [[String: AnyObject]] {
        
        // 结果数组
        var result = [[String: AnyObject]]()
        
        // 执行 SQL - 查询数据，不会修改数据，所以不需要开启事务！
        // 事务的目的，是为了保证数据的有效性，一旦失败，回滚到初始状态！
        queue.inDatabase { (db) in
            
            guard let rs = db.executeQuery(sql, withArgumentsIn: []) else {
                return
            }
            
            // 逐行 - 遍历结果集合
            while rs.next() {
                
                // 1> 列数
                let colCount = rs.columnCount
                
                // 2> 遍历所有列
                for col in 0..<colCount {
                    
                    // 3> 列名 -> KEY / 值 -> Value
                    guard let name = rs.columnName(for: col),
                        let value = rs.object(forColumnIndex: col) else {
                            continue
                    }
                    
                    // EYLog("\(name) - \(value)")
                    // 4> 追加结果
                    result.append([name: value as AnyObject])
                }
            }
        }
        
        return result
    }
    
    /// 创建数据表
    func createTable() {
        
        // 1. SQL
        guard let path = Bundle.main.path(forResource: "status.sql", ofType: nil),
            let sql = try? String(contentsOfFile: path)
            else {
                return
        }
        
        // 2. 执行 SQL - FMDB 的内部队列，串行队列，同步执行
        // 可以保证同一时间，只有一个任务操作数据库，从而保证数据库的读写安全！
        queue.inDatabase { (db) in
            
            // 只有在创表的时候，使用执行多条语句，可以一次创建多个数据表
            // 在执行增删改的时候，一定不要使用 statements 方法，否则有可能会被注入！
            if db.executeStatements(sql) == true {
                EYLog("创表成功")
            } else {
                EYLog("创表失败")
            }
        }
        EYLog("--- over")
    }
}
