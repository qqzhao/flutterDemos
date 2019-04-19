import 'package:flutter/material.dart';
import 'package:platform_view_test/platform_view_test.dart';

class PlatformViewTestPage extends StatefulWidget {
  @override
  _PlatformViewTestPageState createState() => _PlatformViewTestPageState();
}

class _PlatformViewTestPageState extends State<PlatformViewTestPage> {
  PlatformDemoViewController _controller;
  double _platformViewX = 0.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              width: 150.0,
              height: 150.0,
              color: Colors.red[200],
              child: PlatformDemoView(
                  onCreated: (controller) {
                    _controller = controller;
                    _controller.reloadView();
//                      _controller.loadUrl('aaa');
                  },
                  x: 0,
                  y: 0,
                  width: 100,
                  height: 100),
            ),
//              Container(
//                width: 100.0,
//                height: 100.0,
//                color: Colors.yellow,
//              ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        child: Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: Colors.blue[200],
          ),
        ),
        onTap: () {
          _controller.reloadView();
        },
      ),
    ));
  }
}
