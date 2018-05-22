import 'package:flutter/material.dart';

void main() {
  runApp(home5);
}

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////

FloatingActionButton floatingButton = new FloatingActionButton(
  child: new Text('test'),
  backgroundColor: Colors.purple,
  foregroundColor: Colors.red,
  tooltip: 'tips.',
);

Widget home = new Center(
  child: new Container(
      width: 120.0,
      height: 120.0,
      color: Colors.blue,
      child: new Center(
        child: new SizedBox(
          width: 100.0,
          height: 100.0,
          child: new Overlay(
            initialEntries: [
              new OverlayEntry(builder: (context) {
                return floatingButton;
              }, opaque: false),
            ],
          ),
        ),
      )),
);

Widget home5 = new Directionality(
  textDirection: TextDirection.ltr,
  child: new Center(
    child: Container(
      child: home,
      width: 200.0,
      height: 200.0,
      color: Colors.yellow,
    ),
  ),
);
