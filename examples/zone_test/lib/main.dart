import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zone_test/invocation_call.dart';
import 'package:zone_test/test_try.dart';
import 'package:zone_test/zone_handle_error.dart';
import 'package:zone_test/zone_return.dart';
import 'package:zone_test/zone_run.dart';

void main() {
//  runZoned(() => runApp(MyApp()), onError: (Object obj, StackTrace stack) {
//    print('global exception: obj = $obj;\nstack = $stack');
//  });

  testRun();
//  testHandleError();
//  testHandleError2();
//  testTry();
//  testRunReturn();
//  testInvocation();
}

void testPrint(String message) async {
  print('in testPrint $message, ${Zone.current}');
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
//    Future.delayed(new Duration(seconds: 5), () {
//      // 会在全局抛出，没有被其他捕获
//      _throwException();
//    });

//    // The following _Exception was thrown attaching to the render tree:
//    // 不会全局抛出
//    _throwException();

    print('Zone: ${Zone.current}, ${Zone.root}');
    compute(testPrint, 'message');
  }

  static void throwException() {
    List list = [1, 2, 3];
//    print('list4 = ${list[4]}');

    throw new Exception('exception1');
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('rone_test'),
          ),
        ));
  }
}
