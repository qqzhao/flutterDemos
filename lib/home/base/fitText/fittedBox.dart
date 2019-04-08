import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FittedBoxPage extends StatefulWidget {
  @override
  _FittedBoxPageState createState() => _FittedBoxPageState();
}

class _FittedBoxPageState extends State<FittedBoxPage> {
  double width = 200.0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('test'),
        ),
        body: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new GestureDetector(
                  onTap: () {
                    setState(() {
                      if (width < MediaQuery.of(context).size.width) {
                        width += 20;
                      } else {
                        width = 100.0;
                      }
                    });
                  },
                  child: new Container(
//                alignment: Alignment.center,
                    margin: new EdgeInsets.symmetric(vertical: 30.0),
                    color: Colors.blue,
                    width: 200.0,
                    height: 60.0,
                    child: Center(
                      child: new Text('change width'),
                    ),
                  )),
              new Center(
                child: new Container(
                  width: width,
                  height: 200.0,
                  color: Colors.red,
                  child: home,
                ),
              ),
              new Center(
                child: new Container(
                  width: width,
                  height: 200.0,
                  color: Colors.red,
                  child: home3,
                ),
              ),
            ],
          ),
        ));
  }
}

Widget paddingWidget = new Padding(
  padding: const EdgeInsets.all(8.0),
  child: new Text(
    'Looo oo ofsdl',
    textDirection: TextDirection.ltr,
    maxLines: 100,
    textAlign: TextAlign.left,
    style: new TextStyle(fontSize: 40.0), // 这个地方会指出最大的字体
  ),
);

Widget home = new FittedBox(fit: BoxFit.fill, child: paddingWidget);
//Widget home2 = new FittedBox(fit: BoxFit.fitWidth, child: paddingWidget);
Widget home3 = new FittedBox(fit: BoxFit.scaleDown, child: paddingWidget);

/// https://github.com/flutter/flutter/issues/18431
/// 讨论自动匹配的方案和实现.
