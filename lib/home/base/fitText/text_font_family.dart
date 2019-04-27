import 'package:flutter/material.dart';

/// 问题说明：TextSpan 中fontFamily不生效。下面的版本仍然不生效。
/// Flutter 1.4.12 • channel unknown • unknown source
/// Framework • revision 294d7ea0cf (3 weeks ago) • 2019-04-08 12:37:43 -0700
/// Engine • revision ff1bcdc009
/// Tools • Dart 2.2.1 (build 2.2.1-dev.3.0 None)
class TextFontFamilyPage extends StatefulWidget {
  @override
  _TextFontFamilyPageState createState() => _TextFontFamilyPageState();
}

class _TextFontFamilyPageState extends State<TextFontFamilyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('aaa'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(
              'aaabbccc',
              style: TextStyle(fontSize: 20.0),
            ),
            RichText(
              text: TextSpan(
                text: 'outText: aaabbccc\n',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.red[300],
                ),
                children: [
                  TextSpan(
                    text: 'innerText1: aaabbccc\n',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blue[300],
                    ),
                  ),
                  TextSpan(
                    text: 'innerText2: aaabbccc\n',
                    style: TextStyle(fontSize: 20.0, color: Colors.green[300], fontFamily: 'rokkittFamily'),
                  ),
                  TextSpan(
                    text: 'innerText3：aaabbccc\n',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.purple[300],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
