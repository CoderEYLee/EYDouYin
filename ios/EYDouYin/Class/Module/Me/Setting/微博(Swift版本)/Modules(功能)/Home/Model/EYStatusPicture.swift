//
//  EYStatusPicture.swift
//  weiboSwift
//
//  Created by lieryang on 2017/5/13.
//  Copyright © 2017年 lieryang. All rights reserved.
//
import UIKit

/// 微博配图模型
class EYStatusPicture: NSObject {

    /// 缩略图地址 - 新浪返回的缩略图令人发指
    @objc
    var thumbnail_pic: String? {
        didSet {
            // EYLog(thumbnail_pic)
            // 设置大尺寸图片
            largePic = thumbnail_pic?.replacingOccurrences(of: "/thumbnail/", with: "/large/")
            
            // 更改缩略图地址
            thumbnail_pic = thumbnail_pic?.replacingOccurrences(of: "/thumbnail/", with: "/wap720/")
        }
    }
    
    /// 大尺寸图片
    @objc
    var largePic: String?
    
    override var description: String {
        return yy_modelDescription()
    }
}
