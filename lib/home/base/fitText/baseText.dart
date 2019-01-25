import 'package:flutter/material.dart';

const String text1 = 'We\'re going to visit Paris.';
const String text2 = 'We are going to visit Paris.';
const String text3 = 'We are goingeee to visit Paris.';
const String text4 = 'this congratulations test.';

class BaseTextWidthPage extends StatefulWidget {
  @override
  _BaseTextWidthPageState createState() => _BaseTextWidthPageState();
}

class _BaseTextWidthPageState extends State<BaseTextWidthPage> {
  @override
  Widget build(BuildContext context) {
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
