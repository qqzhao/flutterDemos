import 'package:flutter/material.dart';

/// 如何淡入淡出切换两个Widget
class TestTwoWidgetAnimationPage extends StatefulWidget {
  @override
  _TestTwoWidgetAnimationPageState createState() => _TestTwoWidgetAnimationPageState();
}

class _TestTwoWidgetAnimationPageState extends State<TestTwoWidgetAnimationPage> {
  bool _first = false;
  void _changeValue() {
    setState(() {
      _first = !_first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TestTwoWidgetAnimationPage'),
      ),
      body: Container(
        child: new AnimatedCrossFade(
          duration: const Duration(milliseconds: 2000),
          firstChild: const FlutterLogo(style: FlutterLogoStyle.horizontal, size: 100.0),
          secondChild: const FlutterLogo(style: FlutterLogoStyle.stacked, size: 100.0),
          crossFadeState: _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _changeValue),
    );
  }
}
