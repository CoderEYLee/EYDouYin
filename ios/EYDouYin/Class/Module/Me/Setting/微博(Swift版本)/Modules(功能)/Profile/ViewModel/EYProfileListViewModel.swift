//
//  EYProfileListViewModel.swift
//  weiboSwift
//
//  Created by gujiabin on 2017/6/19.
//  Copyright © 2017年 lieryang. All rights reserved.
//

import UIKit

class EYProfileListViewModel {

    /// 我模型数组懒加载
    lazy var profileList = [EYProfileViewModel]()

    func loadProfileList(list: NSArray?){
        // 1. 遍历字典数组，字典转 模型 => 视图模型，将视图模型添加到数组
        var array = [EYProfileViewModel]()

        for dict in list ?? [] {

            // 1> 创建微博模型
            let profile = EYProfile()

            // 2> 使用字典设置模型数值
            profile.yy_modelSet(with: dict as! [AnyHashable : Any])

            // 3> 使用 `微博` 模型创建 `微博视图` 模型
            let viewModel = EYProfileViewModel(profile: profile)

            // 4> 添加到数组
            array.append(viewModel)
        }
        
        self.profileList = array
    }
}
