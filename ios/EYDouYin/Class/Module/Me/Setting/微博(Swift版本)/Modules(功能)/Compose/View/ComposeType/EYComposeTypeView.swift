//
//  EYComposeTypeView.swift
//  weiboSwift
//
//  Created by lieryang on 16/7/8.
//  Copyright © 2016年 lieryang. All rights reserved.
//

import UIKit
import pop

/// 撰写微博类型视图
class EYComposeTypeView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    /// 关闭按钮约束
    @IBOutlet weak var closeButtonCenterXCons: NSLayoutConstraint!
    /// 返回前一页按钮约束
    @IBOutlet weak var returnButtonCenterXCons: NSLayoutConstraint!
    /// 返回前一页按钮
    @IBOutlet weak var returnButton: UIButton!
    
    /// 按钮数据数组
	let buttonsInfo = [["imageName": "tabbar_compose_idea", "title": "文字", "clsName": "EYComposeViewController"],
                               ["imageName": "tabbar_compose_photo", "title": "照片/视频"],
                               ["imageName": "tabbar_compose_weibo", "title": "长微博"],
                               ["imageName": "tabbar_compose_lbs", "title": "签到"],
                               ["imageName": "tabbar_compose_review", "title": "点评"],
                               ["imageName": "tabbar_compose_more", "title": "更多", "actionName": "clickMore"],
                               ["imageName": "tabbar_compose_friend", "title": "好友圈"],
                               ["imageName": "tabbar_compose_wbcamera", "title": "微博相机"],
                               ["imageName": "tabbar_compose_music", "title": "音乐"],
                               ["imageName": "tabbar_compose_shooting", "title": "拍摄"]
    ]
    
    /// 完成回调
    private var completionBlock: ((String?)->())?
    
    // MARK: - 实例化方法
    class func composeTypeView() -> EYComposeTypeView {
        
        let nib = UINib(nibName: "EYComposeTypeView", bundle: nil)
        
        // 从 XIB 加载完成视图，就会调用 awakeFromNib
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! EYComposeTypeView
        
        // XIB 加载默认 600 * 600
        v.frame = UIScreen.main.bounds
        
        v.setupUI()
        
        return v
    }
    
    /// 显示当前视图
    /// OC 中的 block 如果当前方法，不能执行，通常使用属性记录，再需要的时候执行
    func show(completion: @escaping (String?)->()) {
        
        // 0> 记录闭包
        completionBlock = completion
        
        // 1> 将当前视图添加到 根视图控制器的 view
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        
        // 2> 添加视图
        vc.view.addSubview(self)
        
        // 3> 开始动画
        showCurrentView()
    }
    
    // MARK: - 监听方法
    @objc func clickButton(selectedButton: EYComposeTypeButton) {
        
        // 1. 判断当前显示的视图
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        let v = scrollView.subviews[page]
        
        // 2. 遍历当前视图
        // - 选中的按钮放大
        // - 为选中的按钮缩小
        for (i, btn) in v.subviews.enumerated() {
            
            // 1> 缩放动画
            let scaleAnim: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
            
            // x,y 在系统中使用 CGPoint 表示，如果要转换成 id，需要使用 `NSValue` 包装
            let scale = (selectedButton == btn) ? 2 : 0.2
            
            scaleAnim.toValue = NSValue(cgPoint: CGPoint(x: scale, y: scale))
            scaleAnim.duration = 0.5
            
            btn.pop_add(scaleAnim, forKey: nil)
            
            // 2> 渐变动画 - 动画组
            let alphaAnim: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            
            alphaAnim.toValue = 0.2
            alphaAnim.duration = 0.5
            
            btn.pop_add(alphaAnim, forKey: nil)
            
            // 3> 添加动画监听
            
            if i == 0 {
                alphaAnim.completionBlock = { _, _ in
                    // 需要执行回调
                    EYLog("完成回调展现控制器")

                    // 执行完成闭包
                    self.completionBlock?(selectedButton.clsName)
                }
            }
        }
    }
    
    /// 点击更多按钮
    @objc private func clickMore() {
        EYLog("点击更多")
        // 1> 将 scrollView 滚动到第二页
        let offset = CGPoint(x: scrollView.bounds.width, y: 0)
        scrollView.setContentOffset(offset, animated: true)
        
        // 2> 处理底部按钮，让两个按钮分开
        returnButton.isHidden = false
        
        let margin = scrollView.bounds.width / 6
        
        closeButtonCenterXCons.constant += margin
        returnButtonCenterXCons.constant -= margin
        
        UIView.animate(withDuration: 0.25) { 
            self.layoutIfNeeded()
        }
    }
    
    @IBAction func clickReturn() {
        
        // 1. 将滚动视图滚动到第 1 页
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
        // 2. 让两个按钮合并
        closeButtonCenterXCons.constant = 0
        returnButtonCenterXCons.constant = 0
        
        UIView.animate(withDuration: 0.25, animations: {
            self.layoutIfNeeded()
            self.returnButton.alpha = 0
            }) { _ in
                self.returnButton.isHidden = true
                self.returnButton.alpha = 1
        }
    }
    
    /// 关闭视图
    @IBAction func close() {
        // removeFromSuperview()
        hideButtons()
    }
}

// MARK: - 动画方法扩展
private extension EYComposeTypeView {
    
    // MARK: - 消除动画
    /// 隐藏按钮动画
	func hideButtons() {
        
        // 1. 根据 contentOffset 判断当前显示的子视图
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        let v = scrollView.subviews[page]
        
        // 2. 遍历 v 中的所有按钮
        for (i, btn) in v.subviews.enumerated().reversed() {
            
            // 1> 创建动画
            let anim: POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            
            // 2> 设置动画属性
            anim.fromValue = btn.center.y
            anim.toValue = btn.center.y + 400
            
            // 设置时间
            anim.beginTime = CACurrentMediaTime() + CFTimeInterval(v.subviews.count - i) * 0.025
            
            // 3> 添加动画
            btn.layer.pop_add(anim, forKey: nil)
            
            // 4> 监听第 0 个按钮的动画，是最后一个执行的
            if i == 0 {
                anim.completionBlock = { _, _ in
                    self.hideCurrentView()
                }
            }
        }
    }
    
    /// 隐藏当前视图
    private func hideCurrentView() {
        
        // 1> 创建动画
        let anim: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        
        anim.fromValue = 1
        anim.toValue = 0
        anim.duration = 0.25
        
        // 2> 添加到视图
        pop_add(anim, forKey: nil)
        
        // 3> 添加完成监听方法
        anim.completionBlock = { _, _ in
            self.removeFromSuperview()
        }
    }
    
    // MARK: - 显示部分的动画
    /// 动画显示当前视图
	func showCurrentView() {
        
        // 1> 创建动画
        let anim: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        
        anim.fromValue = 0
        anim.toValue = 1
        anim.duration = 0.25
        
        // 2> 添加到视图
        pop_add(anim, forKey: nil)
        
        // 3> 添加按钮的动画
        showButtons()
    }
    
    /// 弹力显示所有的按钮
    private func showButtons() {
        
        // 1. 获取 scrollView 的子视图的第 0 个视图
        let v = scrollView.subviews[0]
        
        // 2. 遍历 v 中的所有按钮
        for (i, btn) in v.subviews.enumerated() {
            
            // 1> 创建动画
            let anim: POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            
            // 2> 设置动画属性
            anim.fromValue = btn.center.y + 400
            anim.toValue = btn.center.y
            
            // 弹力系数，取值范围 0~20，数值越大，弹性越大，默认数值为4
            anim.springBounciness = 8
            // 弹力速度，取值范围 0~20，数值越大，速度越快，默认数值为12
            anim.springSpeed = 8
            
            // 设置动画启动时间
            anim.beginTime = CACurrentMediaTime() + CFTimeInterval(i) * 0.025
            
            // 3> 添加动画
            btn.pop_add(anim, forKey: nil)
        }
    }
}

// private 让 extension 中所有的方法都是私有
private extension EYComposeTypeView {
    
    func setupUI() {
        
        // 0. 强行更新布局
        layoutIfNeeded()
        
        // 1. 向 scrollView 添加视图
        let rect = scrollView.bounds
        
        let width = scrollView.bounds.width
        for i in 0..<2 {
            
            let v = UIView(frame: rect.offsetBy(dx: CGFloat(i) * width, dy: 0))
            
            // 2. 向视图添加按钮
            addButtons(v: v, idx: i * 6)
            
            // 3. 将视图添加到 scrollView
            scrollView.addSubview(v)
        }
        
        // 4. 设置 scrollView
        scrollView.contentSize = CGSize(width: 2 * width, height: 0)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        
        // 禁用滚动
        scrollView.isScrollEnabled = false
    }
    
    /// 向 v 中添加按钮，按钮的数组索引从 idx 开始
    func addButtons(v: UIView, idx: Int) {
        
        let count = 6
        // 1. 从 idx 开始，添加 6 个按钮
        for i in idx..<(idx + count) {
         
            if i >= buttonsInfo.count {
                break
            }
            
            // 0> 从数组字典中获取图像名称和 title
            let dict = buttonsInfo[i]
            
            guard let imageName = dict["imageName"],
                let title = dict["title"] else {
                    continue
            }
            
            // 1> 创建按钮
            let btn = EYComposeTypeButton.composeTypeButton(imageName: imageName, title: title)
            
            // 2> 将 btn 添加到视图
            v.addSubview(btn)
            
            // 3> 添加监听方法
            if let actionName = dict["actionName"] {
                // OC 中使用 NSSelectorFromString(@"clickMore")
                btn.addTarget(self, action: Selector(actionName), for: .touchUpInside)
            } else {
                btn.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
            }
            
            // 4> 设置要展现的类名 - 注意不需要任何的判断，有了就设置，没有就不设置
            btn.clsName = dict["clsName"]
        }
        
        // 2. 遍历视图的子视图，布局按钮
        // 准备常量
        let btnSize = CGSize(width: 100, height: 100)
        let margin = (v.bounds.width - 3 * btnSize.width) / 4
        
        for (i, btn) in v.subviews.enumerated() {
        
            let y: CGFloat = (i > 2) ? (v.bounds.height - btnSize.height) : 0
            let col = i % 3
            let x = CGFloat(col + 1) * margin + CGFloat(col) * btnSize.width
            
            btn.frame = CGRect(x: x, y: y, width: btnSize.width, height: btnSize.height)
        }
    }
}
