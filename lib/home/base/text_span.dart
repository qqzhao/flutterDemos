import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TestTextSpanPage extends StatefulWidget {
  @override
  _TestTextSpanPageState createState() => _TestTextSpanPageState();
}

class _TestTextSpanPageState extends State<TestTextSpanPage> {
  TapGestureRecognizer _recognizer1;
  DoubleTapGestureRecognizer _recognizer2;
  LongPressGestureRecognizer _recognizer3;
  TapGestureRecognizer _recognizer4;

  @override
  void initState() {
    super.initState();
    _recognizer1 = TapGestureRecognizer()
      ..onTap = () {
        print("tapped");
      };
    _recognizer2 = DoubleTapGestureRecognizer()
      ..onDoubleTap = () {
        print("double tapped");
      };
    _recognizer3 = LongPressGestureRecognizer()
      ..onLongPress = () {
        print("long pressed");
      };
    _recognizer4 = TapGestureRecognizer()
      ..onTap = () {
        print("tapped 44");
      };
  }

  @override
  Widget build(BuildContext context) {
    var underlineStyle = TextStyle(decoration: TextDecoration.underline, color: Colors.black, fontSize: 16);

    return Scaffold(
      appBar: AppBar(title: Text("TextSpan")),
      body: RichText(
        text: TextSpan(
          text: 'This is going to be a text which has ',
          style: underlineStyle.copyWith(decoration: TextDecoration.none),
          children: <TextSpan>[
            TextSpan(text: 'single tap ', style: underlineStyle, recognizer: _recognizer1),
            TextSpan(text: 'along with '),
            TextSpan(text: 'double tap ', style: underlineStyle, recognizer: _recognizer2),
            TextSpan(text: 'and '),
            TextSpan(text: "long press\n", style: underlineStyle, recognizer: _recognizer3),
            TextSpan(text: 'prefix string', style: underlineStyle, recognizer: _recognizer4, children: [
              TextSpan(
                text: 'seperate ',
                style: underlineStyle,
                recognizer: _recognizer4,
              ),
              TextSpan(
                text: 'word ',
                style: underlineStyle,
                recognizer: _recognizer4,
              ),
              TextSpan(
                text: 'test ',
                style: underlineStyle,
                recognizer: _recognizer4,
              ),
              TextSpan(
                text: 'tap',
                style: underlineStyle,
                recognizer: _recognizer4,
              ),
              TextSpan(text: '', style: underlineStyle, recognizer: _recognizer4, children: [
                TextSpan(
                  text: 's',
                  style: underlineStyle,
                  recognizer: _recognizer4,
                ),
                TextSpan(
                  text: 'u',
                  style: underlineStyle,
                  recognizer: _recognizer4,
                ),
                TextSpan(
                  text: 'f',
                  style: underlineStyle,
                  recognizer: _recognizer4,
                ),
                TextSpan(
                  text: 'f',
                  style: underlineStyle,
                  recognizer: _recognizer4,
                ),
                TextSpan(
                  text: 'i',
                  style: underlineStyle,
                  recognizer: _recognizer4,
                ),
                TextSpan(
                  text: "x\n",
                  style: underlineStyle,
                  recognizer: _recognizer4,
                ),
              ]),
              TextSpan(
                  text: '',
                  style: underlineStyle,
                  recognizer: _recognizer4,
                  children: ['in', ' ', 's', 'p', 'r', 'i', 'n', 'g'].map((item) {
                    return TextSpan(
                      text: '$item',
                      style: TextStyle(
                        fontSize: 40.0,
                      ),
                      recognizer: _recognizer4,
                    );
                  }).toList()),
            ]),
          ],
        ),
      ),
    );
  }
}
