import 'dart:async';
import 'dart:math';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

int _buildCount = 0;
bool needShowSpeak = true;
bool openTimer = false;
bool openTitleAnimation = true;

class TestCustomPainterInListView extends StatefulWidget {
  @override
  _TestCustomPainterInListViewState createState() => _TestCustomPainterInListViewState();
}

class _TestCustomPainterInListViewState extends State<TestCustomPainterInListView> with SingleTickerProviderStateMixin {
  int testCount = 0;
  Timer timer;
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    _buildCount = 0;
    super.initState();
    if (openTimer) {
      /// 去更新state的时候，会调用
      /// TestWidgetStack build...
      /// shouldRepaint in
      /// shouldRepaint in
      /// shouldRepaint in
      /// 不会真正的去paint
      timer = Timer.periodic(Duration(milliseconds: 3000), (_) {
        setState(() {
          testCount = testCount + 1;
        });
      });
    }

    if (openTitleAnimation) {
      animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
        ..addListener(() {
          setState(() {});
        });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: new EdgeInsets.only(left: animationController.value * 180.0),
          child: Text('test custom painter :$testCount'),
        ),
      ),
      body: TestRepaintBoundaryWidget(),
      floatingActionButton: openTitleAnimation
          ? FlatButton(
              onPressed: () {
                animationController.forward();
              },
              child: Text('aa'))
          : Container(),
    );
  }
}

/// 最初出现问你的场景
class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return CustomPaint(
              painter: _TestArrowBoxPainter(),
              child: Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 220.0,
                      width: 30.0,
                      child: needShowSpeak
                          ? FlareActor(
                              "assets/flrs/speaker.flr",
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                              color: Color(0xFF000000),
                              animation: false ? 'playing' : 'normal',
                              callback: (String str) {
                                print('callback str = $str');
                              },
                            )
                          : Container(),
                    ),
                    Text('title: $index'),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

/// 这种也是好使的。
class TestRepaintBoundaryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return CustomPaint(
              painter: _TestArrowBoxPainter(),
              child: RepaintBoundary(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 220.0,
                        width: 30.0,
                        child: needShowSpeak
                            ? FlareActor(
                                "assets/flrs/speaker.flr",
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                                color: Color(0xFF000000),
                                animation: false ? 'playing' : 'normal',
                                callback: (String str) {
                                  print('callback str = $str');
                                },
                              )
                            : Container(),
                      ),
                      Text('title: $index'),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

/// 没解决问题，依然去刷新了。
class TestWidgetStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('TestWidgetStack build...');
    return Container(
      child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return Stack(
              children: <Widget>[
                Container(
                  height: 220.0,
                  width: 30.0,
                  child: CustomPaint(
                    painter: _TestArrowBoxPainter(),
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 220.0,
                        width: 30.0,
                        child: needShowSpeak
                            ? FlareActor(
                                "assets/flrs/speaker.flr",
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                                color: Color(0xFF000000),
                                animation: false ? 'playing' : 'normal',
                                callback: (String str) {
                                  print('callback str = $str');
                                },
                              )
                            : Container(),
                      ),
                      Text('title: $index'),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

/// Exception
class TestWidgetScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('TestWidgetStack build...');
    return Container(
      child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return Scaffold(
              appBar: AppBar(
                title: Container(
                  height: 220.0,
                  width: 30.0,
                  child: CustomPaint(
                    painter: _TestArrowBoxPainter(),
                  ),
                ),
              ),
              body: Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 220.0,
                      width: 30.0,
                      child: needShowSpeak
                          ? FlareActor(
                              "assets/flrs/speaker.flr",
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                              color: Color(0xFF000000),
                              animation: false ? 'playing' : 'normal',
                              callback: (String str) {
                                print('callback str = $str');
                              },
                            )
                          : Container(),
                    ),
                    Text('title: $index'),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

/// 不会去刷新，这种可以使用
class TestWidgetOther extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('TestWidgetStack build...');
    return Container(
      child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            var widget1 = Container(
              height: 220.0,
              width: 30.0,
              child: CustomPaint(
                painter: _TestArrowBoxPainter(),
              ),
            );
            var widget2 = Row(
              children: <Widget>[
                Container(
                  height: 220.0,
                  width: 30.0,
                  child: needShowSpeak
                      ? FlareActor(
                          "assets/flrs/speaker.flr",
                          alignment: Alignment.center,
                          fit: BoxFit.contain,
                          color: Color(0xFF000000),
                          animation: false ? 'playing' : 'normal',
                          callback: (String str) {
                            print('callback str = $str');
                          },
                        )
                      : Container(),
                ),
                Text('title: $index'),
              ],
            );
            return Stack(
              children: <Widget>[
                RepaintBoundary(
                  child: widget1,
                ),
                RepaintBoundary(
                  child: widget2,
                )
              ],
            );
          }),
    );
  }
}

class _TestArrowBoxPainter extends CustomPainter {
  final double radius;
  final double borderDistance;
  final Color borderColor;
  final Color fillColor;
  final double borderWidth;

  final double arrowToTop;
  final double arrowHeight;
  final double arrowWidth;

  Paint borderPaint;
  Paint fillPaint;

  _TestArrowBoxPainter({
    this.radius = 1.0,
    this.borderDistance = 1.0,
    this.borderColor = Colors.blue,
    this.fillColor = Colors.red,
    this.borderWidth = 1.0,
    this.arrowHeight = 20.0,
    this.arrowWidth = 20.0,
    this.arrowToTop = 15.0,
  }) {
    this.borderPaint = new Paint()
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;
    this.fillPaint = new Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
  }

  @override
  bool shouldRepaint(_TestArrowBoxPainter old) {
    print('shouldRepaint in ');
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _buildCount++;
    print('paint in : $_buildCount');
    double radius = this.radius;
    if (radius > size.width / 2.0) {
      radius = size.width / 2.0;
    }
    if (radius > size.height / 2.0) {
      radius = size.height / 2.0;
    }

    var arrowToTop = this.arrowToTop;
    if (arrowToTop <= radius) {
      arrowToTop = radius;
    }

    final Path p = new Path()
      ..moveTo(radius, -borderDistance)
      ..lineTo(size.width - radius, -borderDistance) // 上边线
      ..arcTo(Rect.fromCircle(center: Offset(size.width - radius, radius), radius: radius + borderDistance), -pi / 2.0, pi / 2.0, false)
      ..lineTo(size.width + borderDistance, size.height - radius) // 右边线
      ..arcTo(Rect.fromCircle(center: Offset(size.width - radius, size.height - radius), radius: radius + borderDistance), 0.0, pi / 2.0, false)
      ..lineTo(radius, size.height + borderDistance) // 下边线
      ..arcTo(Rect.fromCircle(center: Offset(radius, size.height - radius), radius: radius + borderDistance), pi / 2.0, pi / 2.0, false)
      ..lineTo(-borderDistance, arrowToTop + arrowHeight) //左边线
      ..arcToPoint(Offset(-borderDistance - arrowWidth, arrowToTop - 2.0), radius: Radius.circular(25.0)) //
      ..arcToPoint(Offset(-borderDistance, arrowToTop), radius: Radius.circular(20.0), clockwise: false) //
      ..lineTo(-borderDistance, radius) //左边线
      ..arcTo(Rect.fromCircle(center: Offset(radius, radius), radius: radius + borderDistance), pi, pi / 2.0, false)
      ..close();

    canvas.drawPath(p, borderPaint); //描边
    canvas.drawShadow(p, Color(0x2207050A), 5.0, true); //给边框加shader
    canvas.drawPath(p, fillPaint); //填充
  }
}
