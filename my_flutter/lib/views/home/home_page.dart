///首页页面
import 'package:flutter/material.dart';
import 'package:my_flutter/config/print.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
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
    );
  }
}
