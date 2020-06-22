import 'dart:async';

import 'package:flutter/material.dart';

import '../../components/loading.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  Timer dismissTimer;

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Center(
        child: new GestureDetector(
          onTap: () {
            print('aaa');
            showLoading(context: context);
            dismissTimer = new Timer(new Duration(seconds: 2), () {
              hideLoading(context: context);
            });
          },
          child: new Text('aaaa'),
        ),
      ),
    );
  }
}
