import UIKit

// 通知名称
let EYPopoverChange = "EYPopoverChange"

let EYScreenBounds = UIScreen.main.bounds
let EYScreenSize = UIScreen.main.bounds.size
let EYScreenWidth = UIScreen.main.bounds.width
let EYScreenHeight = UIScreen.main.bounds.height

let iPhoneX = (EYScreenWidth == 375 && EYScreenHeight == 812)

//Document路径
let EYDocument = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

// MARK:- 自定义打印方法
func EYLog<T>( _ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {

    #if DEBUG

        let fileName = (file as NSString).lastPathComponent

        print("\(fileName):(\(lineNum)):\(message)")

    #endif
}

// RGB颜色 red green blue alpha 为系统关键字，不能使用
func EYRGBAColor(r : Int, g : Int, b : Int, a : Int) -> (UIColor) {
    return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(a))
}

//颜色
func EYRGBColor(r : Int, g : Int, b : Int) -> (UIColor) {
    return EYRGBAColor(r: r, g: g, b: b, a: 1);
}

//随机色
func EYRandomColor() -> (UIColor) {
    return EYRGBAColor(r: Int(arc4random_uniform(256)), g: Int(arc4random_uniform(256)), b: Int(arc4random_uniform(256)), a: 1);
}

//clear背景颜色
func EYClearColor() -> (UIColor) {
    return UIColor.clear
}

// MARK: - 应用程序信息
/// 应用程序 ID
let EYAppKey = "1030072051"

/// 应用程序加密信息(开发者可以申请修改)
let EYAppSecret = "23ed7ac5487029364c2c99bfdf13ac1c"

/// 回调地址 - 登录完成调转的 URL，参数以 get 形式拼接
let EYRedirectURI = "https://api.weibo.com/oauth2/default.html"

/// 请求微博列表
let EYStatusesUrlString = "https://api.weibo.com/2/statuses/home_timeline.json"

/// 未读微博
let EYUnreadUrlString = "https://rm.api.weibo.com/2/remind/unread_count.json"

/// 文字微博
let EYUpdateTextUrlString = "https://api.weibo.com/2/statuses/update.json"

/// 图片微博
let EYUpdateImageUrlString = "https://upload.api.weibo.com/2/statuses/upload.json"

/// access_token
let EYAccesstokenUrlString = "https://api.weibo.com/oauth2/access_token"

/// 映客直播列表
let EYLivesUrlString = "http://service.ingkee.com/api/live/gettop"

// MARK: - 通知信息
/// 用户需要登录通知
let EYUserShouldLoginNotification = "EYUserShouldLoginNotification"

/// 用户登录成功通知
let EYUserLoginSuccessedNotification = "EYUserLoginSuccessedNotification"

// MARK: - 照片浏览通知定义
/// @param selectedIndex    选中照片索引
/// @param urls             浏览照片 URL 字符串数组
/// @param parentImageViews 父视图的图像视图数组，用户展现和解除转场动画参照
/// 微博 Cell 浏览照片通知
let EYStatusCellBrowserPhotoNotification = "EYStatusCellBrowserPhotoNotification"
/// 选中索引 Key
let EYStatusCellBrowserPhotoSelectedIndexKey = "EYStatusCellBrowserPhotoSelectedIndexKey"
/// 浏览照片 URL 字符串 Key
let EYStatusCellBrowserPhotoURLsKey = "EYStatusCellBrowserPhotoURLsKey"
/// 父视图的图像视图数组 Key
let EYStatusCellBrowserPhotoImageViewsKey = "EYStatusCellBrowserPhotoImageViewsKey"

// MARK: - 微博配图视图常量
// 配图视图外侧的间距
let EYStatusPictureViewOutterMargin = CGFloat(12)
// 配图视图内部图像视图的间距
let EYStatusPictureViewInnerMargin = CGFloat(3)
// 视图的宽度的宽度
let EYStatusPictureViewWidth = EYScreenWidth - 2 * EYStatusPictureViewOutterMargin
// 每个 Item 默认的宽度
let EYStatusPictureItemWidth = (EYStatusPictureViewWidth - 2 * EYStatusPictureViewInnerMargin) / 3

// MARK: - 智能家居信息
let EYSecurityProtocol = "http"
let EYSmartHomeIP = EYSecurityProtocol + "://129.1.18.18:8080"

//let EYSecurityProtocol = "https"
//let EYSmartHomeIP = EYSecurityProtocol + "://api.ehomeclouds.com.cn:10443"

//登录
let EYSmartHomeLogin = EYSmartHomeIP + "/noauth/user/credential"




