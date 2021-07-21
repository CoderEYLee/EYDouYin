///底部Tabbar
///
import 'package:flutter/material.dart';
import 'package:my_flutter/model/darts/tab_bar/tab_bar.pb.dart';
import 'package:my_flutter/utils/safe.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final Map<String, dynamic> map;
  final Function(int index) onTap;

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

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //底部信息
  List<Widget> _buildItems() {
    List<Widget> _results = List<Widget>();

    for (int i = 0; i < _tabBarModel.items.length; i++) {
      TabBarItemModel _model = _tabBarModel.items[i];
      _results.add(_buildItem(
        title: _model.title,
        index: i,
      ));
    }

    return _results;
  }

  //每一个 item
  Widget _buildItem({String title = '', int index = 0}) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          setState(() {
            _currentIndex = index;
          });

          widget.onTap?.call(index);
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
            children: _buildItems(),
          ),
        ),
      ),
    );
  }
}
