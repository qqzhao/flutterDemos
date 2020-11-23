import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

class TestStuckUIPage extends StatefulWidget {
  @override
  _TestStuckUIPageState createState() => _TestStuckUIPageState();
}

class _TestStuckUIPageState extends State<TestStuckUIPage> {
  Timer _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      print('in timer ${DateTime.now()}');
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test stuck ui'),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            onPressed: () {
              print('in test1');
              Timer(Duration(seconds: 0), () {
                costLongTimeFunc(null);
              });
              print('in test1 end');
            },
            child: Text('ontap1'),
          ),
          FlatButton(
            onPressed: () {
              print('in test2');
              compute(costLongTimeFunc, null);
            },
            child: Text('ontap2'),
          ),
          FlatButton(
            onPressed: () {
              print('in test3');
            },
            child: Text('ontap3'),
          ),
        ],
      ),
    );
  }
}

/// 点击 tap1 效果比较明显，可以查找到 `costLongTimeFunc`。
void costLongTimeFunc(String str) {
  Timeline.startSync('costLongTimeFunc');
  TimeDurationTool.start('test1');

//  Timeline.timeSync('costLongTimeFunc-1', () {
//    for (int j = 0; j < 5; j++) {
//      int b = 0;
//      for (int i = 0; i < 1000 * 1000 * 1000 * 5; i++) {
//        b = i * i;
//      }
//      print('current2 j = $j, ${DateTime.now()}');
//    }
//  });

  for (int j = 0; j < 5; j++) {
    int b = 0;
    for (int i = 0; i < 1000 * 1000 * 1000 * 5; i++) {
      b = i * i;
    }
    print(
      'current j = $j, ${DateTime.now()}, b = $b',
    );
  }

  print('222 = ${TimeDurationTool.record('test1')}');

  Timeline.finishSync();
}
