///我的页面
import 'package:flutter/material.dart';
import 'package:my_flutter/config/print.dart';

class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
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
            Text('我的页面'),
            MaterialButton(
              onPressed: () {
                EYPrint('lieryang|我的页面|=->1111<-=|');
              },
              color: Colors.red,
              child: Text('我的'),
            ),
          ],
        ),
      ),
    );
  }
}
