import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// FittedBox 更多的是指用矩形框，而不是文字渲染。
/// Text 的属性 maxLines 在这里不起不用。还是只有一行。
/// style 中 fontSize会限定最大字体。
class FittedBoxPage extends StatefulWidget {
  @override
  _FittedBoxPageState createState() => _FittedBoxPageState();
}

class _FittedBoxPageState extends State<FittedBoxPage> {
  double width = 200.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('test'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    setState(() {
                      if (width < MediaQuery.of(context).size.width) {
                        width += 20;
                      } else {
                        width = 100.0;
                      }
                    });
                  },
                  child: Container(
//                alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 30.0),
                    color: Colors.blue,
                    width: 200.0,
                    height: 60.0,
                    child: Center(
                      child: Text('change width'),
                    ),
                  )),
              Center(
                child: Container(
                  width: width,
                  height: 200.0,
                  color: Colors.red,
                  child: home,
                ),
              ),
              Center(
                child: Container(
                  width: width,
                  height: 200.0,
                  color: Colors.yellow[200],
                  child: home3,
                ),
              ),
            ],
          ),
        ));
  }
}

Widget paddingWidget = Container(
  padding: const EdgeInsets.all(8.0),
  color: Colors.purple,
  child: LayoutBuilder(builder: (context, constraints) {
    print('constraints  = ${constraints.maxWidth}-${constraints.maxHeight}');
    return Text(
      'Looo oo ofsdl',
      textDirection: TextDirection.ltr,
      maxLines: 100,
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: 40.0), // 这个地方会指出最大的字体
    );
  }),
);

Widget home = FittedBox(fit: BoxFit.fill, child: paddingWidget);
//Widget home2 = FittedBox(fit: BoxFit.fitWidth, child: paddingWidget);
Widget home3 = FittedBox(fit: BoxFit.scaleDown, child: paddingWidget);

/// https://github.com/flutter/flutter/issues/18431
/// 讨论自动匹配的方案和实现.
