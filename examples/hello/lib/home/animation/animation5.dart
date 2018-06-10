import 'package:flutter/material.dart';

/// name: [animation5]
/// created by qqzhao on 2018/6/10

class AnimatePage5 extends StatefulWidget {
  @override
  _AnimatePage5State createState() => _AnimatePage5State();
}

class _AnimatePage5State extends State<AnimatePage5>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: new Duration(seconds: 5),
      lowerBound: -10.0,// 会影响到0-1的映射
      upperBound: 10.0,
    )
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      textStyle: new TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
      child: new GestureDetector(
        onTap: () {
          print('tap clicked');
          if (_controller.isCompleted){
            _controller.reverse();
          } else if (_controller.isDismissed){
            _controller.forward();
          }
        },
        child: new Center(
          child: _controller.isAnimating
              ? new Text(_controller.value.toStringAsFixed(3)
          )
              : new Text('Tap me!!'),
        ),
      ),
    );
  }
}

/// 基础动画例子，了解动画的步骤：
/// https://sergiandreplace.com/flutter-animations-the-basics/