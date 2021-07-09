import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CanvasTouchPage extends StatefulWidget {
  @override
  _BoxTestPageState createState() => _BoxTestPageState();
}

class _BoxTestPageState extends State<CanvasTouchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('canvas touch'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            print('outer tap');
          },
          child: Container(
            width: 200,
            height: 200,
            // color: Colors.transparent,
            child: PainterWrap(
              callback1: () {
                print('callback 111');
              },
              callback2: () {
                print('callback 222');
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _MyViewModel extends ChangeNotifier {
  VoidCallback? callback1;
  VoidCallback? callback2;

  List<Shape> sharps = [];

  void handleTap(Offset position) {
    for (var sharp in sharps) {
      if (sharp.hitTest(position)) {
        sharp.callback?.call();
        break;
      }
    }
  }
}

class PainterWrap extends StatelessWidget {
  final VoidCallback? callback1;
  final VoidCallback? callback2;

  PainterWrap({this.callback1, this.callback2});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          var model = _MyViewModel();
          model.callback1 = callback1;
          model.callback2 = callback2;

          var path = Path();
          path.fillType = PathFillType.evenOdd;
          path.moveTo(0, 0);
          path.lineTo(0, 100);
          path.lineTo(100, 100);
          path.lineTo(100, 0);

          var path2 = Path();
          path2.fillType = PathFillType.evenOdd;
          path2.moveTo(100, 0);
          path2.lineTo(200, 0);
          path2.lineTo(200, 100);
          path2.lineTo(100, 100);

          var sharps = [
            Shape(
              path: path,
              color: Colors.purple,
              callback: () {
                print('11111');
                model.callback1?.call();
              },
            ),
            Shape(
              path: path2,
              color: Colors.blue,
              callback: () {
                print('22222');
                model.callback2?.call();
              },
            ),
          ];
          model.sharps = sharps;
          return model;
        }),
      ],
      child: Consumer<_MyViewModel>(
        builder: (context, vm, child) {
          return GestureDetector(
            onTapDown: (detail) {
              vm.handleTap(detail.localPosition);
            },
            child: Container(
              child: CustomPaint(
                painter: _MyPainter(shapes: vm.sharps),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MyPainter extends CustomPainter {
  _MyPainter({this.shapes = const []});
  // Path path;
  // Path path2;

  List<Shape> shapes;

  @override
  void paint(Canvas canvas, Size size) {
    // Paint paint = Paint();
    // paint.color = Colors.blue;
    // paint.style = PaintingStyle.fill;
    // canvas.drawPath(path, paint);
    // paint.color = Colors.purple;
    // canvas.drawPath(path2, paint);
    shapes.forEach((element) {
      Paint paint = Paint();
      paint.color = element.color!;
      paint.style = PaintingStyle.fill;
      canvas.drawPath(element.path!, paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  // @override
  // bool hitTest(Offset position) {
  //   bool ret = path.contains(position);
  //   return ret;
  // }
}

class Shape {
  VoidCallback? callback;
  Path? path;
  Color? color;

  Shape({this.callback, this.path, this.color});

  bool hitTest(Offset position) {
    bool ret = path!.contains(position);
    return ret;
  }
}
