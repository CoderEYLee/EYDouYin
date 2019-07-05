//
//  EYComposeViewController.swift
//  weiboSwift
//
//  Created by lieryang on 16/7/8.
//  Copyright © 2016年 lieryang. All rights reserved.
//

import UIKit
import SVProgressHUD

/// 撰写微博控制器
/**
 加载视图控制器的时候，如果 XIB 和控制器同名，默认的构造函数，会优先加载 XIB
 */
class EYComposeViewController: UIViewController {
    /// 用户账户的懒加载属性
    lazy var userAccount = EYUserAccount()
    
    /// 文本编辑视图
    @IBOutlet weak var textView: EYComposeTextView!
    /// 底部工具栏
    @IBOutlet weak var toolbar: UIToolbar!
    /// 发布按钮
    @IBOutlet var sendButton: UIButton!
    /// 标题标签 - 换行的热键 option + 回车
    /// 逐行选中文本并且设置属性
    /// 如果要想调整行间距，可以增加一个空行，设置空行的字体，lineHeight
    @IBOutlet var titleView: UIView!
    
    @IBOutlet var titleLabel: UILabel!
    /// 工具栏底部约束
    @IBOutlet weak var toolbarBottomCons: NSLayoutConstraint!
    
    /// 表情输入视图
    lazy var emoticonView: EYEmoticonInputView = EYEmoticonInputView.inputView { [weak self] (emoticon) in

        self?.textView.insertEmoticon(em: emoticon)
    }
    
    // MARK: - 视图生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
//        // 强行更新约束
//        view.layoutIfNeeded()
        
        setupUI()
        
        // 监听键盘通知 - UIWindow.h
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardChanged),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 激活键盘
        textView.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 设置文本视图的代理
        textView.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 关闭键盘
        textView.resignFirstResponder()
    }
    
    // MARK: - 键盘监听方法
    @objc private func keyboardChanged(n: Notification) {
        
        // 1. 目标 rect
        guard let rect = (n.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = (n.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
            else {
                return
        }
        
        // 2. 设置底部约束的高度
        let offset = view.bounds.height - rect.origin.y
        
        // 3. 更新底部约束
        toolbarBottomCons.constant = offset
        
        // 4. 动画更新约束
        UIView.animate(withDuration: duration) { 
            self.view.layoutIfNeeded()
        }
    }

    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - 按钮监听方法
    /// 发布微博
    @IBAction func postStatus() {
        
        // 1. 获取发送给服务器的表情微博文字
        let text = textView.emoticonText
        
        // 2. 发布微博
        // FIXME: - 临时测试发布带图片的微博
        let image: UIImage? = nil //UIImage(named: "icon_small_kangaroo_loading_1")
        
        EYNetworkManager.shared.postStatus(text: text, image: image) { (result, isSuccess) in
            
            // 修改指示器样式
            SVProgressHUD.setDefaultStyle(.dark)
            
            let message = isSuccess ? "发布成功" : "网络不给力"
            
            SVProgressHUD.showInfo(withStatus: message)
            
            // 如果成功，延迟一段时间关闭当前窗口
            if isSuccess {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    
                    // 恢复样式
                    SVProgressHUD.setDefaultStyle(.light)
                    
                    self.close()
                }
            }
        }
    }
    
    /// 切换表情键盘
    @objc private func emoticonKeyboard() {
        // textView.inputView 就是文本框的输入视图
        // 如果使用系统默认的键盘，输入视图为 nil
        
        // 1> 测试键盘视图 - 视图的宽度可以随便，就是屏幕的宽度
//        let keyboardView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 253))
//        keyboardView.backgroundColor = UIColor.blue()
        
        // 2> 设置键盘视图
        textView.inputView = (textView.inputView == nil) ? emoticonView : nil
        
        // 3> !!!刷新键盘视图
        textView.reloadInputViews()
    }
}

// MARK: - UITextViewDelegate
/**
 通知：一对多，只要有注册的监听者，在注销监听之前，都可以接收到通知！
 代理：一对一，最后设置的代理对象有效！
 
 苹果日常开发中，代理的监听方式是最多的！
 
 - 代理是发生事件时，直接让代理执行协议方法！
    代理的效率更高
    直接的反向传值
 - 通知是发生事件时，将通知发送给通知中心，通知中心再`广播`通知！
    通知想对要低一些
    如果层次嵌套的非常深，可以使用通知传值
 */
extension EYComposeViewController: UITextViewDelegate {
    
    /// 文本视图文字变化
    func textViewDidChange(_ textView: UITextView) {
        sendButton.isEnabled = textView.hasText
    }
}

private extension EYComposeViewController {
    
    func setupUI() {
        
        view.backgroundColor = UIColor.white
        
        setupNavigationBar()
        setupToolbar()
    }
    
    /// 设置工具栏
    func setupToolbar() {
        
        let itemSettings = [["imageName": "compose_toolbar_picture"],
                            ["imageName": "compose_mentionbutton_background"],
                            ["imageName": "compose_trendbutton_background"],
                            ["imageName": "compose_emoticonbutton_background", "actionName": "emoticonKeyboard"],
                            ["imageName": "compose_add_background"]]
        
        // 遍历数组
        var items = [UIBarButtonItem]()
        for s in itemSettings {
            
            guard let imageName = s["imageName"] else {
                continue
            }
            
            let image = UIImage(named: imageName)
            let imageHL = UIImage(named: imageName + "_highlighted")
            
            let btn = UIButton()
            
            btn.setImage(image, for: [])
            btn.setImage(imageHL, for: .highlighted)
            
            btn.sizeToFit()
            
            // 判断 actionName
            if let actionName = s["actionName"] {
                // 给按钮添加监听方法
                btn.addTarget(self, action: Selector(actionName), for: .touchUpInside)
            }
            
            // 追加按钮
            items.append(UIBarButtonItem(customView: btn))
            
            // 追加弹簧
            items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        }
        // 删除末尾弹簧
        items.removeLast()
        
        toolbar.items = items
    }
    
    /// 设置导航栏
    func setupNavigationBar() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", target: self, action: #selector(close))
        
        // 设置发送按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendButton)
        // 设置标题视图
        titleLabel.text = userAccount.screen_name ?? ""
        navigationItem.titleView = titleView
        
        sendButton.isEnabled = false
    }
}
