import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/config/print.dart';

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

  Widget _buildWrap({BuildContext context}) {
    return Column(
      children: [
        Center(
          child: Wrap(
            children: [
              _buildItem(
                  text: 'setState',
                  context: context,
                  onTap: () {
                    EYPrint('lieryang||=->setState1<-=|');
                    setState(() {
                      EYPrint('lieryang||=->setState2<-=|');
                      for (int i = 0; i < 100; i++) {
                        EYPrint('lieryang||=->setState3|$i|<-=|');
                      }
                      EYPrint('lieryang||=->setState4<-=|');
                    });
                    EYPrint('lieryang||=->setState9<-=|');
                  }),
              _buildItem(text: '测试11', context: context, onTap: () {}),
              _buildItem(text: '测试12', context: context, onTap: () {}),
              _buildItem(text: '测试13', context: context, onTap: () {}),
              _buildItem(text: '测试14', context: context, onTap: () {}),
              _buildItem(text: '测试15', context: context, onTap: () {}),
              _buildItem(text: '测试16', context: context, onTap: () {}),
              _buildItem(text: '测试17', context: context, onTap: () {}),
              _buildItem(text: '测试18', context: context, onTap: () {}),
              _buildItem(text: '测试19', context: context, onTap: () {}),
              _buildItem(text: '测试20', context: context, onTap: () {}),
              _buildItem(text: '测试21', context: context, onTap: () {}),
              _buildItem(text: '测试22', context: context, onTap: () {}),
              _buildItem(text: '测试23', context: context, onTap: () {}),
              _buildItem(text: '测试24', context: context, onTap: () {}),
              _buildItem(text: '测试25', context: context, onTap: () {}),
              _buildItem(text: '测试26', context: context, onTap: () {}),
              _buildItem(text: '测试27', context: context, onTap: () {}),
              _buildItem(text: '测试28', context: context, onTap: () {}),
              _buildItem(text: '测试29', context: context, onTap: () {}),
              _buildItem(text: '测试30', context: context, onTap: () {}),
              _buildItem(text: '测试31', context: context, onTap: () {}),
              _buildItem(text: '测试32', context: context, onTap: () {}),
              _buildItem(text: '测试33', context: context, onTap: () {}),
              _buildItem(text: '测试34', context: context, onTap: () {}),
              _buildItem(text: '测试35', context: context, onTap: () {}),
            ],
          ),
        ),
      ],
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
