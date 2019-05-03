import 'package:flutter/material.dart';

BuildContext contextInSecond;
State stateInSecond;

class SecondTestPage extends StatefulWidget {
  @override
  _SecondTestPageState createState() => _SecondTestPageState();
}

class _SecondTestPageState extends State<SecondTestPage> {
  @override
  void initState() {
    super.initState();
    stateInSecond = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SecondTestPage'),
      ),
      body: Container(
        child: Builder(builder: (context) {
          contextInSecond = context;
          return Text('in second page');
        }),
      ),
    );
  }
}
