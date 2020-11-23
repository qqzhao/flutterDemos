import 'dart:async';

import 'package:flutter/material.dart';

class SimpleRenderPage2 extends StatefulWidget {
  @override
  _SimpleRenderPage2State createState() => _SimpleRenderPage2State();
}

class _SimpleRenderPage2State extends State<SimpleRenderPage2> {
  Color _color = Colors.red;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      print('setState');
      setState(() {
        _color = Colors.blue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test simple bar'),
      ),
      body: Container(
        child: ColorfulWidget(
          color: _color,
          key: const Key('111'),
        ),
      ),
    );
  }
}

class ColorfulWidget extends StatefulWidget {
  final Color color;
  // final Key key;
  ColorfulWidget({this.color, Key key}) : super(key: key);

  @override
  _ColorfulWidgetState createState() => _ColorfulWidgetState();
}

class _ColorfulWidgetState extends State<ColorfulWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: widget.color,
    );
  }
}
