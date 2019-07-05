//
//  EYProfileViewController.swift
//  weiboSwift
//
//  Created by lieryang on 16/6/29.
//  Copyright © 2016年 lieryang. All rights reserved.
//

import UIKit
import SDWebImage

/// 只有文字的可重用 cell id
private let EYProfileLabelCellId = "EYProfileLabelCellId"
/// 有描述的可重用 cell id
private let EYProfileDetailCellId = "EYProfileDetailCellId"

class EYProfileViewController: EYBaseSwiftViewController
{
    /// 我模型数组懒加载
    lazy var listViewModel = EYProfileListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        showFileSize()
        //禁止滚动
        tableView?.isScrollEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func showFileSize() {
        let sdSize: CGFloat = CGFloat(SDImageCache.shared.totalDiskSize()) / CGFloat(1024) / CGFloat(1024)

        //缓存大小
        let size = String(format: "%.1f",sdSize)

        let array: NSArray = [["tipString" : "意见反馈"],["tipString" : "清除缓存", "fileSizeString" : size, "imageName" : "Common_direct_right"]]

        listViewModel.loadProfileList(list:array)

        tableView?.reloadData()
    }
}

/// MARK: 设置界面
extension EYProfileViewController
{
    /// 重写父类的方法
    override func setupTableView() {

        super.setupTableView()

        // 注册原型 cell
        tableView?.register(UINib(nibName: "EYProfileDetailCell", bundle: nil), forCellReuseIdentifier: EYProfileDetailCellId )
        tableView?.register(UINib(nibName: "EYProfileLabelCell", bundle: nil), forCellReuseIdentifier: EYProfileLabelCellId)

        // 清除多余的分割线
        tableView?.tableFooterView = UIView()
    }
}

// MARK: - 数据源
extension EYProfileViewController
{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.profileList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = listViewModel.profileList[indexPath.row]

        let cellId = (vm.profile.imageName != nil) ? EYProfileDetailCellId : EYProfileLabelCellId

        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EYProfileCell

        cell.viewModel = vm

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 1 {
            let alert = UIAlertController(title: "确定删除所有缓存?图片会被清除", message: "", preferredStyle: .actionSheet)
            let determine = UIAlertAction(title: "确定", style: .destructive, handler: { (_) in
                SDImageCache.shared.clearDisk(onCompletion: {
                    self.showFileSize()
                })
            })
            alert.addAction(determine)

            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
    }
}
