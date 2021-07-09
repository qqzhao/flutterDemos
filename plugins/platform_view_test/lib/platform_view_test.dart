import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const String viewTypeString = 'plugins.platform_view_test';
//class PlatformViewTest {
//  static const MethodChannel _channel = const MethodChannel('platform_view_test');
//
//  static Future<String> get platformVersion async {
//    final String version = await _channel.invokeMethod('getPlatformVersion');
//    return version;
//  }
//}

typedef void PlatformDemoViewCreatedCallback(PlatformDemoViewController controller);

class PlatformDemoViewController {
  late MethodChannel _channel;

  PlatformDemoViewController.init(int id) {
    _channel = new MethodChannel('platform_view_test_$id');
  }

  Future<void> loadUrl(String url) async {
    // assert(url != null);
    return _channel.invokeMethod('loadUrl', url);
  }

  Future<void> reloadView() async {
    return _channel.invokeMethod('reloadView');
  }
}

class PlatformDemoView extends StatefulWidget {
  final PlatformDemoViewCreatedCallback? onCreated;
  final x;
  final y;
  final width;
  final height;

  PlatformDemoView({
    Key? key,
    @required this.onCreated,
    @required this.x,
    @required this.y,
    @required this.width,
    @required this.height,
  });

  @override
  _PlatformDemoViewState createState() => _PlatformDemoViewState();
}

class _PlatformDemoViewState extends State<PlatformDemoView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: _nativeView(),
      onHorizontalDragStart: (DragStartDetails details) {
        print("onHorizontalDragStart: ${details.globalPosition}");
        // if (!controller.value.initialized) {
        //   return;
        // }
        // _controllerWasPlaying = controller.value.isPlaying;
        // if (_controllerWasPlaying) {
        //   controller.pause();
        // }
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        print("onHorizontalDragUpdate: ${details.globalPosition}");
        print(details.globalPosition);
        // if (!controller.value.initialized) {
        //   return;
        // }
        // seekToRelativePosition(details.globalPosition);
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        print("onHorizontalDragEnd");
        // if (_controllerWasPlaying) {
        //   controller.play();
        // }
      },
      onTapDown: (TapDownDetails details) {
        print("onTapDown: ${details.globalPosition}");
      },
    );
  }

  Widget _nativeView() {
    if (Platform.isAndroid) {
      return AndroidView(
        viewType: viewTypeString,
        onPlatformViewCreated: onPlatformViewCreated,
        creationParams: <String, dynamic>{
          "x": widget.x,
          "y": widget.y,
          "width": widget.width,
          "height": widget.height,
        },
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else {
      return UiKitView(
        viewType: viewTypeString,
        onPlatformViewCreated: onPlatformViewCreated,
        creationParams: <String, dynamic>{
          "x": widget.x,
          "y": widget.y,
          "width": widget.width,
          "height": widget.height,
        },
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
  }

  Future<void> onPlatformViewCreated(int id) async {
    if (widget.onCreated == null) {
      return;
    }

    widget.onCreated?.call(new PlatformDemoViewController.init(id));
  }
}
