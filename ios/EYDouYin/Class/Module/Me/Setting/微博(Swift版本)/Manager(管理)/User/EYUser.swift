//
//  EYUser.swift
//  weiboSwift
//
//  Created by lieryang on 2017/5/13.
//  Copyright © 2017年 lieryang. All rights reserved.
//

import UIKit

/// 微博用户模型
class EYUser: NSObject {

    // 基本数据类型 & private 不能使用 KVC 设置
    @objc
    var id: Int64 = 0
    /// 用户昵称
    @objc
    var screen_name: String?
    /// 用户头像地址（中图），50×50像素
    @objc
    var profile_image_url: String?
    /// 认证类型，-1：没有认证，0，认证用户，2,3,5: 企业认证，220: 达人
    @objc
    var verified_type: Int = 0
    /// 会员等级 0-6
    @objc
    var mbrank: Int = 0
    
    override var description: String {
        return yy_modelDescription()
    }
}
