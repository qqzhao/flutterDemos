import 'package:flutter/material.dart';

class LayoutBuildTestPage extends StatefulWidget {
  @override
  _LayoutBuildTestPageState createState() => _LayoutBuildTestPageState();
}

class _LayoutBuildTestPageState extends State<LayoutBuildTestPage> {
  @override
  // ignore: long-method
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('test layoutBuild'),
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Container(
              height: 100.0,
              color: Colors.red,
              child: new Center(
                child: new Container(
                  height: 50.0,
                  color: Colors.blue,
                  child: new LayoutBuilder(builder: (context, size) {
                    print('size1 = $size');
                    return Text('size1 = $size');
                  }),
                ),
              ),
            ),
            new Divider(
              height: 10.0,
            ),
            new Container(
              height: 100.0,
              color: Colors.red,
              child: new Center(
                child: new Container(
                  height: 50.0,
                  color: Colors.blue,
                  child: new LayoutBuilder(builder: (context, size) {
                    print('size2 = $size');
                    return Container();
                  }),
                ),
              ),
            ),
            new Divider(
              height: 10.0,
            ),
            new Container(
              height: 100.0,
              color: Colors.red,
              child: new Center(
                child: new Container(
                  height: 50.0,
                  color: Colors.blue,
                  child: new LayoutBuilder(builder: (context, size) {
                    print('size3 = $size');
                    return SizedBox(
                      width: 30.0,
                      child: new LayoutBuilder(builder: (context, size2) {
                        print('size31 = $size2');
                        return new Text(
                          'size31 = $size',
                        );
                      }),
                    );
                  }),
                ),
              ),
            ),
            new Divider(
              height: 10.0,
            ),
            new Container(
              height: 100.0,
              color: Colors.red,
              child: new Center(
                child: new Container(
                  height: 200.0, // 外层是100，所以这里设置200不起作用。
                  color: Colors.blue,
                  child: new Column(
                    children: <Widget>[
                      new SizedBox(
                        height: 50.0,
                        child: new LayoutBuilder(builder: (context, size) {
                          print('size4 = $size');
                          return Container(
                            color: Colors.purple,
                          );
                        }),
                      ),
                      new Flexible(
                        flex: 2,
                        child: LayoutBuilder(builder: (_, size) {
                          print('size42 = $size');
                          return Container(
                            color: Colors.green,
                          );
                        }),
                      ),
                      new Flexible(
                        flex: 3,
                        child: LayoutBuilder(builder: (_, size) {
                          print('size43 = $size');
                          return Container(
                            color: Colors.amber,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
