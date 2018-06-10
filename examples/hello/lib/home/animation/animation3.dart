import 'package:flutter/material.dart';

/// name: [animation3]
/// created by qqzhao on 2018/6/10

class AnimatePage3 extends StatefulWidget {
  @override
  _AnimatePage3State createState() => _AnimatePage3State();
}

class _AnimatePage3State extends State<AnimatePage3>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: new Duration(seconds: 2))
      ..addListener((){
        // 必须有这一句，否则状态不变更。
        setState(() {
        });
      });

    // 插值，将_controller中的（0，1）映射到AlignmentTween中的（-1，1）
    Tween _tween = new AlignmentTween(
      begin: new Alignment(-1.0, 0.0),
      end: new Alignment(1.0, 1.0),
    );
    _animation = _tween.animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {

    _controller.dispose();
    print('anmation3 dispose');

    // 生成的代码有问题，这一句需要放到最后。(_controller.dispose()语句之后，否则动画过程中退出会出问题。)
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
          alignment: _animation.value, //
        )
      ],
    );

    return new Material(
      child: newWidget,
    );
  }
}



