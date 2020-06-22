import 'dart:async';

import 'package:flutter/material.dart';

class TextSize {
  static double maxFontSize = 40.0;
  static double minFontSize = 20.0;
  static double stepSize = 2.0;

  static Future<double> calculateFontSize(Size size, String text) {
    double value = _calculateFontSize(size, text);
    return Future.value(value);
  }

  static double calculateFontSizeSync(Size size, String text) {
    double value = _calculateFontSize(size, text);
    return value;
  }

  static double _calculateFontSize(Size size, String text) {
    assert(size.width >= 30.0);
    assert(size.height >= 10.0);
    assert(text.length >= 0);

    TextPainter painter = new TextPainter(
      text: new TextSpan(
          text: text,
          style: new TextStyle(
            fontSize: maxFontSize,
          )),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      textScaleFactor: 1.0,
      maxLines: 1000,
    );

    painter.layout(minWidth: 0.0, maxWidth: size.width);
    double height = painter.height;
//    print("temp height = $height");

    double myFontSize = maxFontSize;

    while (height >= size.height && myFontSize >= minFontSize) {
      myFontSize = myFontSize - stepSize;
      painter.text = new TextSpan(
          text: text,
          style: new TextStyle(
            fontSize: myFontSize,
            color: Colors.red,
          ));
      painter.layout(minWidth: 0.0, maxWidth: size.width);
      height = painter.height;
//      print("temp height = $height, myFontSize = $myFontSize");
    }

    return myFontSize;
  }
}

// < 30 ,并且有\n 换行符号的时候，iOS会出现crash。
