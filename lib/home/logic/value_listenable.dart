import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ValueListenablePage extends StatefulWidget {
  @override
  _ValueListenablePageState createState() => _ValueListenablePageState();
}

class _ValueListenablePageState extends State<ValueListenablePage> {
  final ValueNotifier<String> _valueNotifier = ValueNotifier('aaa');
  VoidCallback _listener;
  Timer timer;

  @override
  void initState() {
    _listener = () {
      print('xxx:${_valueNotifier.value}');
    };
    _valueNotifier.addListener(_listener);

    timer = Timer.periodic(Duration(seconds: 3), (_) {
      _valueNotifier.value = '${_valueNotifier.value}++';
    });

    super.initState();
  }

  @override
  void dispose() {
    print('ValueListenablePage dispost ');
    _valueNotifier.removeListener(_listener);
//    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('text value listenable'),
      ),
      body: FlatButton(
        onPressed: () {
          print('onPressed');
          _valueNotifier.value = '${_valueNotifier.value}++';
//          _valueNotifier.notifyListeners();
        },
        child: Container(
          width: 100.0,
          height: 100.0,
          color: Colors.blue,
          child: Text('tap me'),
        ),
      ),
    );
  }
}
