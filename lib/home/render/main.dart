import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() async {
  print('render main');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String text = 'render text';

  @override
  void initState() {
    SchedulerBinding.instance.addPersistentFrameCallback((timeStamp) {
      print('addPersistentFrameCallback:$timeStamp');
    });
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      print('addPostFrameCallback:$timeStamp');
    });
    SchedulerBinding.instance.addTimingsCallback((timeStamp) {
      print('timeStamp:$timeStamp');
    });
    Timer.periodic(Duration(seconds: 5), (timer) {
      if (text.length <= 15) {
        setState(() {
          text += '+++';
        });
      } else {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 30.0,
        ),
      ),
    );
  }
}
