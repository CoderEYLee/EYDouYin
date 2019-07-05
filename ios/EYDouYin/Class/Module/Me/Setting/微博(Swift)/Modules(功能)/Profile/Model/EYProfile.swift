//
//  EYProfile.swift
//  weiboSwift
//
//  Created by lieryang on 2017/6/19.
//  Copyright © 2017年 lieryang. All rights reserved.
//

import UIKit
import YYModel

/// 设置数据模型
class EYProfile: NSObject {

    /// 提示文字
    var tipString: String?

    /// 缓存大小
    var fileSizeString: String?

    /// 图片名称
    var imageName: String?

    /// 重写 description 的计算型属性
    override var description: String {
        return yy_modelDescription()
    }
}
