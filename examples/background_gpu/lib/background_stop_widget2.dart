import 'dart:io';

import 'package:flutter/material.dart';

class BackGroundHandleWidget2 extends StatefulWidget {
  final Widget child;
  final bool needShow;
  BackGroundHandleWidget2({
    this.child,
    this.needShow = true,
  });
  @override
  _BackGroundHandleWidgetState createState() => _BackGroundHandleWidgetState();
}

class _BackGroundHandleWidgetState extends State<BackGroundHandleWidget2> with WidgetsBindingObserver {
  AppLifecycleState _appLifecycleState;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (Platform.isIOS) {
      switch (state) {
        case AppLifecycleState.paused:
          print('BackGroundHandleWidget paused.....');
          _appLifecycleState = AppLifecycleState.paused;
          break;
        case AppLifecycleState.resumed:
          print('BackGroundHandleWidget resumed.....');
          _appLifecycleState = AppLifecycleState.resumed;
          setState(() {});
          break;
        default:
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.needShow && _appLifecycleState == null) {
      return Container();
    }
    return Container(
      child: widget.child,
    );
  }
}
