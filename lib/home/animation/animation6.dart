import 'package:flutter/material.dart';

/// name: [animation6]
/// created by qqzhao on 2018/6/10

class AnimatePage6 extends StatefulWidget {
  @override
  _AnimatePage6State createState() => _AnimatePage6State();
}

class _AnimatePage6State extends State<AnimatePage6> with SingleTickerProviderStateMixin {
  late Animation<AlignmentGeometry> _animation;
  late CurvedAnimation _easeInAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = new AnimationController(duration: new Duration(seconds: 5), vsync: this);
    _easeInAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    Tween<AlignmentGeometry> _tween = AlignmentTween(
      begin: new Alignment(-1.0, 0.0),
      end: new Alignment(1.0, 0.0),
    );
//    _animation = _tween.animate(_controller);
    _animation = _tween.animate(_easeInAnimation);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      textStyle: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40.0,
        color: Colors.red,
      ),
      child: new Container(
        margin: const EdgeInsets.only(top: 30.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Align(
              alignment: Alignment(-1.0, 0.0),
              child: new Text('Header2'),
            ),
            new AlignTransition(alignment: _animation, child: new Text('Header')),
            new GestureDetector(
              onTap: () {
                print('test');
                if (_controller.isCompleted) {
                  _controller.reverse();
                } else if (_controller.isDismissed) {
                  _controller.forward();
                }
              },
              child: new Text('bbb'),
            ),
          ],
        ),
      ),
    );
  }
}

/// 使用AlignTransition，但是方法不太对。??
/// 无法构造Animation
/// AnimatedWidget应该用于无状态的Widget，这里使用了有状态的。
/// 不用添加setState语句。
