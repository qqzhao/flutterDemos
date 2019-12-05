import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tools/src/time.dart';

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

void costLongTimeFunc(String str) {
  TimeDurationTool.start('test1');
  for (int j = 0; j < 5; j++) {
    int b = 0;
    for (int i = 0; i < 1000 * 1000 * 1000 * 5; i++) {
      b = i * i;
    }
    print('current j = $j, ${DateTime.now()}');
  }

  print('222 = ${TimeDurationTool.record('test1')}');
}
