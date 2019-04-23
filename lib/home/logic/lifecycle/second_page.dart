import 'package:flutter/material.dart';

class SecondTestPage extends StatefulWidget {
  @override
  _SecondTestPageState createState() => _SecondTestPageState();
}

class _SecondTestPageState extends State<SecondTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SecondTestPage'),
      ),
      body: Container(),
    );
  }
}
