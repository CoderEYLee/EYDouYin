//
//  EYProfileViewModel.swift
//  weiboSwift
//
//  Created by lieryang on 2017/6/19.
//  Copyright © 2017年 lieryang. All rights reserved.
//

import UIKit

/// 视图模型
class EYProfileViewModel: CustomStringConvertible {

    /// 我的模型
    var profile: EYProfile

    /// 提示文字
    var tipString: String?

    /// 缓存大小文字
    var fileSizeString: String?

    /// 图片名称
    var image: UIImage?
    
    var description: String {
        return profile.description
    }

    init(profile: EYProfile) {
        self.profile = profile
        tipString = profile.tipString
        if let size = profile.fileSizeString {
            fileSizeString = String(format: "%@ M", size)
        }
        image = UIImage(named: profile.imageName ?? "")
    }
}
