import 'dart:io';

import 'package:flutter/material.dart';

/// 这种方式不生效，还是会crash
/// 因为获取状态有延迟
class BackGroundHandleWidget extends StatefulWidget {
  final Widget child;
  BackGroundHandleWidget({
    this.child,
  });
  @override
  _BackGroundHandleWidgetState createState() => _BackGroundHandleWidgetState();
}

class _BackGroundHandleWidgetState extends State<BackGroundHandleWidget> with WidgetsBindingObserver {
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
    if (_appLifecycleState == AppLifecycleState.paused) {
      return Container();
    }
    return Container(
      child: widget.child,
    );
  }
}
