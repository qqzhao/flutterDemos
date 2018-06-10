import 'package:flutter/material.dart';

/// name: [animation7]
/// created by qqzhao on 2018/6/10

class AnimatePage7 extends StatefulWidget {
  @override
  _AnimatePage7State createState() => _AnimatePage7State();
}

class _AnimatePage7State extends State<AnimatePage7>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation _easyIn;
  Animation<double> _scaleAnimation;
  Animation<double> _rotateAnimation;
  Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: new Duration(seconds: 5));
    Tween _tween = new Tween<double>(
      begin: 0.2,
      end: 1.8,
    );
    _easyIn = new CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _scaleAnimation = _tween.animate(_easyIn);

    _rotateAnimation = _tween.animate(
        new CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

    Tween _tween2 = new Tween<double>(
      begin: 0.1,
      end: 1.0,
    );
    _sizeAnimation = _tween2.animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildContent(BuildContext context, Widget child) {
    return new Material(
      textStyle: new TextStyle(
        fontSize: 40.0,
        color: Colors.red,
      ),
      child: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            child,
            new ScaleTransition(
              scale: _scaleAnimation,
              child: new Text('ZZ'),
            ),
            new RotationTransition(
              turns: _scaleAnimation,
              child: new Text("Rotate"),
            ),
            new SizeTransition(
              sizeFactor: _sizeAnimation,
              axisAlignment: -1.0,// -1: 从下往上，0，两边，1从上往下。
              child: new Text('Size'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      animation: _controller.view,
      builder: _buildContent,
//      child: new ScaleTransition(
//        scale: _rotateAnimation,
//        child: new Text('AA'), // 这里的child通常提前构建。
//      ),
      child: new Text('Static'),
    );
  }
}

/// AnimatedBuilder的用法。
/// 基本实现了 ScaleTransition，RotationTransition，SizeTransition
