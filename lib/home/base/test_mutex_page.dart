import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mutex/mutex.dart';

class MutexTestPage extends StatefulWidget {
  @override
  _MutexTestPageState createState() => _MutexTestPageState();
}

var _writeFileMutex = new Mutex();

class _MutexTestPageState extends State<MutexTestPage> {
  Timer? _timer;
  int _counter = 0;

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _timer = new Timer.periodic(new Duration(milliseconds: 300), (_) {
      _testMutex();
    });

    // 这种dispose 之后不会释放。所以，快速点击返回之后会报错。
    Timer(new Duration(seconds: 5), () {
      print('time cancel xxx');
      _timer!.cancel();
      _timer = null;
    });
  }

  void _testMutex() async {
    print('_counter = $_counter'); // 输出16次
    _counter++;
    await _writeFileMutex.acquire();
    try {
      await Future.delayed(new Duration(seconds: 2), () {
        print('future delayed 2 seconds');
      });
      print('total _counter = $_counter'); // 也会输出16次， 后面的都是'total _counter = 16'
    } finally {
      _writeFileMutex.release();
    }
  }

  @override
  Widget build(BuildContext context) {
//    _testMutex();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('test mutex'),
      ),
    );
  }
}
