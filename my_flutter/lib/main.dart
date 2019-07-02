import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // 创建一个给原生(OC)通道 (类似iOS的通知）
  static const methodChannel = const MethodChannel('com.pages.your/native_get');

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;

      print('flutter的log打印：现在输出count=$_counter');
      // 当个数累积到3的时候给客户端发参数
      if(_counter == 3) {
        _toNativeSomethingAndGetInfo();
      }

      // 当个数累积到5的时候给客户端发参数
      if(_counter == 1002) {
        Map<String, String> map = { "title": "这是一条来自flutter的参数" };
        methodChannel.invokeMethod('toNativePush', map);
      }

      // 当个数累积到8的时候给客户端发参数
      if(_counter == 1005) {
        Map<String, dynamic> map = { "content": "flutterPop回来", "data": [1,2,3,4,5]};
        methodChannel.invokeMethod('toNativePop', map);
      }
    });
  }

  // 给客户端发送一些东东 , 并且拿到一些东东
  Future<Null> _toNativeSomethingAndGetInfo() async {
    dynamic result;
    try {
      result = await methodChannel.invokeMethod('toNativeSomething','大佬你点击了$_counter下');
    } on PlatformException catch (e)  {
      print("OC回调给 Flutter1 $e");
      result = 100000;
    }
    setState(() {
      // 类型判断
      if (result is int) {
        print("OC回调给 Flutter2 $result");
        _counter = result;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
