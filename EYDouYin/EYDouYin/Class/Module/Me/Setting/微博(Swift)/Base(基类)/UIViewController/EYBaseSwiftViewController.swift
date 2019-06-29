//
//  EYBaseViewController.swift
//  weiboSwift
//
//  Created by apple on 16/6/29.
//  Copyright © 2016年 lieryang. All rights reserved.
//

import GKNavigationBarViewController

// 面试题：OC 中支持多继承吗？如果不支持，如何替代？答案：使用协议替代！
// Swift 的写法更类似于多继承！
//class EYBaseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
// Swift 中，利用 extension 可以把`函数`按照功能分类管理，便于阅读和维护！
// 注意：
// 1. extension 中不能有属性
// 2. extension 中不能重写`父类`本类的方法！重写父类方法，是子类的职责，扩展是对类的扩展！

/// 所有主控制器的基类控制器
class EYBaseSwiftViewController: GKNavigationBarViewController {
    
    /// 访客视图信息字典
    var visitorInfoDictionary: [String: String]?
    
    /// 表格视图 - 如果用户没有登录，就不创建
    var tableView: UITableView?
    /// 刷新控件
    var refreshControl: EYRefreshControl?
    /// 上拉刷新标记
    var isPullup = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
        setupUI()

        if let dictionary = visitorInfoDictionary,
            let imageName = dictionary["imageName"] {
            imageName != "" || (imageName == "" && EYNetworkManager.shared.userLogon) ?
                loadData() : ()
        }
        
        // 注册通知
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(loginSuccess),
            name: NSNotification.Name(rawValue: EYUserLoginSuccessedNotification),
            object: nil)
    }
    
    deinit {
        // 注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
    /// 加载数据 - 具体的实现由子类负责
    @objc func loadData() {
        // 如果子类不实现任何方法，默认关闭刷新控件
        refreshControl?.endRefreshing()
    }
}

// MARK: - 访客视图监听方法
extension EYBaseSwiftViewController {
    
    /// 登录成功处理
    @objc func loginSuccess(n: Notification) {
        
        EYLog("登录成功 \(n)")
        
        // 登录前左边是注册，右边是登录
//        navItem.leftBarButtonItem = nil
//        navItem.rightBarButtonItem = nil
        
        // 更新 UI => 将访客视图替换为表格视图
        // 需要重新设置 view
        // 在访问 view 的 getter 时，如果 view == nil 会调用 loadView -> viewDidLoad
        view = nil
        
        // 注销通知 -> 重新执行 viewDidLoad 会再次注册！避免通知被重复注册
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func login() {
        // 发送通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: EYUserShouldLoginNotification), object: nil)
    }
    
    @objc func register() {
        EYLog("用户注册")
    }
}

// MARK: - 设置界面
extension EYBaseSwiftViewController {
    
	func setupUI() {
        view.backgroundColor = UIColor.white

        if let dictionary = visitorInfoDictionary,
        let imageName = dictionary["imageName"] {
            imageName != "" || (imageName == "" && EYNetworkManager.shared.userLogon) ?
                setupTableView() : setupVisitorView()
        }
    }
    
    /// 设置表格视图 - 用户登录之后执行
    /// 子类重写此方法，因为子类不需要关心用户登录之前的逻辑
    @objc func setupTableView() {
        tableView = UITableView(frame: CGRect(origin: CGPoint(x: 0, y: EYScreenBarHeight), size: EYScreenSize), style: .plain)

        view.addSubview(tableView!)
        
        // 设置数据源&代理 -> 目的：子类直接实现数据源方法
        tableView?.dataSource = self
        tableView?.delegate = self

        // 修改指示器的缩进 - 强行解包是为了拿到一个必有的 inset
        tableView?.scrollIndicatorInsets = tableView!.contentInset
        
        // 设置刷新控件
        // 1> 实例化控件
        refreshControl = EYRefreshControl()
        
        // 2> 添加到表格视图
        tableView?.addSubview(refreshControl!)
        
        // 3> 添加监听方法
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    /// 设置访客视图
    private func setupVisitorView() {
        
        let visitorView = EYVisitorView(frame: view.bounds)
        
        view.addSubview(visitorView)
        
        // 1. 设置访客视图信息
        visitorView.visitorInfo = visitorInfoDictionary
        
        // 2. 添加访客视图按钮的监听方法
        visitorView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        visitorView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        // 3. 设置导航条按钮
//        navItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(register))
//        navItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(login))
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension EYBaseSwiftViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    // 基类只是准备方法，子类负责具体的实现
    // 子类的数据源方法不需要 super
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 只是保证没有语法错误！
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 10
    }
    
    /// 在显示最后一行的时候，做上拉刷新
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // 1. 判断 indexPath 是否是最后一行
        // (indexPath.section(最大) / indexPath.row(最后一行))
        // 1> row
        let row = indexPath.row
        // 2> section
        let section = tableView.numberOfSections - 1
        
        if row < 0 || section < 0 {
            return
        }
        
        // 3> 行数
        let count = tableView.numberOfRows(inSection: section)
        
        // 如果是最后一行，同时没有开始上拉刷新
        if row == (count - 1) && !isPullup {
            
            EYLog("上拉刷新")
            isPullup = true
            
            // 开始刷新
            loadData()
        }
    }
}

