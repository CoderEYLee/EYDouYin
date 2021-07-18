///App的管理者

import 'package:my_flutter/config/print.dart';

class AppManager {
  ///初始化方法一:
  factory AppManager() => _getInstance();

  ///初始化方法二:
  static AppManager get shared => _getInstance();

  //单例存储变量
  static AppManager _instance;

  //内部初始化方法
  static AppManager _getInstance() {
    if (_instance == null) {
      _instance = AppManager._();
    }
    return _instance;
  }

  //内部实际初始化方法
  AppManager._() {
    // 初始化(不能有 await 代码)
    EYPrint('lieryang|AppManager|=->单例初始化<-=|');
  }
}
