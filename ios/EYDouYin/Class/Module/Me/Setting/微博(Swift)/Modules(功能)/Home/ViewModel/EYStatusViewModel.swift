//
//  EYStatusViewModel.swift
//  weiboSwift
//
//  Created by lieryang on 16/7/5.
//  Copyright © 2016年 lieryang. All rights reserved.
//

import Foundation
import UIKit

/// 单条微博的视图模型
/**
 如果没有任何父类，如果希望在开发时调试，输出调试信息，需要 
 1. 遵守 CustomStringConvertible
 2. 实现 description 计算型属性
 
 关于表格的性能优化
 
 - 尽量少计算，所有需要的素材提前计算好！
 - 控件上不要设置圆角半径，所有图像渲染的属性，都要注意！
 - 不要动态创建控件，所有需要的控件，都要提前创建好，在显示的时候，根据数据隐藏／显示！
 - Cell 中控件的层次越少越好，数量越少越好！
 - 要测量，不要猜测！
 */
class EYStatusViewModel: CustomStringConvertible {
    
    /// 微博模型
    var status: EYStatus
    
    /// 会员图标 - 存储型属性(用内存换 CPU)
    var memberIcon: UIImage?
    /// 认证类型，-1：没有认证，0，认证用户，2,3,5: 企业认证，220: 达人
    var vipIcon: UIImage?
    /// 转发文字
    var retweetedStr: String?
    /// 评论文字
    var commentStr: String?
    /// 点赞文字
    var likeStr: String?
    
    /// 配图视图大小
    var pictureViewSize = CGSize()
    
    /// 如果是被转发的微博，原创微博一定没有图
    var picURLs: [EYStatusPicture]? {
        // 如果有被转发的微博，返回被转发微博的配图
        // 如果没有被转发的微博，返回原创微博的配图
        // 如果都没有，返回 nil
        return status.retweeted_status?.pic_urls ?? status.pic_urls
    }
    
    /// 微博正文的属性文本
    var statusAttrText: NSAttributedString?
    /// 转发文字的属性文本
    var retweetedAttrText: NSAttributedString?
    
    /// 行高
    var rowHeight: CGFloat = 0
    
    /// 构造函数
    ///
    /// - parameter model: 微博模型
    ///
    /// - returns: 微博的视图模型
    init(model: EYStatus) {
        self.status = model
        
        // 直接计算出会员图标/会员等级 0-6
        if (model.user?.mbrank)! > 0 && (model.user?.mbrank)! < 7 {
            let imageName = "common_icon_membership_level\(model.user?.mbrank ?? 1)"
            
            memberIcon = UIImage(named: imageName)
        }
        
        // 认证图标
        switch model.user?.verified_type ?? -1 {
        case 0:
            vipIcon = UIImage(named: "avatar_vip")
        case 2, 3, 5:
            vipIcon = UIImage(named: "avatar_enterprise_vip")
        case 220:
            vipIcon = UIImage(named: "avatar_grassroot")
        default:
            break
        }
        
        // 设置底部计数字符串
        // 测试超过一万的数字
        // model.reposts_count = Int(arc4random_uniform(100000))
        retweetedStr = countString(count: model.reposts_count, defaultStr: "转发")
        commentStr = countString(count: model.comments_count, defaultStr: "评论")
        likeStr = countString(count: model.attitudes_count, defaultStr: "赞")
        
        // 计算配图视图大小（有原创的就计算原创的，有转发的就计算转发的）
        pictureViewSize = calcPictureViewSize(count: picURLs?.count)
        
        // --- 设置微博文本 ---
        let originalFont = UIFont.systemFont(ofSize: 15)
        let retweetedFont = UIFont.systemFont(ofSize: 14)
        
        // 微博正文的属性文本
        statusAttrText = EYEmoticonManager.shared.emoticonString(string: model.text ?? "", font: originalFont)
        
        // 设置被转发微博的属性文本
        var rText = "@" + (status.retweeted_status?.user?.screen_name ?? "")
        rText = rText + ":" + (status.retweeted_status?.text ?? "")
        
        retweetedAttrText = EYEmoticonManager.shared.emoticonString(string: rText, font: retweetedFont)
        
        // 计算行高
        updateRowHeight()
    }
    
    var description: String {
        return status.description
    }
    
    /// 根据当前的视图模型内容计算行高
    func updateRowHeight() {
        // 原创微博：顶部分隔视图(12) + 间距(12) + 图像的高度(34) + 间距(12) + 正文高度(需要计算) + 配图视图高度(计算) + 间距(12) ＋ 底部视图高度(35)
        // 被转发微博：顶部分隔视图(12) + 间距(12) + 图像的高度(34) + 间距(12) + 正文高度(需要计算) + 间距(12)+间距(12)+转发文本高度(需要计算) + 配图视图高度(计算) + 间距(12) ＋ 底部视图高度(35)
        let margin: CGFloat = 12
        let iconHeight: CGFloat = 34
        let toolbarHeight: CGFloat = 35
        
        var height: CGFloat = 0
        
        let viewSize = CGSize(width: EYScreenWidth - 2 * margin, height: CGFloat(MAXFLOAT))
        
        // 1. 计算顶部位置
        height = 2 * margin + iconHeight + margin
        
        // 2. 正文属性文本的高度
        if let text = statusAttrText {
            
            height += text.boundingRect(with: viewSize, options: [.usesLineFragmentOrigin], context: nil).height
        }
        
        // 3. 判断是否转发微博
        if status.retweeted_status != nil {
            
            height += 2 * margin
            
            // 转发文本的高度 - 一定用 retweetedText，拼接了 @用户名:微博文字
            if let text = retweetedAttrText {
                
                height += text.boundingRect(with: viewSize, options: [.usesLineFragmentOrigin], context: nil).height
            }
        }
        
        // 4. 配图视图
        height += pictureViewSize.height
        
        height += margin
        
        // 5. 底部工具栏
        height += toolbarHeight
        
        // 6. 使用属性记录
        rowHeight = height
    }
    
    /// 使用单个图像，更新配图视图的大小
    ///
    /// 新浪针对单张图片，都是缩略图，但是偶尔会有一张特别大的图 7000 * 9000 多
    /// 新浪微博，为了鼓励原创，支持`长微博`，但是有的时候，有特别长的微博，长到宽度只有1个点
    ///
    /// - parameter image: 网路缓存的单张图像
    func updateSingleImageSize(image: UIImage) {
        
        var size = image.size
        
        let maxWidth: CGFloat = 200
        let minWidth: CGFloat = 40
        
        // 过宽图像处理
        if size.width > maxWidth {
            // 设置最大宽度
            size.width = 200
            // 等比例调整高度
            size.height = size.width * image.size.height / image.size.width
        }
        
        // 过窄图像处理
        if size.width < minWidth {
            size.width = minWidth
            
            // 要特殊处理高度，否则高度太大，会印象用户体验
            size.height = size.width * image.size.height / image.size.width / 4
        }
        
        // 过高图片处理，图片填充模式就是 scaleToFill，高度减小，会自动裁切
        if size.height > 200 {
            size.height = 200
        }
        
        // 特例：有些图像，本身就是很窄，很长！-> 定义一个 minHeight，思路同上！
        // 在工作中，如果看到代码中有些疑惑的分支处理！千万不要动！
        
        // 注意，尺寸需要增加顶部的 12 个点，便于布局
        size.height += EYStatusPictureViewOutterMargin
        
        // 重新设置配图视图大小
        pictureViewSize = size
        
        // 更新行高
        updateRowHeight()
    }
    
    /// 计算指定数量的图片对应的配图视图的大小
    ///
    /// - parameter count: 配图数量
    ///
    /// - returns: 配图视图的大小
    private func calcPictureViewSize(count: Int?) -> CGSize {
        
        if count == 0 || count == nil {
            return CGSize()
        }
        
        // 计算高度
        // 1> 根据 count 知道行数 1 ~ 9
        /**
            1 2 3 = 0 1 2 / 3 = 0 + 1 = 1
            4 5 6 = 3 4 5 / 3 = 1 + 1 = 2
            7 8 9 = 6 7 8 / 3 = 2 + 1 = 3
        */
        let row = (count! - 1) / 3 + 1
        
        // 2> 根据行数算高度
        var height = EYStatusPictureViewOutterMargin
        height += CGFloat(row) * EYStatusPictureItemWidth
        height += CGFloat(row - 1) * EYStatusPictureViewInnerMargin
        
        return CGSize(width: EYStatusPictureViewWidth, height: height)
    }
    
    /// 给定义一个数字，返回对应的描述结果
    ///
    /// - parameter count:      数字
    /// - parameter defaultStr: 默认字符串，转发／评论／赞
    ///
    /// - returns: 描述结果
    /**
     如果数量 == 0，显示默认标题
     如果数量超过 10000，显示 x.xx 万
     如果数量 < 10000，显示实际数字
     */
    private func countString(count: Int, defaultStr: String) -> String {
        
        if count == 0 {
            return defaultStr
        }
        
        if count < 10000 {
            return count.description
        }
        
        return String(format: "%.02f 万", Double(count) / 10000)
    }
}
