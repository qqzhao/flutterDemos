import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TestTextSpanPage extends StatefulWidget {
  @override
  _TestTextSpanPageState createState() => _TestTextSpanPageState();
}

class _TestTextSpanPageState extends State<TestTextSpanPage> {
  TapGestureRecognizer _recognizer1;
  TapGestureRecognizer _recognizer2;
  TapGestureRecognizer _recognizer3;
  TapGestureRecognizer _recognizer4;

  @override
  void initState() {
    super.initState();
    _recognizer1 = TapGestureRecognizer()
      ..onTap = () {
        print("tapped 111: Grain");
      };
    _recognizer2 = TapGestureRecognizer()
      ..onTap = () {
        print("tapped 222: for");
      };
    _recognizer3 = TapGestureRecognizer()
      ..onTap = () {
        print("tapped 333: the");
      };
    _recognizer4 = TapGestureRecognizer()
      ..onTap = () {
        print("tapped 444: chickens");
      };
  }

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(color: Colors.black, fontSize: 24.0);

    return Scaffold(
        appBar: AppBar(title: Text("TextSpan")),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        style: style.copyWith(color: Colors.red),
                        recognizer: _recognizer1,
                        children: [
                          TextSpan(
                            text: 'Gr',
                            style: style.copyWith(color: Colors.green),
                            recognizer: _recognizer1,
                          ),
                          TextSpan(
                            text: 'ai',
                            style: style.copyWith(color: Colors.red),
                            recognizer: _recognizer1,
                          ),
                          TextSpan(
                            text: 'n',
                            style: style.copyWith(color: Colors.green),
                            recognizer: _recognizer1,
                          ),
                        ],
                      ),
                      TextSpan(text: ' '),
                      TextSpan(
                        style: style.copyWith(color: Colors.red),
                        recognizer: _recognizer2,
                        children: [
                          TextSpan(
                            text: 'f',
                            style: style.copyWith(color: Colors.green),
                            recognizer: _recognizer2,
                          ),
                          TextSpan(
                            text: 'o',
                            style: style.copyWith(color: Colors.red),
                            recognizer: _recognizer2,
                          ),
                          TextSpan(
                            text: 'r',
                            style: style.copyWith(color: Colors.green),
                            recognizer: _recognizer2,
                          ),
                        ],
                      ),
                      TextSpan(text: ' '),
                      TextSpan(
                        text: "the",
                        style: style.copyWith(color: Colors.green),
                        recognizer: _recognizer3,
                      ),
                      TextSpan(text: ' '),
                      TextSpan(
                        text: "chickens",
                        style: style.copyWith(color: Colors.green),
                        recognizer: _recognizer4,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        style: style.copyWith(color: Colors.red),
                        recognizer: _recognizer1,
                        children: [
                          TextSpan(
                            text: 'Gr',
                            style: style.copyWith(color: Colors.green),
                            recognizer: _recognizer1,
                          ),
                          TextSpan(
                            text: 'ai',
                            style: style.copyWith(color: Colors.red),
                            recognizer: _recognizer1,
                          ),
                          TextSpan(
                            text: 'n',
                            style: style.copyWith(color: Colors.green),
                            recognizer: _recognizer1,
                          ),
                        ],
                      ),
                      TextSpan(text: ' '),
                      TextSpan(
                        style: style.copyWith(color: Colors.red),
                        recognizer: _recognizer2,
                        children: [
                          TextSpan(
                            text: ' f',
                            style: style.copyWith(color: Colors.green),
                            recognizer: _recognizer2,
                          ),
                          TextSpan(
                            text: 'o',
                            style: style.copyWith(color: Colors.red),
                            recognizer: _recognizer2,
                          ),
                          TextSpan(
                            text: 'r',
                            style: style.copyWith(color: Colors.green),
                            recognizer: _recognizer2,
                          ),
                        ],
                      ),
                      TextSpan(text: ' '),
                      TextSpan(
                        text: "the",
                        style: style.copyWith(color: Colors.green),
                        recognizer: _recognizer3,
                      ),
                      TextSpan(text: ' '),
                      TextSpan(
                        text: "chickens",
                        style: style.copyWith(color: Colors.green),
                        recognizer: _recognizer4,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
