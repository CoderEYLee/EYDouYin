///底部Tabbar
///
import 'package:flutter/material.dart';
import 'package:my_flutter/config/print.dart';
import 'package:my_flutter/model/darts/tab_bar/tab_bar.pb.dart';
import 'package:my_flutter/utils/safe.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final Map<String, dynamic> map;
  final Function(Map<String, dynamic>) onTap;

  const BottomNavigationBarWidget({
    Key key,
    this.map,
    this.onTap,
  }) : super(key: key);

  @override
  _BottomNavigationBarWidgetState createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  TabBarModel _tabBarModel = TabBarModel();
  Color _backGroundColor;

  //当前选中下标
  int _currentIndex = 0;

  @override
  void initState() {
    _tabBarModel = TabBarModel.fromJsonObject(widget.map);
    _backGroundColor = Color(safeInt(_tabBarModel.backGroundColor, defaultValue: 0xFFFFFFFF));
    _currentIndex = _tabBarModel.currentIndex;
    EYPrint('lieryang||=->$_tabBarModel<-=|');

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //每一个 item
  Widget _buildItem({String title = ''}) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          widget.onTap?.call({});
        },
        child: Center(
          child: Text(title),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _backGroundColor,
      child: SafeArea(
        child: Container(
          height: 50,
          color: _backGroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _tabBarModel.items.map((e) {
              return _buildItem(title: e.title);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
