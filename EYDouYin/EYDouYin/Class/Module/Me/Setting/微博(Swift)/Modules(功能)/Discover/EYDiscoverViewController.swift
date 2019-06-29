//
//  EYDiscoverViewController.swift
//  weiboSwift
//
//  Created by lieryang on 16/6/29.
//  Copyright © 2016年 lieryang. All rights reserved.
//

import UIKit

class EYDiscoverViewController: EYBaseSwiftViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let parameters = ["email" : "18661729897",
                          "password" : "123456"]
//        let parameters = ["email" : "zhangxf@eastsoft.com.cn",
//                          "password" : "123456"]

        EYNetworkManager.shared.login(parameters: parameters) { (json, isSuccess) in
            EYLog("-----------------\(json ?? [])--\(isSuccess)")
        }
    }
}
