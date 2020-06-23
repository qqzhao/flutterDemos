import 'dart:async';

import 'package:flutter/material.dart';

/// 使用 InheritedWidget， 可以查找 _MyBloc
class BlocTestPage2 extends StatefulWidget {
  @override
  _BlocTestPage1State createState() => _BlocTestPage1State();
}

class _BlocTestPage1State extends State<BlocTestPage2> {
  @override
  Widget build(BuildContext context) {
    return _MyBlocWidget(
      bloc: _MyBloc(10),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('bloc test 2'),
          ),
          body: StreamBuilder<_MyBloc>(
            stream: _MyBlocWidget.of(context).stream,
            builder: (context, sp) {
              var bloc = _MyBlocWidget.of(context);
              return Text('${bloc.counter}');
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              var bloc = _MyBlocWidget.of(context);
              bloc.increase();
            },
          ),
        );
      }),
    );
  }
}

/// 全局
class _MyBloc {
  int _counter = 0;
  _MyBloc(int count) : _counter = count;

  StreamController _controller = StreamController<_MyBloc>();

  Stream<_MyBloc> get stream => _controller.stream;

  dispose() {
    _controller.close();
  }

  int get counter => _counter;

  void increase() {
    _counter++;
    _controller.add(this);
  }
}

class _MyBlocWidget extends InheritedWidget {
  final _MyBloc bloc;
  _MyBlocWidget({this.bloc, Key key, Widget child}) : super(key: key, child: child);

  static _MyBloc of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<_MyBlocWidget>().bloc;

  @override
  bool updateShouldNotify(_MyBlocWidget oldWidget) {
    return this.bloc != oldWidget.bloc;
  }
}
