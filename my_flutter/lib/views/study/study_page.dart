///学习页面
import 'package:flutter/material.dart';
import 'package:my_flutter/config/print.dart';

class StudyPage extends StatefulWidget {
  @override
  _StudyPageState createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
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
            Text('学习页面'),
            MaterialButton(
              onPressed: () {
                EYPrint('lieryang|学习页面|=->1111<-=|');
              },
              color: Colors.red,
              child: Text('学习'),
            ),
          ],
        ),
      ),
    );
  }
}
