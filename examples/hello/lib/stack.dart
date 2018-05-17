
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';



void main() {
  runApp(home5);
}

Widget hello1 = new Center(child: new Text('hello1', textDirection: TextDirection.ltr),);
Widget hello2 = new Text('hello2', textDirection: TextDirection.ltr);
//Widget hello3 = new Text('hello3', textDirection: TextDirection.ltr);

Widget container1 = new Container(child: hello1,width: 100.0, height: 200.0, color: Colors.red,);
Widget container2 = new Container(child: hello2,width: 200.0, height: 100.0, color: Colors.blue,);


Widget home = new Stack(
  alignment: AlignmentDirectional.bottomStart,
  textDirection: TextDirection.rtl,
  overflow: Overflow.visible,
  fit: StackFit.loose,
  children: <Widget>[container2, container1],
);

//Widget sizeBox = SizedBox(child: home, width: 150.0, height: 150.0,);

//Widget home4 = new Container(child: home, color: Colors.green, width: 150.0, height: 150.0,);

Widget home5 = new Center(
  child: Container(
    child: home,
    width: 120.0,
    height: 120.0,
    color: Colors.yellow,
  ),
);


/**
 * StackFit：
 * loose: 松散的，也就是会根据alignment的位置进行对齐； Width，height依然会起作用，如果无法覆盖前者的话。
 * expand： 对每一个进行扩充。也就是最后的元素会占满整个控件空间。元素的宽高已经不起作用了。non-positioned元素的含义？
 * passthrough： 根据super的设置进行调整。
 *
*/