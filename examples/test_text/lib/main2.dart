import 'package:flutter/material.dart';
import 'package:test_text/base.dart';

Brightness curBright = Brightness.light;

void main() => runApp(new MaterialApp(
      home: BaseTextWidthPage(),
      theme: new ThemeData(
        primaryColorLight: Colors.purple,
        brightness: curBright,
        primaryColorBrightness: curBright,
        accentColorBrightness: curBright,
//        fontFamily: 'PingFang SC',
      ),
    ));
