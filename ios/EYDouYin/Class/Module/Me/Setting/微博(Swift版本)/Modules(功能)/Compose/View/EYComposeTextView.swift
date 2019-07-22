//
//  EYComposeTextView.swift
//  weiboSwift
//
//  Created by apple on 16/7/11.
//  Copyright © 2016年 lieryang. All rights reserved.
//

import UIKit

/// 撰写微博的文本视图
class EYComposeTextView: UITextView {

    /// 占位标签
	lazy var placeholderLabel = UILabel()

    override func awakeFromNib() {
        setupUI()
    }
    
    deinit {
        // 注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - 监听方法
    @objc func textChanged() {
        // 如果有文本，不显示占位标签，否则显示
        placeholderLabel.isHidden = self.hasText
    }
}

// MARK: - 表情键盘专属方法
extension EYComposeTextView {
    
    /// 返回 textView 对应的纯文本的字符串[将属性图片转换成文字]
    var emoticonText: String {
        
        // 1. 获取 textView 的属性文本
        guard let attrStr = attributedText else {
            return ""
        }
        
        // 2. 需要获得属性文本中的图片[附件 Attachment]
        /**
         1> 遍历的范围
         2> 选项 []
         3> 闭包
         */
        var result = String()
        
        attrStr.enumerateAttributes(in: NSRange(location: 0, length: attrStr.length), options: [], using: { (dict, range, _) in
            
            // 如果字典中包含 NSAttachment `Key` 说明是图片，否则是文本
            // 下一个目标：从 attachment 中如果能够获得 chs 就可以了！
            if let attachment = dict[.attachment] as? EYEmoticonAttachment {
                result += attachment.chs ?? ""
            } else {
                let subStr = (attrStr.string as NSString).substring(with: range)
                
                result += subStr
            }
        })
        
        return result
    }
    
    /// 向文本视图插入表情符号[图文混排]
    ///
    /// - parameter em: 选中的表情符号，nil 表示删除
    func insertEmoticon(em: EYEmoticon?) {
        
        // 1. em == nil 是删除按钮
        guard let em = em else {
            
            // 删除文本
            deleteBackward()
            
            return
        }
        
        // 2. emoji 字符串
        if let emoji = em.emoji, let textRange = selectedTextRange {
            
            // UITextRange 仅用在此处！
            replace(textRange, withText: emoji)
            
            return
        }
        
        // 代码执行到此，都是图片表情
        // 0. 获取表情中的图像属性文本
        let imageText = em.imageText(font: font!)
        
        // 1> 获取当前 textView 属性文本 => 可变的
        let attrStrM = NSMutableAttributedString(attributedString: attributedText)
        
        // 2> 将图像的属性文本插入到当前的光标位置
        attrStrM.replaceCharacters(in: selectedRange, with: imageText)
        
        // 3> 重新设置属性文本
        // 记录光标位置
        let range = selectedRange
        
        // 设置文本
        attributedText = attrStrM
        
        // 恢复光标位置，length 是选中字符的长度，插入文本之后，应该为 0
        selectedRange = NSRange(location: range.location + 1, length: 0)
        
        // 4> 让代理执行文本变化方法 - 在需要的时候，通知代理执行协议方法！
        delegate?.textViewDidChange?(self)
        
        // 5> 执行当前对象的 文本变化方法
        textChanged()
    }
}

extension EYComposeTextView {
    
    func setupUI() {
        
        // 0. 注册通知
        // - 通知是一对多，如果其他控件监听当前文本视图的通知，不会影响
        // - 但是如果使用代理，其他控件就无法使用代理监听通知！
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textChanged),
            name: UITextView.textDidChangeNotification,
            object: self)
        
        // 1. 设置占位标签
        placeholderLabel.text = "分享新鲜事..."
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.frame.origin = CGPoint(x: 5, y: 8)
        
        placeholderLabel.sizeToFit()
        
        addSubview(placeholderLabel)
        
//        // 2. 测试代理 - 自己当自己的代理
//        self.delegate = self
    }
}
