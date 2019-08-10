//
//  EYNetworkManager+Extension.swift
//  weiboSwift
//
//  Created by lieryang on 2017/5/13.
//  Copyright © 2017年 lieryang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

// MARK: --------------------- 封装新浪微博的网络请求方法 ---------------------
extension EYNetworkManager {
    
    /// 加载微博数据字典数组
    ///
    /// - parameter since_id:   返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
    /// - parameter max_id:     返回ID小于或等于max_id的微博，默认为0
    /// - parameter completion: 完成回调[list: 微博字典数组/是否成功]
    func statusList(since_id: Int64 = 0, max_id: Int64 = 0, completion: @escaping ([[String: AnyObject]]?, Bool)->()) {
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        // Swift 中 Int 可以转换成 AnyObject/ 但是 Int64 不行
        let params = ["since_id": "\(since_id)",
                      "max_id": "\(max_id > 0 ? max_id - 1 : 0)"]
        
        tokenRequest(URLString: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            
            // 从 json 中获取 statuses 字典数组
            // 如果 as? 失败，result = nil
            // 提示：服务器返回的字典数组，就是按照时间的倒序排序的
            let result = json?["statuses"] as? [[String: AnyObject]]
            
            completion(result, isSuccess)
        }
    }
    
    /// 返回微博的未读数量 - 定时刷新，不需要提示是否失败！
    func unreadCount(completion: @escaping (Int)->()) {
        
        guard let uid = userAccount.uid else {
            return
        }
        
        let urlString = "https://rm.api.weibo.com/2/remind/unread_count.json"
        
        let params = ["uid": uid]
        
        tokenRequest(URLString: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            
            let dict = json as? [String: AnyObject]
            let count = dict?["status"] as? Int
            
            completion(count ?? 0)
        }
    }
}

// MARK: - 发布微博
extension EYNetworkManager {
    
    /// 发布微博
    ///
    /// - parameter text:       要发布的文本
    /// - parameter image:      要上传的图像，为 nil 时，发布纯文本微博
    /// - parameter completion: 完成回调
    func postStatus(text: String, image: UIImage?, completion: @escaping ([String: AnyObject]?, Bool)->()) -> () {
        
        // 1. url
        let urlString: String
        
        // 根据是否有图像，选择不同的接口地址
        if image == nil {
            urlString = "https://api.weibo.com/2/statuses/update.json"
        } else {
            urlString = "https://upload.api.weibo.com/2/statuses/upload.json"
        }
        
        // 2. 参数字典
        let params = ["status": text]
        
        // 3. 如果图像不为空，需要设置 name 和 data 
        var name: String?
        var data: Data?
        
        if image != nil {
            name = "pic"
            data = image!.pngData()
        }
        
        // 4. 发起网络请求
        tokenRequest(method: .POST, URLString: urlString, parameters: params as [String : AnyObject], name: name, data: data) { (json, isSuccess) in
            completion(json as? [String: AnyObject], isSuccess)
        }
    }
}

// MARK: - 用户信息
extension EYNetworkManager {
    
    /// 加载当前用户信息 - 用户登录后立即执行
    func loadUserInfo(completion: @escaping ([String: AnyObject])->()) {
        
        guard let uid = userAccount.uid else {
            return
        }
        
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        let params = ["uid": uid]
        
        // 发起网络请求
        tokenRequest(URLString: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            // 完成回调
            completion((json as? [String: AnyObject]) ?? [:])
        }
    }
}

// MARK: - OAuth相关方法
extension EYNetworkManager {
    
    /// 提问：网络请求异步到底应该返回什么？-需要什么返回什么？
    /// 加载 AccessToken
    ///
    /// - parameter code:       授权码
    /// - parameter completion: 完成回调[是否成功]
    func loadAccessToken(code: String, completion: @escaping (Bool)->()) {
        let urlString = "https://api.weibo.com/oauth2/access_token?client_id=\(EYAppKey)&client_secret=\(EYAppSecret)&grant_type=authorization_code&code=\(code)&redirect_uri=\(EYRedirectURI)"
        
        // 发起网络请求
        request(method: .POST, URLString: urlString, parameters: nil, encoding: JSONEncoding.default) { (json, isSuccess) in
			
            // 如果请求失败，对用户账户数据不会有任何影响
            // 直接用字典设置 userAccount 的属性
            self.userAccount.yy_modelSet(with: (json as? [String: AnyObject]) ?? [:])
            
            // 加载当前用户信息
            self.loadUserInfo(completion: { (dict) in
                // 使用用户信息字典设置用户账户信息(昵称和头像地址)
                self.userAccount.yy_modelSet(with: dict)
                
                // 保存模型
                self.userAccount.saveAccount()
                
                // 用户信息加载完成再，完成回调
                completion(isSuccess)
            })
        }
    }
}

// MARK: --------------------- 封装映客直播的网络请求方法 ---------------------
extension EYNetworkManager
{
    func liveList(multiaddr: Int64 = 0, completion: @escaping ([[String: AnyObject]]?, Bool)->()) {
        let urlString = "http://service.ingkee.com/api/live/gettop"

        let params = ["uid": 17800399,
                      "count": 5,
                      "multiaddr": multiaddr,
                      ] as [String : Any]
        // 发起网络请求 直播类型
        request(style: .LIVE, URLString: urlString, parameters: params) { (json, isSuccess) in
            EYLog("\(String(describing: json))")
            let jsonSafe = JSON(json as Any)
            let lives = jsonSafe["lives"].arrayObject as? [[String: AnyObject]]
            completion(lives, isSuccess)
        }
    }
}
// MARK: --------------------- 封装智能家居网络请求方法 ---------------------
extension EYNetworkManager
{
    func login(parameters: [String: Any]?, completion: @escaping ([[String: AnyObject]]?, Bool)->()) {
        if (EYSecurityProtocol as NSString).isEqual(to: "https") {
            //认证相关设置
//            SessionManager.default.delegate.sessionDidReceiveChallenge = { session, challenge in
//                //认证服务器证书
//                if challenge.protectionSpace.authenticationMethod
//                    == NSURLAuthenticationMethodServerTrust {
//                    print("服务端需要证书认证！")
//                    let serverTrust:SecTrust = challenge.protectionSpace.serverTrust!
//                    let certificate = SecTrustGetCertificateAtIndex(serverTrust, 0)!
//                    let remoteCertificateData
//                        = CFBridgingRetain(SecCertificateCopyData(certificate))!
//                    let cerPath = Bundle.main.path(forResource: "api.ehomeclouds.com.cn", ofType: "cer")!
//                    let cerUrl = URL(fileURLWithPath:cerPath)
//                    let localCertificateData = try! Data(contentsOf: cerUrl)
//
//                    if (remoteCertificateData.isEqual(localCertificateData) == true) {
//                        let credential = URLCredential(trust: serverTrust)
//                        challenge.sender?.use(credential, for: challenge)
//                        return (URLSession.AuthChallengeDisposition.useCredential,
//                                URLCredential(trust: challenge.protectionSpace.serverTrust!))
//                    } else {
//                        return (.cancelAuthenticationChallenge, nil)
//                    }
//                } else if challenge.protectionSpace.authenticationMethod
//                    == NSURLAuthenticationMethodClientCertificate {
//                    print("客户端证书认证！")//不接受认证
//                    return (.cancelAuthenticationChallenge, nil);
//                } else {
//                    print("其它情况（不接受认证）")
//                    return (.cancelAuthenticationChallenge, nil)
//                }
//            }
        }

        // 发起网络请求 直播类型
        request(method: .POST, style: .SMARTHOME, URLString: EYSmartHomeLogin, parameters: parameters) { (json, isSuccess) in
            EYLog("\(String(describing: json))")
//            let lives = json?["house"] as? [[String: AnyObject]]
//            completion(lives, isSuccess)
        }
    }
}
