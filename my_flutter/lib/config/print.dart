import 'package:flutter/material.dart';

///Log打印信息
///
/// 初始化
void setupDebugPrint() {
  debugPrint = _debugPrint;
}

void _debugPrint(Object object, {int wrapWidth}) {
  EYPrint(object, wrapWidth: wrapWidth);
}

/// Log总方法
// ignore: non_constant_identifier_names
void EYPrint(Object object, {int wrapWidth, bool isForce = false}) {
  print(object.toString());
}
