//
//  EYEmoticonCell.swift
//  weiboSwift
//
//  Created by lieryang on 2017/5/13.
//  Copyright © 2017年 lieryang. All rights reserved.
//

import UIKit

/// 表情 Cell 的协议
@objc protocol EYEmoticonCellDelegate: NSObjectProtocol {
    
    /// 表情 cell 选中表情模型
    ///
    /// - parameter em: 表情模型／nil 表示删除
    func emoticonCellDidSelectedEmoticon(cell: EYEmoticonCell, em: EYEmoticon?)
}

/// 表情的页面 Cell
/// - 每一个 cell 就是和 collectionView 一样大小
/// - 每一个 cell 中用九宫格的算法，自行添加 20 个表情
/// - 最后一个位置放置删除按钮
class EYEmoticonCell: UICollectionViewCell {
    
    /// 代理
    weak var delegate: EYEmoticonCellDelegate?
    
    /// 当前页面的表情模型数组，`最多` 20 个
    var emoticons: [EYEmoticon]? {
        didSet {
            EYLog("表情包的数量 \(String(describing: emoticons?.count))")
            // 1. 隐藏所有的按钮
            for v in contentView.subviews {
                v.isHidden = true
            }
            // 显示删除按钮
            contentView.subviews.last?.isHidden = false
            
            // 2. 遍历表情模型数组，设置按钮图像
            for (i, em) in (emoticons ?? []).enumerated() {
                
                // 1> 取出按钮
                if let btn = contentView.subviews[i] as? UIButton {
                    
                    // 设置图像 - 如果图像为 nil 会清空图像，避免复用
                    btn.setImage(em.image, for: [])
                    
                    // 设置 emoji 的字符串 - 如果 emoji 为 nil 会清空 title，避免复用
                    btn.setTitle(em.emoji, for: [])
                    
                    btn.isHidden = false
                }
            }
        }
    }
    
    /// 表情选择提示视图
    private lazy var tipView = EYEmoticonTipView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 当视图从界面上删除，同样会调用此方法，newWindow == nil
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        
        guard let w = newWindow else {
            return
        }
        
        // 将提示视图添加到窗口上
        // 提示：在 iOS 6.0之前，很多程序员都喜欢把控件往窗口添加
        // 在现在开发，如果有地方，就不要用窗口！
        w.addSubview(tipView)
        tipView.isHidden = true
    }
    
    // MARK: - 监听方法
    /// 选中表情按钮
    @objc func selectedEmoticonButton(button: UIButton) {
        
        // 1. 取 tag 0~20 20 对应的是删除按钮
        let tag = button.tag
        
        // 2. 根据 tag 判断是否是删除按钮，如果不是删除按钮，取得表情
        var em: EYEmoticon?
        if tag < (emoticons?.count)! {
            em = emoticons?[tag]
        }
        
        // 3. em 要么是选中的模型，如果为 nil 对应的是删除按钮
        // EYLog(em)
        delegate?.emoticonCellDidSelectedEmoticon(cell: self, em: em)
    }
    
    /// 长按手势识别 - 是一个非常非常重要的手势
    /// 可以保证一个对象监听两种点击手势！而且不需要考虑解决手势冲突！
    @objc func longGesture(gesture: UILongPressGestureRecognizer) {
        
        // 测试添加提示视图
        // addSubview(tipView)
        
        // 1> 获取触摸位置
        let location = gesture.location(in: self)
        
        // 2> 获取触摸位置对应的按钮
        guard let button = buttonWithLocation(location: location) else {
            
            tipView.isHidden = true
            
            return
        }
        
        // 3> 处理手势状态
        // 在处理手势细节的时候，不要试图一下把所有状态都处理完毕！
        switch gesture.state {
        case .began, .changed:
            
            tipView.isHidden = false
            
            // 坐标系的转换 -> 将按钮参照 cell 的坐标系，转换到 window 的坐标位置
            let center = self.convert(button.center, to: window)
            
            // 设置提示视图的位置
            tipView.center = center
            
            // 设置提示视图的表情模型
            if button.tag < (emoticons?.count)! {
                tipView.emoticon = emoticons?[button.tag]
            }
        case .ended:
            tipView.isHidden = true
            
            // 执行选中按钮的函数
            selectedEmoticonButton(button: button)
        case .cancelled, .failed:
            tipView.isHidden = true
        default:
            break
        }
    }
    
    private func buttonWithLocation(location: CGPoint) -> UIButton? {
        
        // 遍历 contentView 所有的子视图，如果可见，同时在 location 确认是按钮
        for btn in contentView.subviews as! [UIButton] {
            
            // 删除按钮同样需要处理
            if btn.frame.contains(location) && !btn.isHidden && btn != contentView.subviews.last {
                return btn
            }
        }
        
        return nil
    }
}

// MARK: - 设置界面
private extension EYEmoticonCell {
    
    // - 从 XIB 加载，bounds 是 XIB 中定义的大小，不是 size 的大小
    // - 从纯代码创建，bounds 是就是布局属性中设置的 itemSize
    func setupUI() {
        let rowCount = 3
        let colCount = 7
        
        // 左右间距
        let leftMargin: CGFloat = 8
        // 底部间距，为分页控件预留空间
        let bottomMargin: CGFloat = 16
        
        let w = (bounds.width - 2 * leftMargin) / CGFloat(colCount)
        let h = (bounds.height - bottomMargin) / CGFloat(rowCount)
        
        // 连续创建 21 个按钮
        for i in 0..<21 {
            let row = i / colCount
            let col = i % colCount
            
            let btn = UIButton()
            
            // 设置按钮的大小
            let x = leftMargin + CGFloat(col) * w
            let y = CGFloat(row) * h
            
            btn.frame = CGRect(x: x, y: y, width: w, height: h)
            
            contentView.addSubview(btn)
            
            // 设置按钮的字体大小，lineHeight 基本上和图片的大小差不多！
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
            
            // 设置按钮的 tag
            btn.tag = i
            // 添加监听方法
            btn.addTarget(self, action: #selector(selectedEmoticonButton), for: .touchUpInside)
        }
        
        // 取出末尾的删除按钮
        let removeButton = contentView.subviews.last as! UIButton
        
        // 设置图像
        let image = UIImage(named: "compose_emotion_delete_highlighted", in: EYEmoticonManager.shared.bundle, compatibleWith: nil)
        removeButton.setImage(image, for: [])
        
        // 添加长按手势
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longGesture))
        
        longPress.minimumPressDuration = 0.1
        addGestureRecognizer(longPress)
    }
}
