//
//  EYRefreshView.swift
//  weiboSwift
//
//  Created by lieryang on 2017/5/13.
//  Copyright © 2017年 lieryang. All rights reserved.
//

import UIKit

/// 刷新视图 - 负责刷新相关的 UI 显示和动画
class EYRefreshView: UIView {

    /// 刷新状态
    /**
     iOS 系统中 UIView 封装的旋转动画
     - 默认顺时针旋转
     - 就近原则
     - 要想实现同方向旋转，需要调整一个 非常小的数字(近)
     - 如果想实现 360 旋转，需要核心动画 CABaseAnimation
    */
    var refreshState: EYRefreshState = .Normal {
        didSet {
            switch refreshState {
            case .Normal:
                // 恢复状态
                tipIcon?.isHidden = false
                indicator?.stopAnimating()
                
                tipLabel?.text = "继续使劲拉..."
                
                UIView.animate(withDuration: 0.25) {
                    self.tipIcon?.transform = CGAffineTransform.identity
                }
            case .Pulling:
                tipLabel?.text = "放手就刷新..."
                
                UIView.animate(withDuration: 0.25) {
                    self.tipIcon?.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi + 0.001))
                }
            case .WillRefresh:
                tipLabel?.text = "正在刷新中..."
                
                // 隐藏提示图标
                tipIcon?.isHidden = true
                
                // 显示菊花
                indicator?.startAnimating()
            }
        }
    }
    
    /// 父视图的高度 - 为了刷新控件不需要关心当前具体的刷新视图是谁！
    var parentViewHeight: CGFloat = 0
    
    /// 指示器
    @IBOutlet weak var indicator: UIActivityIndicatorView?
    /// 提示图标
    @IBOutlet weak var tipIcon: UIImageView?
    /// 提示标签
    @IBOutlet weak var tipLabel: UILabel?

    class func refreshView() -> EYRefreshView {
        
        let nib = UINib(nibName: "EYMeituanRefreshView", bundle: nil)
        
        return nib.instantiate(withOwner: nil, options: nil)[0] as! EYRefreshView
    }
}
