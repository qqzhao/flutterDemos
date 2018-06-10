import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// created by qqzhao on 2018/6/10

class AnimatePage2 extends StatefulWidget {
  @override
  _AnimatePage2State createState() => _AnimatePage2State();
}

class _AnimatePage2State extends State<AnimatePage2>
    with SingleTickerProviderStateMixin{
  AnimationController _controller;

//  Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(duration:  new Duration(milliseconds: 1000),vsync: this, lowerBound: -1.0, upperBound: 1.0)
      ..addListener(() {
//        print('addListener');
        setState(() {
        });
      })
      ..addStatusListener((state) {
//        print('state = $state');
        if (AnimationStatus.completed == state){
          _controller.reverse();
        } else if (AnimationStatus.dismissed == state){
          _controller.forward();
        }
      });
    _controller.forward(from: 0.0);
//    print('_ticker = $_ticker');
  }

  @override
  void dispose() {
    print('animate2 dispose');
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget newWidget = new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new FractionallySizedBox(
          child: new Container(
            color: Colors.grey,
            child: new Icon(
              Icons.flight,
              size: 80.0,
            ),
          ),
          heightFactor: 0.2,
          widthFactor: 0.2,
          alignment: new Alignment(_controller.value, 0.0), //
        )
      ],
    );

    return new Material(
      child: newWidget,
    );
  }
}

/// 初步： 使用Controller的值进行计算。从low->upper.
/// https://sergiandreplace.com/flutter-animations-using-animationcontroller-and-introducing-tweens/
