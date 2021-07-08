import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/config/print.dart';

class DemoWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    EYPrint('lieryang|DemoWidget|=->createState<-=|');
    return _DemoWidgetState();
  }
}

class _DemoWidgetState extends State<DemoWidget> {
  @override
  void initState() {
    EYPrint('lieryang|DemoWidget|=->initState<-=|');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    EYPrint('lieryang|DemoWidget|=->didChangeDependencies<-=|');
    super.didChangeDependencies();
  }

  @override
  void reassemble() {
    EYPrint('lieryang|DemoWidget|=->reassemble<-=|');
    super.reassemble();
  }

  @override
  void didUpdateWidget(DemoWidget oldWidget) {
    EYPrint('lieryang|DemoWidget|=->didUpdateWidget<-=|');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    EYPrint('lieryang|DemoWidget|=->setState<-=|');
    super.setState(fn);
  }

  @override
  void deactivate() {
    EYPrint('lieryang|DemoWidget|=->deactivate<-=|');
    super.deactivate();
  }

  @override
  void dispose() {
    EYPrint('lieryang|DemoWidget|=->dispose<-=|');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EYPrint('lieryang|DemoWidget|=->build<-=|');
    return Container(
      width: 300,
      height: 100,
      color: Colors.red,
    );
  }
}
