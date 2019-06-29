//
//  EYHomeViewController.swift
//  weiboSwift
//
//  Created by lieryang on 16/6/29.
//  Copyright © 2016年 lieryang. All rights reserved.
//

import UIKit

/// 原创微博可重用 cell id
private let EYStatusNormalCellId = "EYStatusNormalCellId"
/// 被转发微博的可重用 cell id
private let EYStatusRetweetedCellId = "EYStatusRetweetedCellId"

class EYHomeViewController: EYBaseViewController {

    /// 列表视图模型
	lazy var listViewModel = EYStatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 注册通知
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(browserPhoto),
            name: NSNotification.Name(rawValue: EYStatusCellBrowserPhotoNotification),
            object: nil)
    }
    
    deinit {
        // 注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
    /// 浏览照片通知监听方法
    @objc private func browserPhoto(n: Notification) {
        
        // 1. 从 通知的 userInfo 提取参数
        guard let selectedIndex = n.userInfo?[EYStatusCellBrowserPhotoSelectedIndexKey] as? Int,
            let urls = n.userInfo?[EYStatusCellBrowserPhotoURLsKey] as? [String],
            let imageViewList = n.userInfo?[EYStatusCellBrowserPhotoImageViewsKey] as? [UIImageView]
            else {
                return
        }
        
        // 2. 展现照片浏览控制器
        let vc = EYPhotoBrowserController.photoBrowser(
            withSelectedIndex: selectedIndex,
            urls: urls,
            parentImageViews: imageViewList)
        
        present(vc, animated: true, completion: nil)
    }
    
    /// 加载数据
    override func loadData() {
        
        EYLog("准备刷新")
        // Xcode 8.0 的刷新控件，beginRefreshing 方法，什么都不显示！
        refreshControl?.beginRefreshing()
        
        // 模拟演示加载数据
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.listViewModel.loadStatus(pullup: self.isPullup) { (isSuccess, shouldRefresh) in
                
                EYLog("加载数据结束")
                // 结束刷新控件
                self.refreshControl?.endRefreshing()
                // 恢复上拉刷新标记
                self.isPullup = false
                
                // 刷新表格
                if shouldRefresh {
                    self.tableView?.reloadData()
                }
            }
        }
    }
    
    /// 显示好友
    @objc func showFriends() {

        let vc = EYDemoViewController()
        
        // push 的动作是 nav 做的
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - 表格数据源方法，具体的数据源方法实现，不需要 super
extension EYHomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 0. 取出视图模型，根据视图模型判断可重用 cell
        let vm = listViewModel.statusList[indexPath.row]

        let cellId = (vm.status.retweeted_status != nil) ? EYStatusRetweetedCellId : EYStatusNormalCellId
        
        // 1. 取 cell - 本身会调用代理方法(如果有)
        // 如果没有，找到 cell，按照自动布局的规则，从上向下计算，找到向下的约束，从而计算动态行高
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EYStatusCell
        
        // 2. 设置 cell
        cell.viewModel = vm
        
        // --- 设置代理 ---
        // 如果用 block 需要在数据源方法中，给每一个 cell 设置 block
        // cell.completionBlock = { // ... }
        // 设置代理只是传递了一个指针地址
        cell.delegate = self
        
        // 3. 返回 cell
        return cell
    }
    
    /// 父类必须实现代理方法，子类才能够重写，Swift 3.0 才是如此，2.0 不需要
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // 1. 根据 indexPath 获取视图模型
        let vm = listViewModel.statusList[indexPath.row]
        
        // 2. 返回计算好的行高
        return vm.rowHeight
    }
}

// MARK: - EYStatusCellDelegate
extension EYHomeViewController: EYStatusCellDelegate {
    
    func statusCellDidSelectedURLString(cell: EYStatusCell, urlString: String) {
        
        let vc = EYWebViewController()
        
        vc.urlString = urlString
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - 设置界面
extension EYHomeViewController {
    
    /// 重写父类的方法
    override func setupTableView() {
        
        super.setupTableView()
        
        // 设置导航栏按钮
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        
        // 注册原型 cell
        tableView?.register(UINib(nibName: "EYStatusNormalCell", bundle: nil), forCellReuseIdentifier: EYStatusNormalCellId)
        tableView?.register(UINib(nibName: "EYStatusRetweetedCell", bundle: nil), forCellReuseIdentifier: EYStatusRetweetedCellId)
        
        // 设置行高
        // 取消自动行高
        // tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 300
        
        // 取消分隔线
        tableView?.separatorStyle = .none
        
        setupNavTitle()
    }
    
    /// 设置导航栏标题
    private func setupNavTitle() {
        
        let title = EYNetworkManager.shared.userAccount.screen_name
        
        let button = EYTitleButton(title: title)
        
        navItem.titleView = button
        
        button.addTarget(self, action: #selector(clickTitleButton), for: .touchUpInside)
    }
    
    @objc func clickTitleButton(btn: UIButton) {
        
        // 设置选中状态
        btn.isSelected = !btn.isSelected
    }
}
