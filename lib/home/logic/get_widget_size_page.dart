import 'package:flutter/material.dart';
import 'package:hello/home/combine/widget_size.dart';

class WidgetSizeTestPage extends StatefulWidget {
  @override
  _WidgetSizeTestPageState createState() => _WidgetSizeTestPageState();
}

class _WidgetSizeTestPageState extends State<WidgetSizeTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('test widget size'),
      ),
      body: ListView(
        children: [
          _Cell(
            title: '计算: Container',
            callback: () async {
              Widget widget1 = Container(
                width: 66,
                height: 88,
              );
              print('size = ${await getWidgetSize(widget1)}');
            },
          ),
          _Cell(
            title: '计算: Column-min',
            callback: () async {
              Widget widget1 = Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 100,
                    height: 30,
                    color: Colors.blue,
                  ),
                  Container(
                    height: 20.0,
                    width: 30,
                  ),
                  Text('111'),
                ],
              );
              print('size = ${await getWidgetSize(widget1)}');
            },
          ),
          _Cell(
            title: '计算: Column-max: 得到外层最大尺寸',
            callback: () async {
              Widget widget1 = Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 100,
                    height: 30,
                    color: Colors.blue,
                  ),
                  Container(
                    height: 20.0,
                    width: 30,
                  ),
                  Text('111'),
                ],
              );
              print('size = ${await getWidgetSize(widget1)}');
            },
          ),
          _Cell(
            title: '计算: Stack',
            callback: () async {
              Widget widget1 = Stack(
                children: [
                  Container(
                    width: 100,
                    height: 30,
                    color: Colors.blue,
                  ),
                  Container(
                    height: 200,
                    width: 20,
                  ),
                  Text('111'),
                ],
              );
              print('size = ${await getWidgetSize(widget1)}');
            },
          ),
          _Cell(
            title: '计算: Text',
            callback: () async {
              Widget widget1 = Container(
                width: 100,
                child: Text('fsad dfkjsa lfsdajf asdla sdlfjaslfd aldksfjsalsdfa lsfdka ldsfkjsa sdflkjaf lsdfja sfdalfsdjalf aslfas dfas lfda lsdfas jas'),
              );
              print('size = ${await getWidgetSize(widget1)}');
            },
          ),
        ],
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  final String title;
  final VoidCallback callback;

  _Cell({this.title, this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: callback,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              border: Border(
                  bottom: BorderSide(
                color: Colors.white,
                width: 1,
              )),
            ),
            height: 60,
            width: double.infinity,
            child: Center(child: Text('$title')),
          ),
        ),
      ),
    );
  }
}
