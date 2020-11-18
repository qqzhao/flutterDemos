import 'dart:async';

import 'package:flutter/material.dart';

/// 全局存储 myBloc
class BlocTestPage1 extends StatefulWidget {
  @override
  _BlocTestPage1State createState() => _BlocTestPage1State();
}

class _BlocTestPage1State extends State<BlocTestPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('bloc test 1'),
      ),
      body: StreamBuilder<_MyBloc>(
          stream: myBloc.stream,
          builder: (context, snapshot) {
            return Text('${snapshot.data.counter}');
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          myBloc.increase();
        },
      ),
    );
  }
}

_MyBloc myBloc = _MyBloc();

/// 全局
class _MyBloc {
  int _counter = 0;

  StreamController _controller = StreamController<_MyBloc>();

  Stream<_MyBloc> get stream => _controller.stream as Stream<_MyBloc>;

  dispose() {
    _controller.close();
  }

  int get counter => _counter;

  void increase() {
    _counter++;
    _controller.add(this);
  }
}
