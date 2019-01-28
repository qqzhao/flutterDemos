import 'dart:async';

import 'package:flutter/material.dart';

import 'dart:ui' show lerpDouble;

class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  double startHeight;
  double currentHeight;
  double endHeight;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: new Duration(seconds: 3), debugLabel: 'test')
      ..addListener(() {
        setState(() {
          currentHeight = lerpDouble(startHeight, endHeight, _controller.value);
        });
      })
      ..addStatusListener((AnimationStatus state) {
        print('state = $state');
        if (state == AnimationStatus.dismissed) {
          Navigator.of(context).maybePop();
        }
      });

    startHeight = 0.0;
    currentHeight = 0.0;
    endHeight = 200.0;
    _controller.forward();
    Timer.periodic(new Duration(milliseconds: 100), (_) {
      // 这里一直是true
//      print('TickerMode = ${TickerMode.of(context)}');
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Material(
        child: new Stack(
//          fit: StackFit.expand,
          children: <Widget>[
            new Positioned(
              bottom: currentHeight,
              child: new Container(
                color: Colors.blue,
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                child: new Center(
                    child: new Text(
                  'aaa',
                  style: new TextStyle(
                    color: Colors.red,
                    fontSize: 28.0,
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        _controller.reverse();
//        Navigator.of(context).maybePop();
      },
    );
  }
}
