//
//  EYOAuthViewController.swift
//  weiboSwift
//
//  Created by lieryang on 16/7/2.
//  Copyright © 2016年 lieryang. All rights reserved.
//

import UIKit
import SVProgressHUD

/// 通过 webView 加载新浪微博授权页面控制器
class EYOAuthViewController: UIViewController {

    private lazy var webView = UIWebView()
    
    override func loadView() {
        view = webView
        
        view.backgroundColor = UIColor.white
        
        // 取消滚动视图 - 新浪微博的服务器，返回的授权页面默认就是手机全屏
        webView.scrollView.isScrollEnabled = false
        
        // 设置代理
        webView.delegate = self
        
        // 设置导航栏
        title = "登录新浪微博"
        // 导航栏按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: #selector(close), isBack: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", target: self, action: #selector(autoFill))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 加载授权页面
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(EYAppKey)&redirect_uri=\(EYRedirectURI)"
        
        // 1> URL 确定要访问的资源
        guard let url = URL(string: urlString) else {
            return
        }
        
        // 2> 建立请求
        let request = URLRequest(url: url)
        
        // 3> 加载请求
        webView.loadRequest(request)
    }
    
    // MARK: - 监听方法
    /// 关闭控制器
    @objc func close() {
        SVProgressHUD.dismiss()
        
        dismiss(animated: true, completion: nil)
    }
    
    /// 自动填充 - WebView 的注入，直接通过 js 修改 `本地浏览器中` 缓存的页面内容
    /// 点击登录按钮，执行 submit() 将本地数据提交给服务器！
    @objc private func autoFill() {
        
        // 准备 js
        let js = "document.getElementById('userId').value = '1140524735@qq.com'; " +
            "document.getElementById('passwd').value = 'xinlangweibo';"
        
        // 让 webview 执行 js
        webView.stringByEvaluatingJavaScript(from: js)
    }
}

extension EYOAuthViewController: UIWebViewDelegate {
    
    /// webView 将要加载请求
    ///
    /// - parameter webView:        webView
    /// - parameter request:        要加载的请求
    /// - parameter navigationType: 导航类型
    ///
    /// - returns: 是否加载 request
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        
        // 确认思路：
        // 1. 如果请求地址包含 http://baidu.com 不加载页面 ／ 否则加载页面
        // request.url?.absoluteString?.hasPrefix(EYRedirectURI) 返回的是可选项 true/false/nil
        if request.url?.absoluteString.hasPrefix(EYRedirectURI) == false {
            return true
        }
        
        // EYLog("加载请求 --- \(request.url?.absoluteString)")
        // query 就是 URL 中 `?` 后面的所有部分
        // EYLog("加载请求 --- \(request.url?.query)")
        // 2. 从 http://baidu.com 回调地址的`查询字符串`中查找 `code=`
        //    如果有，授权成功，否则，授权失败
        if request.url?.query?.hasPrefix("code=") == false {
            
            EYLog("取消授权")
            close()
            
            return false
        }
        
        // 3. 从 query 字符串中取出 授权码 
        // 代码走到此处，url 中一定有 查询字符串，并且 包含 `code=`
        // code=15be12d79321e474c599210ef637c978
        //        let newStr = String(str[..<index]) // = str.substring(to: index) In Swift 3
        //        let newStr = String(str[index...]) // = str.substring(from: index) In Swif 3
        //        let newStr = String(str[range]) // = str.substring(with: range) In Swift 3
        
//        let code = request.url?.query?.substring(from: "code=".endIndex) ?? ""
        let code = String(request.url?.query?["code=".endIndex...] ?? "")
        
        EYLog("授权码 - \(code)")
        // 4. 使用授权码获取[换取] AccessToken
        EYNetworkManager.shared.loadAccessToken(code: code) { (isSuccess) in
            
            if !isSuccess {
                SVProgressHUD.showInfo(withStatus: "网络请求失败")
            } else {
                
                // 下一步做什么？跳转`界面` 通过通知发送登录成功消息
                // 1> 发送通知 - 不关心有没有监听者
                NotificationCenter.default.post(
                    name: NSNotification.Name(rawValue: EYUserLoginSuccessedNotification),
                    object: nil)
                
                // 2> 关闭窗口
                self.close()
            }
        }
        
        return false
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}
