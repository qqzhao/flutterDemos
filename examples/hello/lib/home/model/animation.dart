import 'package:flutter/material.dart';

import 'dart:ui' show lerpDouble;

class TEWordPage extends StatefulWidget {

  @override
  _TEWordPageState createState() => _TEWordPageState();
}

class _TEWordPageState extends State<TEWordPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  double startHeight;
  double currentHeight;
  double endHeight;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: new Duration(seconds: 3), debugLabel: 'test')
      ..addListener((){
        setState(() {
          currentHeight = lerpDouble(
              startHeight,
              endHeight,
              _controller.value
          );
        });
      })
      ..addStatusListener((AnimationStatus state){
        print('state = $state');
        if (state == AnimationStatus.dismissed){
          Navigator.of(context).maybePop();
        }
      });

    startHeight = 200.0;
    currentHeight = 10.0;
    endHeight = 0.0;
//    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text('AAA'),
            new Container(
              padding: new EdgeInsets.only(top: currentHeight),
//              height: 200.0,
//              color: Colors.red,
              child: new Align(
                child: new Container(
                  color: Colors.blue,
                  child: new Align(
                    child: new Container(
                      height: 200.0,
                      child: new Text('aaa'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
//        _controller.reverse();
        Navigator.of(context).maybePop();
      },
    );
  }
}
