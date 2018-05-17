

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';



void main() {
  runApp(container);
}


Widget paddingWidget = new Padding(
  padding: const EdgeInsets.all(8.0),
  child: new Text(
    'Loooooooooo abc def cdg  fkfdjsk fdjsakfj ',
    textDirection: TextDirection.ltr,
    maxLines: 100,
    textAlign: TextAlign.left,
//      style: new TextStyle(fontSize: 20.0),
  ),
);

Widget home = new FittedBox(
  fit: BoxFit.contain,
  child: paddingWidget
);


Widget container = new Center(
  child: new Container(
    width: 200.0,
    height: 200.0,
    color: Colors.red,
    child: home,
  ),
);


//
/////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
Widget text1 = new Text(
  'Loooooooooo abc def cdg  fkfdjsk fdjsakfj ',
  textDirection: TextDirection.ltr,
  maxLines: 100,
  textAlign: TextAlign.left,
  //      style: new TextStyle(fontSize: 20.0),
);

Widget flex = new Flexible(
  child: text1,
);