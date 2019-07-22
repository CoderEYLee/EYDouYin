//
//  EYStatusCell.swift
//  weiboSwift
//
//  Created by lieryang on 16/7/5.
//  Copyright © 2016年 lieryang. All rights reserved.
//

import UIKit

/// 微博 Cell 的协议
/// 如果需要设置可选协议方法
/// - 需要遵守 NSObjectProtocol 协议
/// - 协议需要是 @objc 的
/// - 方法需要 @objc optional
@objc protocol EYStatusCellDelegate: NSObjectProtocol {
    
    /// 微博 Cell 选中 URL 字符串
    @objc optional func statusCellDidSelectedURLString(cell: EYStatusCell, urlString: String)
}

/// 微博 Cell
class EYStatusCell: UITableViewCell {

    /// 代理属性
    weak var delegate: EYStatusCellDelegate?
    
    /// 微博视图模型
    var viewModel: EYStatusViewModel? {
        didSet {
            // 微博文本
            statusLabel.attributedText = viewModel?.statusAttrText
            // 设置被转发微博的文字
            retweetedLabel?.attributedText = viewModel?.retweetedAttrText
            
            // 姓名
            nameLabel.text = viewModel?.status.user?.screen_name
            
            // 设置会员图标 - 直接获取属性，不需要计算
            memberIconView.image = viewModel?.memberIcon
            // 认证图标
            vipIconView.image = viewModel?.vipIcon
            
            // 用户头像
            iconView.ey_setImage(urlString: viewModel?.status.user?.profile_image_url,
                                 placeholderImage: UIImage(named: "avatar_default_big"),
                                 isAvatar: true)
            
            // 底部工具栏
            toolBar.viewModel = viewModel
            
            // 配图视图视图模型
            pictureView.viewModel = viewModel
            
            // 设置来源
            sourceLabel.text = viewModel?.status.source
            
            // 设置时间
            timeLabel.text = viewModel?.status.createdDate?.ey_dateDescription
        }
    }
    
    /// 头像
    @IBOutlet weak var iconView: UIImageView!
    /// 姓名
    @IBOutlet weak var nameLabel: UILabel!
    /// 会员图标
    @IBOutlet weak var memberIconView: UIImageView!
    /// 时间
    @IBOutlet weak var timeLabel: UILabel!
    /// 来源
    @IBOutlet weak var sourceLabel: UILabel!
    /// 认证图标
    @IBOutlet weak var vipIconView: UIImageView!
    /// 微博正文
    @IBOutlet weak var statusLabel: FFLabel!
    /// 底部工具栏
    @IBOutlet weak var toolBar: EYStatusToolBar!
    
    /// 配图视图
    @IBOutlet weak var pictureView: EYStatusPictureView!
    
    /// 被转发微博的标签 - 原创微博没有此控件，一定要用 `?`
    @IBOutlet weak var retweetedLabel: FFLabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        // 离屏渲染 - 异步绘制
        self.layer.drawsAsynchronously = true
        
        // 栅格化 - 异步绘制之后，会生成一张独立的图像，cell在屏幕上滚动的时候，本质上滚动的是这张图片
        // cell 优化，要尽量减少图层的数量，相当于就只有一层！
        // 停止滚动之后，可以接收监听
        self.layer.shouldRasterize = true
        
        // 使用 `栅格化` 必须注意指定分辨率
        self.layer.rasterizationScale = UIScreen.main.scale
        
        // 设置微博文本代理
        statusLabel.delegate = self
        retweetedLabel?.delegate = self
    }
}

extension EYStatusCell: FFLabelDelegate {
    
    func labelDidSelectedLinkText(label: FFLabel, text: String) {
        
        // 判断是否是 URL 
        if !text.hasPrefix("http://") {
            return
        }
        
        // 插入 ? 表示如果代理没有实现协议方法，就什么都不做
        // 如果使用 !，代理没有实现协议方法，仍然强行执行，会崩溃！
        delegate?.statusCellDidSelectedURLString?(cell: self, urlString: text)
    }
}
