///用户信息的单例

import 'package:my_flutter/config/print.dart';

class UserManager {
  ///初始化方法一:
  factory UserManager() => _getInstance();

  ///初始化方法二:
  static UserManager get shared => _getInstance();

  //单例存储变量
  static UserManager _instance;

  //内部初始化方法
  static UserManager _getInstance() {
    if (_instance == null) {
      _instance = UserManager._();
    }
    return _instance;
  }

  //内部实际初始化方法
  UserManager._() {
    // 初始化(不能有 await 代码)
    EYPrint('lieryang|UserManager|=->单例初始化<-=|');
  }
}
