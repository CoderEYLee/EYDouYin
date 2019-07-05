//
//  EYLiveListViewModel.swift
//  weiboSwift
//
//  Created by gujiabin on 2017/6/21.
//  Copyright © 2017年 lieryang. All rights reserved.
//

import UIKit

class EYLiveListViewModel: NSObject {

    /// 微博视图模型数组懒加载
    lazy var liveList = [EYLiveViewModel]()

    /// 加载直播列表
    ///
    /// - Parameter completion: 回调[网络请求是否成功, 是否刷新表格]
    func loadLives(completion: @escaping (Bool, Bool) -> ()) {

        //加载网络数据
        EYNetworkManager.shared.liveList(multiaddr: 0) { (lives, isSuccess) in
            if !isSuccess {
                completion(false, false)
                return
            }
            // 1. 遍历字典数组，字典转 模型 => 视图模型，将视图模型添加到数组
            for dict in lives ?? [] {
                // 1> 创建直播模型
                let live = EYLive()

                // 2> 使用字典设置模型数值
                live.yy_modelSet(with: dict)

                // 3> 使用 `live` 模型创建 `live视图` 模型
                let viewModel = EYLiveViewModel(model: live)
				
                // 4> 添加到数组
				if !self.liveList.contains(where: { $0.live.id == viewModel.live.id }) {
					EYLog("添加到数组")
					self.liveList.append(viewModel)
				}
            }

            completion(true, true)
        }
    }
}
