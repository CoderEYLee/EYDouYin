//
//  EYComposeTypeButton.swift
//  weiboSwift
//
//  Created by apple on 16/7/8.
//  Copyright © 2016年 lieryang. All rights reserved.
//

import UIKit

// UIControl 内置了 touchupInside 事件响应
class EYComposeTypeButton: UIControl {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    /// 点击按钮要展现控制器的类型
    var clsName: String?
    
    /// 使用图像名称／标题创建按钮，按钮布局从 XIB 加载
    class func composeTypeButton(imageName: String, title: String) -> EYComposeTypeButton {
        
        let nib = UINib(nibName: "EYComposeTypeButton", bundle: nil)
        
        let btn = nib.instantiate(withOwner: nil, options: nil)[0] as! EYComposeTypeButton
        
        btn.imageView.image = UIImage(named: imageName)
        btn.titleLabel.text = title
        
        return btn
    }
}
