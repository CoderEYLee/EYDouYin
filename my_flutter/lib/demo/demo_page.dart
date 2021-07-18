import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Demo页面
class DemoPage extends StatefulWidget {
  final RouteSettings settings;

  DemoPage({this.settings, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //每一个点击按钮
  Widget _buildItem({String text, BuildContext context, VoidCallback onTap}) {
    var wh = (MediaQuery.of(context).size.width - 40) * 0.2;
    Color randomColor = Color.fromARGB(0xFF, Random().nextInt(0xFF), Random().nextInt(0xFF), Random().nextInt(0xFF));
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        color: randomColor,
        width: wh,
        height: wh,
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 17, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Demo',
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          children: <Widget>[
            //_buildWrap(context: context),
          ].where((o) => o != null).toList(),
        ));
  }
}
