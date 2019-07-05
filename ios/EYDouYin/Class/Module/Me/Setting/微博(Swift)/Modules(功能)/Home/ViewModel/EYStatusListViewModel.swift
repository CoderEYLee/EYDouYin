//
//  EYStatusListViewModel.swift
//  weiboSwift
//
//  Created by lieryang on 16/7/2.
//  Copyright © 2016年 lieryang. All rights reserved.
//

import Foundation
import SDWebImage

/// 微博数据列表视图模型
/*
 父类的选择
 
 - 如果类需要使用 `KVC` 或者字典转模型框架设置对象值，类就需要继承自 NSObject
 - 如果类只是包装一些代码逻辑(写了一些函数)，可以不用任何父类，好处：更加轻量级
 - 提示：如果用 OC 写，一律都继承自 NSObject 即可
 
 使命：负责微博的数据处理
 1. 字典转模型
 2. 下拉／上拉刷新数据处理
 */

/// 上拉刷新最大尝试次数
private let maxPullupTryTimes = 3

class EYStatusListViewModel {
    
    /// 微博视图模型数组懒加载
    lazy var statusList = [EYStatusViewModel]()
    /// 上拉刷新错误次数
    private var pullupErrorTimes = 0
    
    /// 加载微博列表
    ///
    /// - parameter pullup:     是否上拉刷新标记
    /// - parameter completion: 完成回调[网络请求是否成功, 是否刷新表格]
    func loadStatus(pullup: Bool, completion: @escaping (Bool, Bool)->()) {
        
        // 判断是否是上拉刷新，同时检查刷新错误
        if pullup && pullupErrorTimes > maxPullupTryTimes {
            
            completion(true, false)
            
            return
        }
        
        // since_id 取出数组中第一条微博的 id
        let since_id = pullup ? 0 : (statusList.first?.status.id ?? 0)
        // 上拉刷新，取出数组的最后一条微博的 id
        let max_id = !pullup ? 0 : (statusList.last?.status.id ?? 0)
        
        // 让数据访问层加载数据
        EYStatusListDAL.loadStatus(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            
            // 0. 如果网络请求失败，直接执行完成回调
            if !isSuccess {
                completion(false, false)
                
                return
            }
            
            // 1. 遍历字典数组，字典转 模型 => 视图模型，将视图模型添加到数组
            var array = [EYStatusViewModel]()
            
            for dict in list ?? [] {
                
                // EYLog(dict["pic_urls"])
                
                // 1> 创建微博模型
                let status = EYStatus()
                
                // 2> 使用字典设置模型数值
                status.yy_modelSet(with: dict)
                
                // 3> 使用 `微博` 模型创建 `微博视图` 模型
                let viewModel = EYStatusViewModel(model: status)
                
                // 4> 添加到数组
                array.append(viewModel)
            }
            
            // 视图模型创建完成
            EYLog("刷新到 \(array.count) 条数据 \(array)")
            
            // 2. 拼接数据
            if pullup {
                // 上拉刷新结束后，将结果拼接在数组的末尾
                self.statusList += array
            } else {
                // 下拉刷新，应该将结果数组拼接在数组前面
                self.statusList = array + self.statusList
            }
            
            // 3. 判断上拉刷新的数据量
            if pullup && array.count == 0 {
                
                self.pullupErrorTimes += 1
                
                completion(isSuccess, false)
            } else {
                
                self.cacheSingleImage(list: array, finished: completion)
                
                // 4. 真正有数据的回调！
                // completion(isSuccess: isSuccess, shouldRefresh: true)
            }
        }
    }
    
    /// 缓存本次下载微博数据数组中的单张图像
    ///
    /// - 应该缓存完单张图像，并且修改过配图是的大小之后，再回调，才能够保证表格等比例显示单张图像！
    ///
    /// - parameter list: 本次下载的视图模型数组
    private func cacheSingleImage(list: [EYStatusViewModel], finished: @escaping (Bool, Bool)->()) {
        
        // 调度组
        let group = DispatchGroup()
        
        // 记录数据长度
        var length = 0
        
        // 遍历数组，查找微博数据中有单张图像的，进行缓存
        // option + cmd + 左，折叠代码
        for vm in list {
            
            // 1> 判断图像数量
            if vm.picURLs?.count != 1 {
                continue
            }
            
            // 2> 代码执行到此，数组中有且仅有一张图片
            guard let pic = vm.picURLs?[0].thumbnail_pic,
                let url = URL(string: pic) else {
                    continue
            }
            
            // EYLog("要缓存的 URL 是 \(url)")
            
            // 3> 下载图像
            // 1) downloadImage 是 SDWebImage 的核心方法
            // 2) 图像下载完成之后，会自动保存在沙盒中，文件路径是 URL 的 md5
            // 3) 如果沙盒中已经存在缓存的图像，后续使用 SD 通过 URL 加载图像，都会加载本地沙盒地图像
            // 4) 不会发起网路请求，同时，回调方法，同样会调用！
            // 5) 方法还是同样的方法，调用还是同样的调用，不过内部不会再次发起网路请求！
            // *** 注意点：如果要缓存的图像累计很大，要找后台要接口！
            
            // A> 入组
            group.enter()
			
			SDWebImageManager.shared.loadImage(with: url, options: [], progress: nil, completed: { (image, _, _, _, _, _) in
                
                // 将图像转换成二进制数据
                if let image = image,
                    let data = image.pngData() {
                    
                    // NSData 是 length 属性
                    length += data.count
                    
                    // 图像缓存成功，更新配图视图的大小
                    vm.updateSingleImageSize(image: image)
                }
				
                // B> 出组 - 放在回调的最后一句
                group.leave()
            })
        }
        
        // C> 监听调度组情况
        group.notify(queue: DispatchQueue.main) {
            // 执行闭包回调
            finished(true, true)
        }
    }
}
