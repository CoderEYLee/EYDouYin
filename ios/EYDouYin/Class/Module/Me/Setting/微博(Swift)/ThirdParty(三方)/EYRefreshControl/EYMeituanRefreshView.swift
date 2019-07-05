//
//  EYMeituanRefreshView.swift
//  weiboSwift
//
//  Created by lieryang on 2017/5/13.
//  Copyright © 2017年 lieryang. All rights reserved.
//

import UIKit

class EYMeituanRefreshView: EYRefreshView {

    @IBOutlet weak var buildingIconView: UIImageView!
    
    @IBOutlet weak var earthIconView: UIImageView!

    @IBOutlet weak var kangarooIconView: UIImageView!
    
    /// 父视图高度
    override var parentViewHeight: CGFloat {
        didSet {
            // EYLog("父视图高度 \(parentViewHeight)")
            
            if parentViewHeight < 23 {
                return
            }
            
            // 23 -> 126
            // 0.2 -> 1
            // 高度差 / 最大高度差 
            // 23 == 1 -> 0.2
            // 126 == 0 -> 1
            var scale: CGFloat
            
            if parentViewHeight > 126 {
                scale = 1
            } else {
                scale = 1 - ((126 - parentViewHeight) / (126 - 23))
            }
            
            kangarooIconView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    override func awakeFromNib() {
        
        // 1. 房子
        let bImage1 = #imageLiteral(resourceName: "icon_building_loading_1")
        let bImage2 = #imageLiteral(resourceName: "icon_building_loading_2")
        
        buildingIconView.image = UIImage.animatedImage(with: [bImage1, bImage2], duration: 0.5)
        
        // 2. 地球
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        
        anim.toValue = -2 * Double.pi
        anim.repeatCount = MAXFLOAT
        anim.duration = 3
        
        anim.isRemovedOnCompletion = false
        
        earthIconView.layer.add(anim, forKey: nil)
        
        // 3. 袋鼠
        // 0> 设置袋鼠动画
        let kImage1 = #imageLiteral(resourceName: "icon_small_kangaroo_loading_1")
        let kImage2 = #imageLiteral(resourceName: "icon_small_kangaroo_loading_2")
        
        kangarooIconView.image = UIImage.animatedImage(with: [kImage1, kImage2], duration: 0.5)
        
        // 1> 设置锚点
        kangarooIconView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        // 2> 设置 center
        let x = self.bounds.width * 0.5
        let y = self.bounds.height - 23
        kangarooIconView.center = CGPoint(x: x, y: y)
        
        kangarooIconView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
    }
    
}
