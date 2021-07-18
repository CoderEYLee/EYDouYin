///https://www.jianshu.com/p/6ed6f7de01ff
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/config/print.dart';
import 'package:my_flutter/demo/demo_page.dart';

// 测试生命周期页面
class TestStatefulWidgetPage extends StatefulWidget {
  final RouteSettings settings;

  TestStatefulWidgetPage({this.settings, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    EYPrint('lieryang|测试生命周期页面|=->createState<-=|');
    return _TestStatefulWidgetPageState();
  }
}

class _TestStatefulWidgetPageState extends State<TestStatefulWidgetPage> {
  ///该函数为 State 初始化调用，
  ///因此可以在此期间执行 State 各变量的初始赋值，
  ///同时也可以在此期间与服务端交互，
  ///获取服务端数据后调用 setState 来设置 State
  @override
  void initState() {
    ///初始化,viewDidLoad
    EYPrint('lieryang|测试生命周期页面|=->initState<-=|');
    super.initState();
  }

  ///情况一：调用initState会调用；
  ///情况二：从其他对象中依赖一些数据发生改变时，
  ///比如前面我们提到的InheritedWidget；
  @override
  void didChangeDependencies() {
    ///initState之后立即调用
    EYPrint('lieryang|测试生命周期页面|=->didChangeDependencies<-=|');
    super.didChangeDependencies();
  }

  ///主要是提供开发阶段使用，
  ///在 debug 模式下，
  ///每次热重载都会调用该函数，
  ///因此在 debug 阶段可以在此期间增加一些 debug 代码，
  ///来检查代码问题
  @override
  void reassemble() {
    EYPrint('lieryang|测试生命周期页面|=->reassemble<-=|');
    super.reassemble();
  }

  ///该函数主要是在组件重新构建，
  ///比如说热重载，父组件发生 build 的情况下，
  ///子组件该方法才会被调用，
  ///其次该方法调用之后一定会再调用本组件中的 build 方法。
  @override
  void didUpdateWidget(TestStatefulWidgetPage oldWidget) {
    EYPrint('lieryang|测试生命周期页面|=->didUpdateWidget<-=|');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    EYPrint('lieryang|测试生命周期页面|=->setState<-=|');
    super.setState(fn);
  }

  ///在组件被移除节点后会被调用，
  ///如果该组件被移除节点，
  ///然后未被插入到其他节点时，
  ///则会继续调用 dispose 永久移除。
  @override
  void deactivate() {
    ///失去活跃
    EYPrint('lieryang|测试生命周期页面|=->deactivate<-=|');
    super.deactivate();
  }

  ///永久移除组件，并释放组件资源。
  @override
  void dispose() {
    ///销毁,dealloc
    EYPrint('lieryang|测试生命周期页面|=->dispose<-=|');
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
                    setState(() {});
                  }),
              _buildItem(
                  text: 'Demo页面',
                  context: context,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return DemoPage(
                        settings: RouteSettings(),
                      );
                    }));
                  }),
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

  ///主要是返回需要渲染的 Widget ，
  ///由于 build 会被调用多次，
  ///因此在该函数中只能做返回 Widget 相关逻辑，
  ///避免因为执行多次导致状态异常。
  @override
  Widget build(BuildContext context) {
    EYPrint('lieryang|测试生命周期页面|=->build<-=|');
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            '测试生命周期',
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          children: <Widget>[
            _buildWrap(context: context),
            SizedBox(
              height: 20,
            ),
            // DemoWidget(),
          ].where((o) => o != null).toList(),
        ));
  }
}
