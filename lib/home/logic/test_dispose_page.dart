import 'dart:async';

import 'package:flutter/material.dart';

class TestDisposePage extends StatefulWidget {
  @override
  _TestDisposePageState createState() => _TestDisposePageState();
}

class _TestDisposePageState extends State<TestDisposePage> {
  late Timer _timer;
  bool showAWidget = true;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 5), (_) {
      setState(() {
        showAWidget = !showAWidget;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('test dispose page')),
      body: showAWidget ? TestAWidget() : TestBWidget(),
    );
  }
}

class TestAWidget extends StatefulWidget {
  @override
  _TestAWidgetState createState() => _TestAWidgetState();
}

class _TestAWidgetState extends State<TestAWidget> {
  @override
  void initState() {
    print('TestAWidget initState');
    super.initState();
  }

  @override
  void dispose() {
    print('TestAWidget dispost');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('in testA widget'),
    );
  }
}

class TestBWidget extends StatefulWidget {
  @override
  _TestBWidgetState createState() => _TestBWidgetState();
}

class _TestBWidgetState extends State<TestBWidget> {
  @override
  void initState() {
    print('TestBWidget initState');
    super.initState();
  }

  @override
  void dispose() {
    print('TestBWidget dispost');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('in testB widget'),
    );
  }
}
