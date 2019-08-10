//
//  EYNetworkManager.swift
//  weiboSwift
//
//  Created by lieryang on 16/7/2.
//  Copyright © 2016年 lieryang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

/// Swift 的枚举支持任意数据类型
/// switch / enum 在 OC 中都只是支持整数
/**
 - 如果日常开发中，发现网络请求返回的状态码是 405，不支持的网络请求方法
 - 首先应该查找网路请求方法是否正确
 */
enum EYHTTPMethod {
    case GET
    case POST
}

enum EYHTTPStyle {//http请求类型
    case STATUS  //微博
    case LIVE    //直播
    case NEWS    //新闻
    case SMARTHOME //智能家居
}

// MARK: ----------------------- 新浪微博 -----------------------

/// 网络管理工具
class EYNetworkManager: Session {

    /// 静态区／常量／闭包
    /// 在第一次访问时，执行闭包，并且将结果保存在 shared 常量中
//    static let shared: EYNetworkManager = {
//
//        // 实例化对象
//        let instance = EYNetworkManager()
//
//        // 返回对象
//        return instance
//    }()
    // static: 类属性 这种方式最简洁
    // 这段代码会先调用了swift_once，接下来是swift_once_block_invoke中执行 Apple之前在文档中已经说过，“懒实例化”的全局变量会被自动放在dispatch_once块中
    static let shared: EYNetworkManager = EYNetworkManager()

    /// 用户账户的懒加载属性
    lazy var userAccount = EYUserAccount()

    /// 用户登录标记[计算型属性]
    var userLogon: Bool {
        return userAccount.access_token != nil
    }
    
    /// 专门负责拼接 token 的网络请求方法
    ///
    /// - parameter method:     GET / POST
    /// - parameter URLString:  URLString
    /// - parameter parameters: 参数字典
    /// - parameter name:       上传文件使用的字段名，默认为 nil，不上传文件
    /// - parameter data:       上传文件的二进制数据，默认为 nil，不上传文件
    /// - parameter completion: 完成回调
    func tokenRequest(method: EYHTTPMethod = .GET, URLString: String, parameters: [String: AnyObject]?, name: String? = nil, data: Data? = nil, completion: @escaping (AnyObject?, Bool)->()) {
        
        // 处理 token 字典
        // 0> 判断 token 是否为 nil，为 nil 直接返回，程序执行过程中，一般 token 不会为 nil
        guard let token = userAccount.access_token else {
            
            // 发送通知，提示用户登录
            EYLog("没有 token! 需要登录")
            
            NotificationCenter.default.post(
                name: NSNotification.Name(rawValue: EYUserShouldLoginNotification),
                object: nil)
            
            completion(nil, false)
            
            return
        }
        
        // 1> 判断 参数字典是否存在，如果为 nil，应该新建一个字典
        var parameters = parameters
        if parameters == nil {
            // 实例化字典
            parameters = [String: AnyObject]()
        }
        
        // 2> 设置参数字典，代码在此处字典一定有值
        parameters!["access_token"] = token as AnyObject
        
        // 3> 判断 name 和 data 
        if let name = name, let data = data {
            // 上传文件
            upload(URLString: URLString, parameters: parameters, name: name, data: data, completion: completion)
        } else {
            
            // 调用 request 发起真正的网络请求方法
            // request(URLString: URLString, parameters: parameters, completion: completion)
            request(method: method, URLString: URLString, parameters: parameters, completion: completion)
        }
    }

    // MARK: - 封装 Alamofire 方法
    /// 上传文件必须是 POST 方法，GET 只能获取数据
    /// 封装 Alamofire 的上传文件方法
    ///
    /// - parameter URLString:  URLString
    /// - parameter parameters: 参数字典
    /// - parameter name:       接收上传数据的服务器字段(name - 要咨询公司的后台) `pic`
    /// - parameter data:       要上传的二进制数据
    /// - parameter completion: 完成回调
    func upload(URLString: String, parameters: [String: AnyObject]?, name: String, data: Data, completion: @escaping (AnyObject?, Bool)->()) {
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters ?? [:]{
                multipartFormData.append((value.data(using: String.Encoding.utf8.rawValue))!, withName: key)
            }
            multipartFormData.append(data, withName: name, fileName: "xxx", mimeType: "application/octet-stream")
        }, to: URLString).responseJSON(completionHandler: { (dataResponse) in
            switch dataResponse.result {
                case .success(let value):
                    EYLog("发送微博成功了 \(value)")
                    completion(value as AnyObject, true)
                case .failure(let error):
                    EYLog("网络请求错误 \(error.localizedDescription)")
                    completion(nil, false)
            }
        })
//        AF.upload(multipartFormData: { (multipartFormData) in
//            for (key, value) in parameters ?? [:]{
//                multipartFormData.append((value.data(using: String.Encoding.utf8.rawValue))!, withName: key)
//            }
//            multipartFormData.append(data, withName: name, fileName: "xxx", mimeType: "application/octet-stream")
//        }, to: URLString) { (encodingResult) in
//            switch encodingResult {
//            case .success(let upload, _, _):
//                upload.responseJSON { response in
//                    EYLog("发送微博成功了")
//                    if let value = response.value as? [String: AnyObject]{
//                        EYLog("\(value)")
//                        completion(value as AnyObject, true)
//                    } else if response.response?.statusCode == 403 {
//                        EYLog("Token 过期了")
//
//                        EYUserAccount.deleteAccount()
//
//                        // 发送通知，提示用户再次登录(本方法不知道被谁调用，谁接收到通知，谁处理！)
//                        NotificationCenter.default.post(
//                            name: NSNotification.Name(rawValue: EYUserShouldLoginNotification),
//                            object: "bad token")
//                        completion(nil, false)
//                    }
//                }
//            case .failure(let encodingError):
//                EYLog("网络请求错误 \(encodingError.localizedDescription))")
//                completion(nil, false)
//            }
//        }
    }

    /// 封装 Alamofire 的 GET / POST 请求
    ///
    /// - Parameters:
    ///   - method: GET / POST
    ///   - style: 请求类型  默认为STATUS 微博
    ///   - URLString: URL地址
    ///   - parameters: 参数字典
    ///   - encoding: 编码格式
    ///   - completion: 完成回调[json(字典／数组), 是否成功]
    func request(method: EYHTTPMethod = .GET, style: EYHTTPStyle = .STATUS , URLString: String, parameters: [String: Any]?, encoding: ParameterEncoding = URLEncoding.default, completion: @escaping (AnyObject?, Bool)->()) {
        EYLog("\n method->\(method)\n style->\(style)\n URLString->\(URLString)\n parameters->\(String(describing: parameters))")
        AF.request(URLString, method: method == .POST ? .post : .get, parameters: parameters, encoding: encoding).responseJSON { (data) in
            let statusCode = data.response?.statusCode
            if statusCode == 200 {
                let value = data.value
                EYLog("\n URLString->\(URLString)\n \(String(describing: value))")
                completion(value as AnyObject, true)
            } else if statusCode == 400  && style == .STATUS {
                EYLog("Token 过期了")
                EYUserAccount.deleteAccount()
                // 发送通知，提示用户再次登录(本方法不知道被谁调用，谁接收到通知，谁处理！)
                NotificationCenter.default.post(
                    name: NSNotification.Name(rawValue: EYUserShouldLoginNotification),
                    object: "bad token")
                completion(nil, false)
            } else {
                EYLog("网络请求错误 \(String(describing: data.error))")
                completion(nil, false)
            }
        }
//        Alamofire.request(URLString, method: method == .POST ? .post : .get, parameters: parameters, encoding: encoding).responseJSON { (data) in
//            if data.result.isSuccess {
//                if data.response?.statusCode == 400 && style == .STATUS {
//                    EYLog("Token 过期了")
//                    EYUserAccount.deleteAccount()
//                    // 发送通知，提示用户再次登录(本方法不知道被谁调用，谁接收到通知，谁处理！)
//                    NotificationCenter.default.post(
//                        name: NSNotification.Name(rawValue: EYUserShouldLoginNotification),
//                        object: "bad token")
//                    completion(nil, false)
//                } else if let value = data.value {
//                    EYLog("\n URLString->\(URLString)\n \(value)")
//                    completion(value as AnyObject, true)
//                }
//            } else {
//                EYLog("网络请求错误 \(String(describing: data.error))")
//                completion(nil, false)
//            }
//        }
    }
}
