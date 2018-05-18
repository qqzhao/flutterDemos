import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';



void main() {
  runApp(container);
}


Widget paddingWidget = new Padding(
  padding: const EdgeInsets.all(8.0),
  child: new Text(
    'Looo oo ofsdl jfaklfd jlaks jfasjkfj dlkafasfk fd jsk fdjs akfj fdsa dkfslak sfkdlk sadkfalkf asfasdlfsa ;fkaskldfa;lskfa sfalsfdk aslkfda lsfdkalkfaslkf adfkaslkf ',
    textDirection: TextDirection.ltr,
    maxLines: 100,
    textAlign: TextAlign.left,
    style: new TextStyle(fontSize: 20.0),
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
    child: containerBox,
  ),
);

Widget containerBox = new ConstrainedBox(
//  constraints: const BoxConstraints.expand(),
  child: new Text(
    'Looo oo ofsdl jfaklfd jlaks jfasjkfj dlkafasfk fd jsk fdjs akfj fdsa dkfslak sfkdlk sfd fdjsaj fdjak fdsj adkfalkf asfasdlfsa ;fkaskldfa;lskfa sfalsfdk aslkfda lsfdkalkfaslkf adfkaslkf ',
    textDirection: TextDirection.ltr,
    maxLines: 100,
    textAlign: TextAlign.left,
    style: new TextStyle(fontSize: 20.0),
  ),
  constraints: new BoxConstraints.loose(
      new Size(150.0, 150.0)
  ),
);


/////////////////////////////////////////////////////////////////////////////////////////
Widget text1 = new Text(
  'Looooo2 def cdg  fkfdjsk fdjsakfj fjds fdj djska kafdj asfjalf aslkdfja ldsfjasldfjas lfjdaslfj asljfalfjalfj ajfdskf la',
  textDirection: TextDirection.ltr,
  maxLines: 100,
  textAlign: TextAlign.left,
  style: new TextStyle(fontSize: 16.0),
);

Widget flex = new Flexible(
  flex: 0,
  child: text1,
);

Widget a= new IntrinsicWidth();
Widget b= new Flex(
  children: <Widget>[flex],
  direction: Axis.vertical,
);