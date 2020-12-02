import 'dart:math';

import 'package:flutter/material.dart';

class TestRotatePage extends StatefulWidget {
  @override
  _TestRotatePageState createState() => _TestRotatePageState();
}

class _TestRotatePageState extends State<TestRotatePage> {
  @override
  Widget build(BuildContext context) {
    var sideLength = 30.0;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('test rotate'),
      ),
      body: new Center(
        child: new Container(
          width: 200.0,
          height: 200.0,
          color: Colors.blue,
          child: new Stack(
            alignment: Alignment.center,
            children: <Widget>[
              new Positioned(
                child: new Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.red,
                ),
              ),
              new Positioned(
                child: new Transform.rotate(
                  angle: pi / 4,
//                  origin: new Offset(sideLength / 2 * (1.414 - 1), 0),
                  child: Container(
                    width: sideLength,
                    height: sideLength,
                    color: Colors.green,
                  ),
                ),
                bottom: -sideLength / 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
