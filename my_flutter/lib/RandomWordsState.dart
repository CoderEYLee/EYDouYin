import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

class RandomWordsState extends State {

  final _suggestions = [];

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/2.png'),
          ],
        ),
      ),
    );
  }
}
