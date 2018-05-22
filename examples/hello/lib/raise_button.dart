import 'package:flutter/material.dart';

void main() {
  runApp(home5);
}

Widget hello1 = new Center(
  child: new Text('hello1', textDirection: TextDirection.ltr),
);
Widget hello2 = new Text('hello2', textDirection: TextDirection.ltr);
//Widget hello3 = new Text('hello3', textDirection: TextDirection.ltr);

Widget container1 = new Container(
  child: hello1,
  width: 100.0,
  height: 200.0,
  color: Colors.red,
);
Widget container2 = new Container(
  child: hello2,
  width: 200.0,
  height: 100.0,
  color: Colors.blue,
);

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////

Widget home = new RaisedButton(
  highlightColor: Colors.red,
  highlightElevation: 0.2,
  splashColor: Color(0x00000000),
  onPressed: () {
    print('test2222');
  },
  onHighlightChanged: (isT) {
    print('isT = $isT');
  },
  child: new Text(
    'test',
    textDirection: TextDirection.ltr,
  ),
);

Widget home5 = new Center(
  child: Container(
    child: home,
    width: 120.0,
    height: 120.0,
    color: Colors.yellow,
  ),
);
