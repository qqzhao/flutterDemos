// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(home5);
// }
//
// ///////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////
//
// FlatButton flatButton = new FlatButton(
//   child: new Text(
//     'hello',
//     textDirection: TextDirection.ltr,
//   ),
//   onPressed: () {
//     print('flat Button clicked');
//   },
//   onHighlightChanged: (isHl) {
//     print("is HL = $isHl");
//   },
// );
//
// FlatButton flatButton2 = new FlatButton.icon(
//     onPressed: () {
//       print('test');
//     },
//     icon: const Icon(
//       Icons.add_circle_outline,
//       size: 10.0,
//     ),
//     label: new Text(
//       'FLAT BU',
//       textDirection: TextDirection.ltr,
//     ),
//     splashColor: Colors.red,
//     colorBrightness: Brightness.light,
//     shape: const CircleBorder(
//       side: BorderSide(
//         color: Colors.white24,
//         width: 4.0,
//       ),
//     ));
//
// Widget home = new Center(
//   child: new Container(
//       width: 120.0,
//       height: 120.0,
//       color: Colors.blue,
//       child: new Center(
//         child: new SizedBox(
//           width: 120.0,
//           height: 100.0,
//           child: flatButton2,
//         ),
//       )),
// );
//
// Widget home5 = new Directionality(
//     textDirection: TextDirection.ltr,
//     child: new Center(
//       child: Container(
//         child: home,
//         width: 200.0,
//         height: 200.0,
//         color: Colors.yellow,
//       ),
//     ));
//
// /**
//  * FlatButton: 平坦的button
//  * RaisedButton: 凸起的button。和FlatButton的区别主要是有没有凸起，也就是有没有evaluation（海拔）相关的属性。其他的属性都一样。包括.icon方法。
//  */
