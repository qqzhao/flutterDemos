import 'package:flutter/material.dart';

class TestListView1 extends StatefulWidget {
  @override
  _TestListView1State createState() => _TestListView1State();
}

class _TestListView1State extends State<TestListView1> {
  ScrollPhysics _physics1;
  ScrollController _controller1;
  ScrollController _controller2;
  double _lastOffset = 0; // congroller2 偏移值

  @override
  void initState() {
    _controller1 = ScrollController();
    _controller2 = ScrollController();

    _controller1.addListener(() {
      if (_controller1.position.pixels > _controller1.position.maxScrollExtent) {
        _controller1.jumpTo(_controller1.position.maxScrollExtent);
      }
    });

    _controller2.addListener(() {
      if (_controller2.position.pixels < _controller2.position.minScrollExtent) {
        var diff = _controller2.position.pixels - _controller2.position.minScrollExtent;
        if (_lastOffset == 0) {
          _lastOffset = _controller2.position.pixels;
        } else {
          diff = _controller2.position.pixels - _lastOffset;
          _lastOffset = _controller2.position.pixels;
        }

        print('diff = $diff');
        if (diff < 0) {
          _controller1.jumpTo(diff * 2 + _controller1.position.pixels);
        }
      } else {
        _lastOffset = 0;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('test list view'),
      ),
      body: new NotificationListener(
          onNotification: (p) {
            if (p is ScrollUpdateNotification) {
//              print('p.offset=${p.metrics.pixels}, max=${p.metrics.maxScrollExtent}');
//              if (p.metrics.pixels > p.metrics.maxScrollExtent) {
//                _controller1.jumpTo(p.metrics.maxScrollExtent);
//              }
//
//              print('p.metrics.ll = ${p.metrics}');

//              // 这种方法不行，因为固定后就无法再滑动
//              if (p.metrics.pixels > p.metrics.maxScrollExtent) {
//                setState(() {
//                  _physics1 = NeverScrollableScrollPhysics();
//                });
//              } else {
//                setState(() {
//                  _physics1 = AlwaysScrollableScrollPhysics();
//                });
//              }
            }
            return true;
          },
          child: new SingleChildScrollView(
            controller: _controller1,
            physics: _physics1,
            child: new Column(
              children: <Widget>[
                new Container(
                  color: Colors.purple,
                  height: 300.0,
                ),
                new Container(
                  color: Colors.blue,
                  height: 400.0,
                ),
                new Container(
                  color: Colors.green,
                  height: 600.0,
                  child: new ListView.builder(
                    controller: _controller2,
                    itemBuilder: (context, index) {
                      return new ConstrainedBox(
                        constraints: BoxConstraints(minHeight: 60.0),
                        child: new Container(
                          margin: new EdgeInsets.only(bottom: 2.0),
                          color: Colors.white,
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text('index = $index'),
//                              new Divider(
//                                height: 2.0,
//                                color: Colors.red,
//                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: 30,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
