import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TickerTestPage extends StatefulWidget {
  @override
  _TickerTestPageState createState() => _TickerTestPageState();
}

class _TickerTestPageState extends State<TickerTestPage> {
  late Ticker _ticker;
  var _count = 0;

  @override
  void initState() {
    _ticker = new Ticker((Duration elapsed) {
      print('elapsed = $elapsed');
      _count++;
    });

    TickerFuture _resultFuture = _ticker.start();
    _resultFuture.then((value) {
      print('value = XXX'); // ticker 事件的正常结束
    }).catchError((error) {
      print('onError = $error'); // 这个没有调用
    });

    // 10s 的时候设置静默调用（不执行回调）
    new Timer(new Duration(seconds: 5), () {
      _ticker.muted = true;
      print('ticker muted=true; count = $_count');
    });

    // 20s 的时候停止
    new Timer(new Duration(seconds: 10), () {
      _ticker.stop(canceled: false); // false 表示正常结束, true 会调用异常
      print('ticker stop; count = $_count');
    });

    new Timer(new Duration(seconds: 15), () {
      print('dispose ticker');
      _ticker.dispose();
    });
    super.initState();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('test ticker'),
      ),
    );
  }
}
