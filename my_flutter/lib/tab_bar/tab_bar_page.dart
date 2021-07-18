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
  List<Widget> _pageList = List<Widget>();

  @override
  void initState() {
    _pageList.addAll([
      HomePage(),
      StudyPage(),
      MePage(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('TabbarPage页面'),
            MaterialButton(
              onPressed: () {
                EYPrint('lieryang||=->1111<-=|');
              },
              color: Colors.red,
              child: Text('按钮'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
          map: _tabBarMap,
          onTap: (Map<String, dynamic> map) {
            EYPrint('lieryang|BottomNavigationBarWidget|onTap|=->$map<-=|');
          }),
    );
  }
}
