import 'package:flutter/material.dart';
import 'dart:async';

class TextSize {
  static double maxFontSize = 80.0;
  static double minFontSize = 8.0;
  static double stepSize = 2.0;

  static Future<double> caculateFontSize(Size size, String text) {
    double value = _caculateFontSize(size, text);
    return Future.value(value);
  }

  static double _caculateFontSize(Size size, String text) {
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