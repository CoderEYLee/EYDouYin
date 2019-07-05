//
//  EYEmoticonToolbar.swift
//  weiboSwift
//
//  Created by lieryang on 2017/5/13.
//  Copyright © 2017年 lieryang. All rights reserved.
//

import UIKit

@objc protocol EYEmoticonToolbarDelegate: NSObjectProtocol {
    
    /// 表情工具栏选中分组项索引
    ///
    /// - parameter toolbar: 工具栏
    /// - parameter index:   索引
    func emoticonToolbarDidSelectedItemIndex(toolbar: EYEmoticonToolbar, index: Int)
}

/// 表情键盘底部工具栏
class EYEmoticonToolbar: UIView {

    /// 代理
    weak var delegate: EYEmoticonToolbarDelegate?
    
    /// 选中分组索引
    var selectedIndex: Int = 0 {
        didSet {
            
            // 1. 取消所有的选中状态
            for btn in subviews as! [UIButton] {
                btn.isSelected = false
            }
            
            // 2. 设置 index 对应的选中状态
            (subviews[selectedIndex] as! UIButton).isSelected = true
        }
    }
    
    override func awakeFromNib() {
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 布局所有按钮
        let count = subviews.count
        let w = bounds.width / CGFloat(count)
        let rect = CGRect(x: 0, y: 0, width: w, height: bounds.height)
        
        for (i, btn) in subviews.enumerated() {
            
            btn.frame = rect.offsetBy(dx: CGFloat(i) * w, dy: 0)
        }
    }
    
    // MARK: - 监听方法
    /// 点击分组项按钮
    @objc func clickItem(button: UIButton) {
        
        // 通知代理执行协议方法
        delegate?.emoticonToolbarDidSelectedItemIndex(toolbar: self, index: button.tag)
    }
}

private extension EYEmoticonToolbar {
    
    func setupUI() {
        
        // 0. 获取表情管理器单例
        let manager = EYEmoticonManager.shared
        
        // 从表情包的分组名称 -> 设置按钮
        for (i, p) in manager.packages.enumerated() {
            
            // 1> 实例化按钮
            let btn = UIButton()
            
            // 2> 设置按钮状态
            btn.setTitle(p.groupName, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.setTitleColor(UIColor.darkGray, for: .highlighted)
            btn.setTitleColor(UIColor.darkGray, for: .selected)
         
            // 设置按钮的背景图片
            let imageName = "compose_emotion_table_\(p.bgImageName ?? "")_normal"
            let imageNameHL = "compose_emotion_table_\(p.bgImageName ?? "")_selected"
            
            var image = UIImage(named: imageName, in: manager.bundle, compatibleWith: nil)
            var imageHL = UIImage(named: imageNameHL, in: manager.bundle, compatibleWith: nil)
            
            // 拉伸图像
            let size = image?.size ?? CGSize()
            let inset = UIEdgeInsets(top: size.height * 0.5,
                                     left: size.width * 0.5,
                                     bottom: size.height * 0.5,
                                     right: size.width * 0.5)
            
            image = image?.resizableImage(withCapInsets: inset)
            imageHL = imageHL?.resizableImage(withCapInsets: inset)
            
            btn.setBackgroundImage(image, for: .normal)
            btn.setBackgroundImage(imageHL, for: .highlighted)
            btn.setBackgroundImage(imageHL, for: .selected)
            
            btn.sizeToFit()
            
            // 3> 添加按钮
            addSubview(btn)
            
            // 4> 设置按钮的 tag
            btn.tag = i
            
            // 5> 添加按钮的监听方法
            btn.addTarget(self, action: #selector(clickItem), for: .touchUpInside)
        }
        
        // 默认选中第0个按钮
        (subviews[0] as! UIButton).isSelected = true
    }
}
