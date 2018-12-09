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

class FutureTestPage extends StatefulWidget {
  @override
  _FutureTestPageState createState() => _FutureTestPageState();
}

class _FutureTestPageState extends State<FutureTestPage> {
  @override
  Widget build(BuildContext context) {
    _testFuture();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('future test'),
      ),
    );
  }
}
