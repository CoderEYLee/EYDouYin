//
//  EYWebViewController.swift
//  weiboSwift
//
//  Created by lieryang on 16/7/10.
//  Copyright © 2016年 lieryang. All rights reserved.
//

import UIKit

/// 网页控制器
class EYWebViewController: EYBaseViewController {

	lazy var webView = UIWebView(frame: UIScreen.main.bounds)
    
    /// 要加载的 URL 字符串
    var urlString: String? {
        didSet {
            
            guard let urlString = urlString,
                let url = URL(string: urlString)
                else {
                    return
            }
            
            webView.loadRequest(URLRequest(url: url))
        }
    }
}

extension EYWebViewController {
    
    override func setupTableView() {
        
        // 设置标题
        navItem.title = "网页"
        
        // 设置 webView
        view.insertSubview(webView, belowSubview: navigationBar)
        
        webView.backgroundColor = UIColor.white
        
        // 设置 contentInset
        webView.scrollView.contentInset.top = navigationBar.bounds.height
    }
}
