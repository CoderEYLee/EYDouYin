///TabBar页面
import 'package:flutter/material.dart';
import 'package:my_flutter/config/print.dart';
import 'package:my_flutter/tab_bar/widget/bottom_navigation_bar.dart';
import 'package:my_flutter/views/home/home_page.dart';
import 'package:my_flutter/views/me/me_page.dart';
import 'package:my_flutter/views/study/study_page.dart';

class TabBarPage extends StatefulWidget {
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  ///控制底部 TabBar
  final Map<String, dynamic> _tabBarMap = {
    'backGroundColor': '0xAAFF0000',
    'currentIndex': 0,
    'items': [
      {'title': '首页', 'image': '1'},
      {'title': '技术', 'image': '1'},
      {'title': '我的', 'image': '1'}
    ]
  };

  ///界面数组
  List<Widget> _pageList = <Widget>[];

  ///当前页面组件
  Widget? _page;

  ///当前选中下标
  int _currentIndex = 0;

  @override
  void initState() {
    _pageList.addAll([
      HomePage(),
      StudyPage(),
      MePage(),
    ]);
    _page = _pageList.first;
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page,
      bottomNavigationBar: BottomNavigationBarWidget(
          map: _tabBarMap,
          onTap: (int? index) {
            if (index == null || index < 0 || index >= _pageList.length) {
              return;
            }

            if (index == _currentIndex) {
              return;
            }

            EYPrint('lieryang|BottomNavigationBarWidget|onTap|=->$index<-=|');
            setState(() {
              _currentIndex = index;
              _page = _pageList[index];
            });
          }),
    );
  }
}
