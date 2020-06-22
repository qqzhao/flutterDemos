import 'package:flutter/material.dart';

class ExceptionTestPage extends StatefulWidget {
  @override
  _ExceptionTestPageState createState() => _ExceptionTestPageState();
}

class _ExceptionTestPageState extends State<ExceptionTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          FlatButton(
            onPressed: () {
              test1();
            },
            child: Container(
              width: 100.0,
              height: 100.0,
              color: Colors.blue,
              child: Text('tap me'),
            ),
          ),
          FlatButton(
            onPressed: () {
              test2();
            },
            child: Container(
              width: 100.0,
              height: 100.0,
              color: Colors.green,
              child: Text('tap me'),
            ),
          ),
          FlatButton(
            onPressed: () {
              test3();
            },
            child: Container(
              width: 100.0,
              height: 100.0,
              color: Colors.red,
              child: Text('tap me'),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text('test exception page '),
      ),
    );
  }
}

void test1() {
  print('test1');
  try {
    exceptionHandle1();
  } catch (e) {
    print('test1 e = $e');
  }
}

void test2() {
  print('test2');
  try {
    exceptionHandle2();
  } catch (e) {
    print('test2 e = $e');
  }
}

void test3() {
  print('test3');
  try {
    exceptionHandle3();
  } catch (e) {
    print('test3 e = $e');
  }
}

void exceptionHandle1() {
  try {
    exceptionCode();
  } catch (e) {
    print('exceptionHandle1 e = $e');
  }
}

/// 内部捕获后，不会抛到外部
/// Error 也是一种异常
void exceptionHandle2() {
  try {
    exceptionCode();
  } on Error catch (e) {
    print('exceptionHandle2 e = $e');
  }
}

/// throw 语句之后，不会再执行。
void exceptionHandle3() {
  try {
    exceptionCode();
  } on Error catch (e) {
    print('exceptionHandle3 e = $e');
    throw new Exception('error message');
  }
  print('exceptionHandle3 end print');
}

void exceptionCode() {
  var a = [];
  print(a[0]);
}
