//
//  EYUserAccount.swift
//  weiboSwift
//
//  Created by lieryang on 2017/5/13.
//  Copyright © 2017年 lieryang. All rights reserved.
//

import UIKit
import SwiftyJSON

private let accountFile: NSString = "useraccount.json"

/// 用户账户信息
class EYUserAccount: NSObject {
	
    /// 访问令牌
    @objc
    var access_token: String?// = "2.00vRS6TD2nEiHB3d6ea74e32kKGvoC"
    /// 用户代号
    @objc
    var uid: String?
    /// access_token的生命周期，单位是秒数
    /// 开发者 5 年，每次登录之后，都是5年
    /// 使用者 3 天，会从第一次登录递减
    @objc
    var expires_in: TimeInterval = 0 {
        didSet {
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    
    /// 过期日期
    @objc
    var expiresDate: Date?
    
    /// 用户昵称
    @objc
    var screen_name: String?
    /// 用户头像地址（大图），180×180像素
    @objc
    var avatar_large: String?
    
    override var description: String {
        return yy_modelDescription()
    }
    
    override init() {
        
        super.init()
        // 从磁盘加载保存的文件 -> 字典
        // 1> 加载磁盘文件到二进制数据，如果失败直接返回
//        guard let path = accountFile.ey_appendDocumentDir(),
//            let data = NSData(contentsOfFile: path),
//            let dict = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String: AnyObject] else {
//                return
//        }
        guard let path = accountFile.ey_appendDocumentDir(),
            let data = NSData(contentsOfFile: path),
            let dict = JSON(data).dictionaryObject as [String: AnyObject]? else {
                return
        }
        // 2. 使用字典设置属性值
        // *** 用户是否登录的关键代码
        yy_modelSet(with: dict)
        
        // 3. 判断 token 是否过期
        // 测试过期日期 - 开发中，每一个分支都需要测试！
        // expiresDate = Date(timeIntervalSinceNow: -3600 * 24)
        // EYLog(expiresDate)
        if expiresDate?.compare(Date()) != .orderedDescending {
            EYLog("账户过期")
            
            // 清空 token
            access_token = nil
            uid = nil
            
            // 删除帐户文件
            _ = try? FileManager.default.removeItem(atPath: path)
        }
    }
    
    /**
     1. 偏好设置(小) - Xcode 8 beta 无效！
     2. 沙盒- 归档／plist/`json`
     3. 数据库(FMDB/CoreData)
     4. 钥匙串访问(小／自动加密 - 需要使用框架 SSKeychain)
     */
    func saveAccount() {
        
        // 1. 模型转字典
        var dict = (self.yy_modelToJSONObject() as? [String: AnyObject]) ?? [:]
        
        // 需要删除 expires_in 值
        dict.removeValue(forKey: "expires_in")
        
        // 2. 字典序列化 data
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []),
            let filePath = accountFile.ey_appendDocumentDir()
            else {
                return
        }

        // 3. 写入磁盘
        (data as NSData).write(toFile: filePath, atomically: true)
        
        EYLog("用户账户保存成功 \(filePath)")
    }
    
    //删除账户
    class func deleteAccount() {
        let dict: [String:AnyObject]? = nil
        // 2. 字典序列化 data
        guard let data = try? JSONSerialization.data(withJSONObject: dict ?? [:], options: []),
            let filePath = accountFile.ey_appendDocumentDir()
            else {
                return
        }
        
        // 3. 写入磁盘
        (data as NSData).write(toFile: filePath, atomically: true)
        
        EYLog("用户账户删除成功 \(filePath)")
    }
}
