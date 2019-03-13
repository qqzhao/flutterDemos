import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gbk2utf8/gbk2utf8.dart' as gbk2utf8;

// 有问题的
//const String text1 = 'We\'re going to visit Paris.';
//const String text2 = 'We are going to visit Paris.';
//const String text3 = 'We are goingeee to visit Paris.';
//const String text4 = 'this congratulations test.';

// 空格是好的
const String text1 = 'We\'re going to visit Paris.';
const String text2 = 'We are going to visit Paris.';
const String text3 = 'We are goingeee to visit Paris.';
const String text4 = 'this congratulations test.';

class BaseTextWidthPage extends StatefulWidget {
  @override
  _BaseTextWidthPageState createState() => _BaseTextWidthPageState();
}

class _BaseTextWidthPageState extends State<BaseTextWidthPage> {
  void _testGBK() {
    String test1 = 'We\'re going to visit Paris.';
    var test1Buffer = latin1.encode(test1);
    print('test1Buffer = $test1Buffer');
    var test2 = gbk2utf8.gbk.decode(test1Buffer);
    print('test2 = $test2');
    try {
      var test2Buffer = latin1.encode(test2);
      print('test2Buffer = $test2Buffer');
    } catch (e) {
      print('excep = $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    _testGBK();

    var textStyle = new TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      wordSpacing: 0.0,
    );
    var padding = new EdgeInsets.only(right: 0.0);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('test break word'),
      ),
      body: new Center(
        child: new Container(
          padding: padding,
          width: 200.0,
          height: 500.0,
          color: Colors.blue,
          child: new Column(
            children: <Widget>[
              new Text(
                '$text1',
                style: textStyle,
              ),
              new Divider(),
              new Text(
                '$text2',
                style: textStyle,
              ),
              new Divider(),
              new Text(
                '$text3',
                style: textStyle,
              ),
              new Divider(),
              new Text(
                '$text4',
                style: textStyle,
              ),
              new Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
