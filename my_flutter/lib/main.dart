import 'package:flutter/material.dart';
import 'package:my_flutter/config/config_theme.dart';
import 'package:my_flutter/tab_bar/tab_bar_page.dart';

void main() => runApp(FlutterApp());

class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo1',
      theme: themeData,
      home: TabBarPage(),
    );
  }
}