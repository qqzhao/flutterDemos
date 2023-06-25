import 'dart:async';

import 'package:flutter/material.dart';

class Lock {
  Future? _lock;
  Completer? _completer;

  bool get locked => _lock != null;

  void lock() {
    if (!locked) {
      _completer = new Completer();
      _lock = _completer!.future;
    }
  }

  /// 解锁的那一刻开始顺序执行
  void unlock() {
    if (locked) {
      _completer!.complete();
      _lock = null;
    }
  }

  void clear([String msg = "cancelled"]) {
    if (locked) {
      _completer!.completeError(msg);
      _lock = null;
    }
  }

  /// 只有这样才能串行队列顺序执行
  Future enqueue(Future<String> Function() callback) async {
    if (locked) {
      // we use a future as a queue
      Future<String> newLock = _lock!.then((d) => callback());
      _lock = newLock;
      return _lock;
    }
    return null;
  }
}

class LockTestPage extends StatefulWidget {
  @override
  _LockTestPageState createState() => _LockTestPageState();
}

class _LockTestPageState extends State<LockTestPage> {
  Lock lock = Lock();
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: 100.0,
            height: 100.0,
            child: FloatingActionButton(
              child: Text('lock'),
              onPressed: () {
                lock.lock();
              },
            ),
          ),
          Container(
            width: 100.0,
            height: 100.0,
            child: FloatingActionButton(
              child: Text('unlock'),
              onPressed: () {
                lock.unlock();
              },
            ),
          ),
          Container(
            width: 100.0,
            height: 100.0,
            child: FloatingActionButton(
              child: Text('clear'),
              onPressed: () {
                lock.clear();
              },
            ),
          ),
          Container(
            width: 100.0,
            height: 100.0,
            child: FloatingActionButton(
              child: Text('enqueue task'),
              onPressed: () async {
                print('enqueue task');
                var callback = () async {
                  counter++;
                  await Future.delayed(Duration(seconds: 3));
                  var curStr = 'current counter = ${counter}';
                  print(curStr);
                  return curStr;
                };
                if (lock.locked) {
                  var str = await lock.enqueue(() {
                    return callback();
                  });
                  print('locked = $str');
                } else {
                  var str = await callback();
                  print('str2 = $str');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
