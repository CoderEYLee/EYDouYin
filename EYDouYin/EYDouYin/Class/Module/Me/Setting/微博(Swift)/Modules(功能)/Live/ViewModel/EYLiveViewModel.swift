//
//  EYLiveViewModel.swift
//  weiboSwift
//
//  Created by gujiabin on 2017/6/21.
//  Copyright © 2017年 lieryang. All rights reserved.
//

import UIKit
import SDWebImage

class EYLiveViewModel: CustomStringConvertible {
    /// 直播模型
    var live: EYLive

    /// 根据cell展示的东西,cell需要什么就定义什么,cell需要显示image 就定义image cell需要label的文字就定义字符串(必要时需要转换为字符串),这样cell就可以直接使用,
    // 名称
    var nickName: String?

    // 地址
    var address: String?

    // 观看数量
    var viewers: String?

    // 截图
//    var shotImage: UIImage?

    init(model: EYLive) {
        live = model
        nickName = live.creator?.nick
        address = live.creator?.location
        viewers = String(live.online_users)
    }
    var description: String {
        return live.description
    }
}
