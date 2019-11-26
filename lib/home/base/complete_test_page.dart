import 'dart:async';

import 'package:flutter/material.dart';

class CompleteTestPage extends StatefulWidget {
  @override
  _CompleteTestPageState createState() => _CompleteTestPageState();
}

class _CompleteTestPageState extends State<CompleteTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test complete'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: 100.0,
            height: 100.0,
            color: Colors.blue,
            child: FlatButton(
              onPressed: () async {
                print('ontap');
                var test = _testComplete();
                var str1 = await test.getString();
                print('str1 = $str1');
                var test2 = _testComplete2();
                var str2 = await test2.getString();
                print('str2 = $str2');
              },
              child: Text('tap me'),
            ),
          ),
          Container(
            width: 100.0,
            height: 100.0,
            color: Colors.blue,
            child: FlatButton(
              onPressed: () async {
                print('ontap2');
                var test = _testComplete3();
                var stream = test.getStringStream();
                stream.listen((data) {
                  print('data = $data');
                });
              },
              child: Text('tap me2'),
            ),
          ),
          Container(
            width: 100.0,
            height: 100.0,
            color: Colors.blue,
            child: FlatButton(
              onPressed: () async {
                print('ontap3');
                var test = _testComplete4();
                var str = await test.getString();
                print('str = $str');
              },
              child: Text('tap me3'),
            ),
          ),
        ],
      ),
    );
  }
}

/// 用_completer.future 暂时替代结果，等到有结果的时候再进行返回。
class _testComplete {
  final Completer<String> _completer = Completer<String>();

  Future<String> getString() async {
    Timer(Duration(seconds: 2), () {
      print('time is out');
      _completer.complete('this is string1');
    });
    return _completer.future;
  }
}

/// 这种情况下会报超时异常：TimeoutException after 0:00:01.000000: Future not completed;
class _testComplete2 {
  final Completer<String> _completer = Completer<String>();

  Future<String> getString() async {
    Timer(Duration(seconds: 3), () {
      print('time is out');
      throw Exception('exception1');
//      await Future.delayed(Duration(seconds: 3));
      _completer.complete('this is string1');
    });
    return _completer.future.timeout(Duration(seconds: 1));
  }
}

/// 返回作为stream的情况
class _testComplete3 {
  final Completer<String> _completer = Completer<String>();

  Stream<String> getStringStream() {
    Timer(Duration(seconds: 3), () {
      print('time is out');
      _completer.complete('this is string1');
    });
    return _completer.future.asStream();
  }
}

/// 返回超时，取消的情况
class _testComplete4 {
  final Completer<String> _completer = Completer<String>();

  Future<String> getString() async {
    var timer = Timer(Duration(seconds: 3), () {
      print('time is out');
      throw Exception('exception1');
//      await Future.delayed(Duration(seconds: 3));
      _completer.complete('this is string1');
    });
    return _completer.future.timeout(Duration(seconds: 1), onTimeout: () {
      timer.cancel();
      return 'timeout happen.';
    });
  }
}
