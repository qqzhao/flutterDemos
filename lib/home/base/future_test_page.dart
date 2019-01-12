import 'package:flutter/material.dart';

Future<int> getValue() async {
  print('in getValue');
  return 1;
}

Future<int> getValue2() async {
  print('in getValue2');
  throw new Exception('happen error');
}

void handleValue(value) {
  print('handle value; value = $value');
}

void _testFuture() {
  Future<int> future = getValue();
  future.then((value) {
    handleValue(value);
  }).catchError((error) {
    print('handle error: $error');
  });

  // onError 和 catchError的差别，catchError 除了可以捕获getValue2的异常，还可以捕获handleValue的异常
  // onError 捕获以后，catchError就不会再捕获了。
  // 如果都不捕获，上报到app的异常处理。
  Future<int> future2 = getValue2();
  future2.then((value) {
    handleValue(value);
  }, onError: (error) {
    print('onError = $error');
  }).catchError((error) {
    print('handle error: $error');
  });

  future2.then((value) {
    handleValue(value);
  });
}

//flutter: delay 222
//flutter: delay 111
// 里面也会持续等待结束。

void _testFutureDelay() async {
  await new Future.delayed(new Duration(seconds: 2), () async {
    await new Future.delayed(new Duration(seconds: 5));
    print('delay 222');
  });
  print('delay 111');
}

// 跟上面一样结果
void _testFutureMicroTask() async {
  await new Future.microtask(() async {
    await new Future.delayed(new Duration(seconds: 5));
    print('delay 222');
  });
  print('delay 111');
}

class FutureTestPage extends StatefulWidget {
  @override
  _FutureTestPageState createState() => _FutureTestPageState();
}

class _FutureTestPageState extends State<FutureTestPage> {
  @override
  Widget build(BuildContext context) {
//    _testFuture();
//    _testFutureDelay();
    _testFutureMicroTask();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('future test'),
      ),
    );
  }
}
