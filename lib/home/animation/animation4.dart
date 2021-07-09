import 'dart:math';

import 'package:flutter/material.dart';

/// name: [animation4]
/// created by qqzhao on 2018/6/10

class AnimatePage4 extends StatefulWidget {
  @override
  _AnimatePage4State createState() => _AnimatePage4State();
}

class _AnimatePage4State extends State<AnimatePage4> with SingleTickerProviderStateMixin {
  static const faceLeftAngle = -pi / 2;
  static const faceRightAngle = pi / 2;
  double _angle = faceRightAngle;

  late AnimationController _controller;

  late Animation<AlignmentGeometry> _animation1;
  late Animation<AlignmentGeometry> _animation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: new Duration(seconds: 3))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
          _angle = faceLeftAngle;
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
          _angle = faceRightAngle;
        }
      });

    Tween<AlignmentGeometry> _tween = AlignmentTween(
      begin: Alignment(-1.0, 0.0),
      end: Alignment(1.0, 0.0),
    );
    _animation1 = _tween.animate(_controller);

    Tween<AlignmentGeometry> _tween2 = AlignmentTween(
      begin: Alignment(-1.0, -1.0),
      end: Alignment(1.0, 1.0),
    );
    _animation2 = _tween2.animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget newWidget = new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new FractionallySizedBox(
          widthFactor: 0.2,
          heightFactor: 0.2,
          child: new Icon(
            Icons.flight,
            size: 40.0,
          ),
          alignment: _animation1.value,
        ),
        new FractionallySizedBox(
          widthFactor: 0.2,
          heightFactor: 0.2,
          child: new Transform.rotate(
            angle: _angle,
            child: new Icon(
              Icons.flight,
              size: 80.0,
              color: Colors.red,
            ),
          ),
          alignment: _animation2.value,
        ),
      ],
    );

    return new Material(
      child: newWidget,
    );
  }
}

/// 跑两架小飞机
/// https://sergiandreplace.com/flutter-animations-using-animationcontroller-and-introducing-tweens/
