//
//  EYLiveViewController.swift
//  weiboSwift
//
//  Created by lieryang on 16/6/29.
//  Copyright © 2016年 lieryang. All rights reserved.
//

import UIKit

private let EYLiveCellId = "EYLiveCellId"

class EYLiveViewController: EYBaseSwiftViewController {

    /// 列表视图模型
    lazy var listViewModel = EYLiveListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /// 加载数据
    override func loadData() {

        refreshControl?.beginRefreshing()

        listViewModel.loadLives { (isSuccess, isReload) in
            // 结束刷新控件
            self.refreshControl?.endRefreshing()
            
            if isSuccess && isReload {
                self.tableView?.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

/// MARK: 设置界面
extension EYLiveViewController
{
    /// 重写父类的方法
    override func setupTableView() {

        super.setupTableView()

        // 注册原型 cell
        tableView?.register(UINib(nibName: "EYLiveCell", bundle: nil), forCellReuseIdentifier: EYLiveCellId)
    }
}

// MARK: - 表格数据源方法，具体的数据源方法实现，不需要 super
extension EYLiveViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.liveList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // 0. 取出视图模型
        let vm = listViewModel.liveList[indexPath.row]

        // 1. 取 cell - 本身会调用代理方法(如果有)

        let cell = tableView.dequeueReusableCell(withIdentifier: EYLiveCellId, for: indexPath) as! EYLiveCell

        // 2. 设置 cell
        cell.viewModel = vm

        // 3. 返回 cell
        return cell
    }

    /// 父类必须实现代理方法，子类才能够重写，Swift 3.0 才是如此，2.0 不需要
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = EYLivePlayerVideoViewController()
        vc.url = listViewModel.liveList[indexPath.row].live.stream_addr
        navigationController?.pushViewController(vc, animated: true)
    }
}
