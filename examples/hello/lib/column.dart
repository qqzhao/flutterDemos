
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';



Widget hello1 = new Center(child: new Text('hello1', textDirection: TextDirection.ltr),);
Widget hello2 = new Text('hello2', textDirection: TextDirection.ltr);
//Widget hello3 = new Text('hello3', textDirection: TextDirection.ltr);

Widget container1 = new Container(child: hello1,width: 100.0, height: 200.0, color: Colors.red,);
Widget container2 = new Container(child: hello2,width: 200.0, height: 100.0, color: Colors.blue,);


void main() {
  runApp(home);
}

Widget home = new Column(
  textDirection: TextDirection.ltr,
  children: <Widget>[container1, container2, hello1],
);