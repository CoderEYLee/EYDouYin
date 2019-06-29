//
//  EYEmoticon.swift
//  weiboSwift
//
//  Created by lieryang on 2017/5/13.
//  Copyright © 2017年 lieryang. All rights reserved.
//

import UIKit
import YYModel

/// 表情模型
class EYEmoticon: NSObject {

    /// 表情类型 false - 图片表情 / true - emoji
    @objc
    var type = false
    /// 表情字符串，发送给新浪微博的服务器(节约流量)
    @objc
    var chs: String?
    /// 表情图片名称，用于本地图文混排
    @objc
    var png: String?
    /// emoji 的十六进制编码
    @objc
    var code: String? {
        didSet {
            
            guard let code = code else {
                return
            }
            
            let scanner = Scanner(string: code)
            
            var result: UInt32 = 0
            scanner.scanHexInt32(&result)
            
            emoji = String(Character(UnicodeScalar(result)!))
        }
    }
    /// 表情使用次数
    var times: Int = 0
    /// emoji 的字符串
    var emoji: String?
    
    /// 表情模型所在的目录
    var directory: String?
    
    /// `图片`表情对应的图像
    var image: UIImage? {
        
        // 判断表情类型
        if type {
            return nil
        }
        
        guard let directory = directory,
            let png = png,
            let path = Bundle.main.path(forResource: "EYEmoticon.bundle", ofType: nil),
            let bundle = Bundle(path: path)
            else {
                return nil
        }
    
        return UIImage(named: "\(directory)/\(png)", in: bundle, compatibleWith: nil)
    }
    
    /// 将当前的图像转换生成图片的属性文本
    func imageText(font: UIFont) -> NSAttributedString {
        
        // 1. 判断图像是否存在
        guard let image = image else {
            return NSAttributedString(string: "")
        }
        
        // 2. 创建文本附件
        let attachment = EYEmoticonAttachment()
        
        // 记录属性文本文字
        attachment.chs = chs
        
        attachment.image = image
        let height = font.lineHeight
        attachment.bounds = CGRect(x: 0, y: -4, width: height, height: height)
        
        // 3. 返回图片属性文本
        let attrStrM = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attachment))
        
        // 设置字体属性
        attrStrM.addAttributes([.font: font], range: NSRange(location: 0, length: 1))
        
        // 4. 返回属性文本
        return attrStrM
    }
    
    override var description: String {
        return yy_modelDescription()
    }
}
