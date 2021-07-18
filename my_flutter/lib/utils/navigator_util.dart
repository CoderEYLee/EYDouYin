///路由跳转单例类
///管理 APP中的路由跳转

import 'package:my_flutter/config/print.dart';

class NavigatorUtil {
  ///初始化方法一:
  factory NavigatorUtil() => _getInstance();

  ///初始化方法二:
  static NavigatorUtil get shared => _getInstance();

  //单例存储变量
  static NavigatorUtil _instance;

  //内部初始化方法
  static NavigatorUtil _getInstance() {
    if (_instance == null) {
      _instance = NavigatorUtil._();
    }
    return _instance;
  }

  //内部实际初始化方法
  NavigatorUtil._() {
    // 初始化(不能有 await 代码)
    EYPrint('lieryang|NavigatorUtil|=->单例初始化<-=|');
  }
}
