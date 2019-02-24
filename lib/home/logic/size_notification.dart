import 'dart:async';

import 'package:flutter/material.dart';

class SizeChangedLayoutNotification extends StatefulWidget {
  @override
  _SizeChangedLayoutNotificationState createState() => _SizeChangedLayoutNotificationState();
}

class _SizeChangedLayoutNotificationState extends State<SizeChangedLayoutNotification> {
  num height = 50.0;

  bool _handleNotification(note) {
    print('note = ${note}');
    return true;
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        height = height + 20;
      });
      if (height > 130) {
        timer.cancel();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      child: Scaffold(
        appBar: AppBar(
          title: Text('test sizeChanged notification'),
        ),
        body: new Center(
          child: new Container(
            width: 100.0,
            height: height,
            color: Colors.red,
            child: LayoutBuilder(builder: (context, constraints) {
              print('con=== ${constraints.maxWidth}:${constraints.maxHeight}');
              return Center(
                child: Text('aa'),
              );
            }),
          ),
        ),
      ),
      onNotification: _handleNotification,
    );
  }
}
