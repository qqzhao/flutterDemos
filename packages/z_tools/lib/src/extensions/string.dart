import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart' show DateFormat;

const stringExt = "for import use";

extension StringCoder on String {
  String get tcrBase64Encode {
    try {
      var base64Str = base64.encode(utf8.encode(this));
      return base64Str;
    } catch (e) {
      print('tcrBase64 encode fail: $e');
    }
    return '';
  }

  String get tcrBase64Decode {
    try {
      var base64Str = utf8.decode(base64.decode(this));
      return base64Str;
    } catch (e) {
      print('tcrBase64 decode fail: $e');
    }
    return '';
  }
}

extension StringUpdateUrl on String {
  String get tcrGetUpdateUrl {
    if (this.isEmpty) return this;

    final f = new DateFormat('yyyy-MM-dd-hhmm');
    var dataStr = f.format(DateTime.now());
    if (this.contains('?')) {
      return '$this&dataRand=$dataStr';
    } else {
      return '$this?dataRand=$dataStr';
    }
  }
}

extension StringTextHeight on String {
  double textSizeHeight({TextStyle style, double maxWidth = 100}) {
    final TextPainter textPainter = TextPainter(text: TextSpan(text: this, style: style), maxLines: 100000, textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: maxWidth);
    return textPainter.size.height;
  }

  /// maxLines 不生效，只可以根据宽度计算高度，所以这里只有一行。
  double textSizeWidthContext({BuildContext context, TextStyle style}) {
    final Size size = (TextPainter(
            text: TextSpan(text: this, style: style),
            maxLines: 1,
            textScaleFactor: context != null ? MediaQuery.of(context).textScaleFactor : 1.0,
            textDirection: TextDirection.ltr)
          ..layout())
        .size;
    return size.width;
  }
}
