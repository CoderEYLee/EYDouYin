//
//  EYNavigationController.swift
//  weiboSwift
//
//  Created by lieryang on 16/6/29.
//  Copyright © 2016年 lieryang. All rights reserved.
//

import UIKit

class EYNavigationSwiftController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// 重写 push 方法，所有的 push 动作都会调用此方法！
    /// viewController 是被 push 的控制器，设置他的左侧的按钮作为返回按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 如果不是栈底控制器才需要隐藏，根控制器不需要处理
        if children.count > 0 {
            // 隐藏底部的 TabBar
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: true)
    }
}
