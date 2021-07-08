import 'package:flutter/material.dart';
import 'package:my_flutter/config/config_theme.dart';
import 'package:my_flutter/config/print.dart';
import 'package:my_flutter/tab_bar/tab_bar_page.dart';

void main() {
  //1.设置打印
  setupDebugPrint();

  //2.Flutter 的错误
  FlutterError.onError = (FlutterErrorDetails details) {
    EYPrint('lieryang|FlutterError|->$details');
  };

  //3.启动 App
  runApp(FlutterApp());
}

class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: TabBarPage(),
    );
  }
}
