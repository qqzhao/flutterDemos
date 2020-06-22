import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// https://www.jianshu.com/p/7c205fdf756a
class CircleView extends SingleChildRenderObjectWidget {
  @override
  RenderObject createRenderObject(BuildContext context) {
    print('createRenderObject');
    return RenderCircle();
  }
}

class RenderCircle extends RenderBox {
  //布局设置为最大，相当于android的match_parent
  Paint _paint;

  /// ignore: unused_field
  Path _path;

  RenderCircle() {
    _paint = Paint();
    _paint.isAntiAlias = true;
    _paint.style = PaintingStyle.fill;
    _path = Path();
  }

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    print('size = $size');
    var canvas = context.canvas;
    //平移画布移至屏幕中心点, 这里y轴上面有问题。
    canvas.translate(size.width / 2, size.height / 2);
    //绘制表格
    double width = 160;

    //绘制坐标
    _paint.strokeWidth = 2;
    _paint.color = Colors.black;
    canvas.drawLine(Offset(width, 0), Offset(-width, 0), _paint);
    canvas.drawLine(Offset(0, -width), Offset(0, width), _paint);
  }
}

class CircleView2 extends SingleChildRenderObjectWidget {
  @override
  RenderObject createRenderObject(BuildContext context) {
    print('createRenderObject');
    return RenderCircle2();
  }
}

class RenderCircle2 extends RenderBox {
  //布局设置为最大，相当于android的match_parent
  Paint _paint;
  Path _path;
  double textWidth = 100;
  double textFontSize = 12.0;
  ui.Paragraph paragraph;

  RenderCircle2() {
    _paint = Paint();
    _paint.isAntiAlias = true;
    _paint.style = PaintingStyle.fill;
    _path = Path();
    ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.center,
        fontSize: textFontSize,
        textDirection: TextDirection.ltr,
        maxLines: 1,
      ),
    )
      ..pushStyle(
        ui.TextStyle(color: Colors.black87, textBaseline: ui.TextBaseline.alphabetic),
      )
      ..addText("六芒星咒符");

    paragraph = paragraphBuilder.build()..layout(ui.ParagraphConstraints(width: textWidth));
  }

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    print('size22 = $size');
    var canvas = context.canvas;
    canvas.translate(size.width / 2, size.height / 2);

    //绘制表格
    double width = 160;
    for (double i = -width; i <= width; i += 10) {
      _paint.strokeWidth = 1;
      _paint.color = Colors.grey;
      canvas.drawLine(Offset(width, i), Offset(-width, i), _paint);
      canvas.drawLine(Offset(i, -width), Offset(i, width), _paint);
    }
    //绘制坐标
    _paint.strokeWidth = 2;
    _paint.color = Colors.black;
    canvas.drawLine(Offset(width, 0), Offset(-width, 0), _paint);
    canvas.drawLine(Offset(0, -width), Offset(0, width), _paint);

    //绘制外圈
    _paint.strokeWidth = 1.5;
    _paint.color = Colors.blueAccent;
    _paint.style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(0, 0), 100, _paint);
    canvas.drawCircle(Offset(0, 0), 120, _paint);

    //绘制六芒星
    _paint.color = Colors.redAccent;
    _paint.strokeWidth = 2;
    _path.moveTo(0, -100);
    _path.lineTo(0.85 * 100, 0.5 * 100);
    _path.lineTo(-0.85 * 100, 0.5 * 100);
    _path.lineTo(0, -100);
    _path.moveTo(0, 100);
    _path.lineTo(0.85 * 100, -0.5 * 100);
    _path.lineTo(-0.85 * 100, -0.5 * 100);
    _path.lineTo(0, 100);
    canvas.drawPath(_path, _paint);

    canvas.drawParagraph(paragraph, Offset(-textWidth / 2, -textFontSize / 2));
  }
}

class TestRenderBoxPage extends StatefulWidget {
  @override
  _TestRenderBoxPageState createState() => _TestRenderBoxPageState();
}

class _TestRenderBoxPageState extends State<TestRenderBoxPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test render box'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 30.0),
//        constraints: BoxConstraints(maxHeight: 300.0, maxWidth: 300.0, minWidth: 200.0, minHeight: 200.0),
        color: Colors.red[100],
        child: Center(
          child: CircleView2(),
        ),
      ),
    );
  }
}
