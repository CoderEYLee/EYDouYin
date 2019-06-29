//
//  EYMainViewController.swift
//  weiboSwift
//
//  Created by lieryang on 16/6/29.
//  Copyright © 2016年 lieryang. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftyJSON

/// 主控制器
class EYMainViewController: UITabBarController {

    // 定时器
	var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeiboSDK.enableDebugMode(true)
        WeiboSDK.registerApp(EYAppKey)
        
        
        setupChildControllers()
        setupComposeButton()
        setupTimer()
        // 设置新特性视图
        setupNewfeatureViews()
        
        // 设置代理
        delegate = self
        
        // 注册通知
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(userLogin),
            name: NSNotification.Name(rawValue: EYUserShouldLoginNotification),
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(setupTimer),
            name: NSNotification.Name(rawValue: EYUserLoginSuccessedNotification),
            object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    deinit {
        // 销毁时钟
        timer?.invalidate()
        
        // 注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
    /**
        portrait    : 竖屏，肖像
        landscape   : 横屏，风景画
        
        - 使用代码控制设备的方向，好处，可以在在需要横屏的时候，单独处理！
        - 设置支持的方向之后，当前的控制器及子控制器都会遵守这个方向！
        - 如果播放视频，通常是通过 modal 展现的！
    */
//    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
//        return .portrait
//    }
    
    
    
    // MARK: - 监听方法
    @objc private func userLogin(n: Notification) {
        
        EYLog("用户登录通知 \(n)")
        // 销毁时钟
        timer?.invalidate()
        
        var when = DispatchTime.now()
        
        // 判断 n.object 是否有值 -> token 过期，提示用户重新登录
        if n.object != nil {

            // 设置指示器渐变样式
            SVProgressHUD.setDefaultMaskType(.gradient)
    
            SVProgressHUD.showInfo(withStatus: "用户登录已经超时，需要重新登录")
            
            // 修改延迟时间
            when = DispatchTime.now() + 2
        }
        
        DispatchQueue.main.asyncAfter(deadline: when) {
            SVProgressHUD.setDefaultMaskType(.clear)
            
            // 展现登录控制器 - 通常会和 UINavigationController 连用，方便返回
            let nav = UINavigationController(rootViewController: EYOAuthViewController())
            
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    /// 撰写微博
    @objc func composeStatus() {
        // 0> 判断是否登录
        let user: EYUserAccount = EYUserAccount()
        guard let _ = user.access_token else {
            SVProgressHUD.showInfo(withStatus: "您还没有登录")
            return
        }
        
        // 1> 实例化视图
        let v = EYComposeTypeView.composeTypeView()
        
        // 2> 显示视图 - 注意闭包的循环引用！
        v.show { [weak v] (clsName) in
            EYLog(clsName ?? "")
            
            // 展现撰写微博控制器
            guard let clsName = clsName,
                let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? UIViewController.Type
                else {
                    v?.removeFromSuperview()
                return
            }
            
            let vc = cls.init()
            let nav = UINavigationController(rootViewController: vc)
            
            // 让导航控制器强行更新约束 - 会直接更新所有子视图的约束！
            // 提示：开发中如果发现不希望的布局约束和动画混在一起，应该向前寻找，强制更新约束！
            nav.view.layoutIfNeeded()
            
            self.present(nav, animated: true) {
                v?.removeFromSuperview()
            }
        }
    }
    
    // MARK: - 私有控件
    /// 撰写按钮
	lazy var composeButton: UIButton = UIButton.ey_imageButton(
        "tabbar_compose_icon_add",
        backgroundImageName: "tabbar_compose_button")
}

// MARK: - 新特性视图处理
extension EYMainViewController {
    
    /// 设置新特性视图
	func setupNewfeatureViews() {
        
        // 0. 判断是否登录
        if !EYNetworkManager.shared.userLogon {
            return
        }
        
        // 1. 如果更新，显示新特性，否则显示欢迎
        let v = isNewVersion ? EYNewFeatureView.newFeatureView() : EYWelcomeView.welcomeView()
        
        // 2. 添加视图
        view.addSubview(v)
    }
    
    /// extesions 中可以有计算型属性，不会占用存储空间
    /// 构造函数：给属性分配空间
    /**
        版本号
        - 在 AppStore 每次升级应用程序，版本号都需要增加，不能递减
     
        - 组成 主版本号.次版本号.修订版本号
        - 主版本号：意味着大的修改，使用者也需要做大的适应
        - 次版本号：意味着小的修改，某些函数和方法的使用或者参数有变化
        - 修订版本号：框架／程序内部 bug 的修订，不会对使用者造成任何的影响
    */
    private var isNewVersion: Bool {
        
        // 1. 取当前的版本号 1.0.2
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        EYLog("当前版本" + currentVersion)
        
        // 2. 取保存在 `Document(iTunes备份)[最理想保存在用户偏好]` 目录中的之前的版本号 "1.0.2"
        let path: String = ("version" as NSString).ey_appendDocumentDir()
        let sandboxVersion = (try? String(contentsOfFile: path)) ?? ""
        EYLog("沙盒版本" + sandboxVersion)
        
        // 3. 将当前版本号保存在沙盒 1.0.2
        _ = try? currentVersion.write(toFile: path, atomically: true, encoding: .utf8)
        
        // 4. 返回两个版本号`是否一致` not new
        return currentVersion != sandboxVersion
    }
}

// MARK: - UITabBarControllerDelegate
extension EYMainViewController: UITabBarControllerDelegate {
    
    /// 将要选择 TabBarItem
    ///
    /// - parameter tabBarController: tabBarController
    /// - parameter viewController:   目标控制器
    ///
    /// - returns: 是否切换到目标控制器
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        // 1> 获取控制器在数组中的索引
        let idx = (children as NSArray).index(of: viewController)
        
        // 2> 判断当前索引是首页，同时 idx 也是首页，重复点击首页的按钮
        if selectedIndex == 0 && idx == selectedIndex {
            
            EYLog("点击首页")
            // 3> 让表格滚动到顶部
            // a) 获取到控制器
            let nav = children[0] as! UINavigationController
            let vc = nav.children[0] as! EYHomeViewController
            
            // b) 滚动到顶部
            vc.tableView?.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            
            // 4> 刷新数据 － 增加延迟，是保证表格先滚动到顶部再刷新
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                vc.loadData()
            }
            
            // 5> 清除 tabItem 的 badgeNumber
            vc.tabBarItem.badgeValue = nil
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        
        // 判断目标控制器是否是 UIViewController
        return !viewController.isMember(of: UIViewController.self)
    }
}

// MARK: - 时钟相关方法
extension EYMainViewController {
    
    /// 定义时钟
    @objc func setupTimer() {
        
        // 时间间隔建议长一些
//        timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    /// 时钟触发方法
    @objc func updateTimer() {
        
        if !EYNetworkManager.shared.userLogon {
            return
        }
        
        EYNetworkManager.shared.unreadCount { (count) in
            
            EYLog("监测到 \(count) 条新微博")
            
            // 设置 首页 tabBarItem 的 badgeNumber
            self.tabBar.items?[0].badgeValue = count > 0 ? "\(count)" : nil
            
            // 设置 App 的 badgeNumber，从 iOS 8.0 之后，要用户授权之后才能够显示
            UIApplication.shared.applicationIconBadgeNumber = count
        }
    }
}

// extension 类似于 OC 中的 分类，在 Swift 中还可以用来切分代码块
// 可以把相近功能的函数，放在一个 extension 中
// 便于代码维护
// 注意：和 OC 的分类一样，extension 中不能定义属性
// MARK: - 设置界面
extension EYMainViewController {
    
    /// 设置撰写按钮
	func setupComposeButton() {
        tabBar.addSubview(composeButton)
        
        // 计算按钮的宽度
        let count = CGFloat(children.count)
        // 将向内缩进的宽度
        let w = tabBar.bounds.width / count
        
        // CGRectInset 正数向内缩进，负数向外扩展
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        
        // 按钮监听方法
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    }
    
    /// 设置所有子控制器
	func setupChildControllers() {
        
        // 0. 获取沙盒 json 路径
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
        
        // 加载 data
        var data = NSData(contentsOfFile: jsonPath)
        
        // 判断 data 是否有内容，如果没有，说明本地沙盒没有文件
        if data == nil {
            // 从 Bundle 加载 data
            let path = Bundle.main.path(forResource: "main.json", ofType: nil)
            
            data = NSData(contentsOfFile: path!)
        }
        
        // data 一定会有一个内容，反序列化
        // 反序列化转换成数组
//        guard let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String: AnyObject]] else {
//            return
//        }
        guard let array = JSON(data!).arrayObject as? [[String: AnyObject]] else {
            return
        }

        // 遍历数组，循环创建控制器数组
        var arrayM = [UIViewController]()
        for dict in array {
            arrayM.append(controller(dict: dict))
        }
        
        // 设置 tabBar 的子控制器
        viewControllers = arrayM
    }
    
    /// 使用字典创建一个子控制器
    ///
    /// - parameter dict: 信息字典[clsName, title, imageName, visitorInfo]
    ///
    /// - returns: 子控制器
    private func controller(dict: [String: AnyObject]) -> UIViewController {
        
        // 1. 取得字典内容
        guard let clsName = dict["clsName"] as? String,
            let title = dict["title"] as? String,
            let imageName = dict["imageName"] as? String,
            let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? EYBaseSwiftViewController.Type,
            let visitorDict = dict["visitorInfo"] as? [String: String]
        
            else {
                
                return UIViewController()
        }
        
        // 2. 创建视图控制器
        let vc = cls.init()
        
        vc.title = title
        
        // 设置控制器的访客信息字典
        vc.visitorInfoDictionary = visitorDict
        
        // 3. 设置图像
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        // 4. 设置 tabbar 的标题字体（大小）
        vc.tabBarItem.setTitleTextAttributes(
            [.foregroundColor: UIColor.orange],
            for: .selected)
        // 系统默认是 12 号字，修改字体大小，要设置 Normal 的字体大小
        vc.tabBarItem.setTitleTextAttributes(
            [.font: UIFont.systemFont(ofSize: 12)],
            for: .normal)
        
        // 实例化导航控制器的时候，会调用 push 方法将 rootVC 压栈
        let nav = EYNavigationSwiftController(rootViewController: vc)
        
        return nav
    }
}

/// 加载json信息
extension EYMainViewController {
    
    fileprivate func loadAppInfo() {
        
        // 1. 模拟异步
        DispatchQueue.global().async {
            
            // 1> url
            let url = Bundle.main.url(forResource: "main.json", withExtension: nil)
            
            // 2> data
            let data = NSData(contentsOf: url!)
            
            // 3> 写入磁盘
            let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
            
            // 直接保存在沙盒，等待下一次程序启动使用！
            data?.write(toFile: jsonPath, atomically: true)
            
            EYLog("应用程序加载完毕 \(jsonPath)")
        }
    }
}
