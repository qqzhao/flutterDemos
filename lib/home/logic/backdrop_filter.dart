import 'dart:ui';

import 'package:flutter/material.dart';

/// 高斯模糊的效果，还可以。
class TestBackdropFilterPage extends StatefulWidget {
  @override
  _TestBackdropFilterPageState createState() => _TestBackdropFilterPageState();
}

class _TestBackdropFilterPageState extends State<TestBackdropFilterPage> {
  @override
  Widget build(BuildContext context) {
    var testWidget = Container(
      width: 100.0,
      height: 100.0,
      color: Colors.blue,
      child: Text(
        'this is test string fasj jflsjdfl jfslkj fal',
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('TestBackdropFilterPage'),
      ),
      body: Column(
        children: <Widget>[
          BackdropFilterWrap(
            child: testWidget,
            width: 200.0,
            height: 100.0,
          ),
          Text('aaa'),
        ],
      ),
    );
  }
}

class BackdropFilterWrap extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  BackdropFilterWrap({@required this.child, this.width = 100.0, this.height = 100.0});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: width,
          height: height,
          child: child,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 2,
            sigmaY: 2,
          ),
          child: new Container(
            width: width,
            height: height,
            color: Colors.white.withOpacity(0.1),
          ),
        ),
      ],
    );
  }
}
