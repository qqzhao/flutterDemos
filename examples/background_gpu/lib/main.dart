import 'dart:async';

import 'package:flutter/material.dart';

const int delayInitializeTime = 1000;

void main() {
  runZoned<Future<void>>(
    () async {
      await Future.delayed(Duration(seconds: 2));
      print('Please click and enter background:');
      await Future.delayed(Duration(seconds: 5));
      print('After clicking');

      Widget child2 = Container(
        height: 52.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/slide_wave_login_background.png'),
            fit: BoxFit.cover,
          ),
        ),
      );

//      child2 = Container();

//      child2 = Container(
//        height: 52.0,
//        width: 100.0,
//        child: Image.asset('assets/slide_wave_login_background.png'),
//      );

//      child2 = Center(
//        child: Container(
//          width: 52.0,
//          height: 100.0,
//          color: Colors.red,
//          child: CircularProgressIndicator(),
//        ),
//      );

      var child = MaterialApp(
        title: 'Title2',
        home: Scaffold(
          appBar: AppBar(
            title: Text('113'),
          ),
          body: child2,
        ),
      );

      runApp(child);
    },
    onError: (error, stackTrace) {
      print('dart_error: error: $error, stack: $stackTrace');
    },
  );

  FlutterError.onError = (FlutterErrorDetails details) {
    bool isDebug = false;
    assert(() {
      isDebug = true;
      return true;
    }());
    if (isDebug) {
      // print
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone to report
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };
}
