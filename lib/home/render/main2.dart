import 'dart:ui' as ui show SingletonFlutterWindow, window;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// import 'render/render_object_to_widget.dart';
import 'render/render_view.dart';

ViewConfiguration createViewConfiguration() {
  final double devicePixelRatio = ui.window.devicePixelRatio;
  return ViewConfiguration(
    size: ui.window.physicalSize / devicePixelRatio,
    devicePixelRatio: devicePixelRatio,
  );
}

ui.SingletonFlutterWindow get window => ui.window;

/// 这样写不行
/// 因为 【WidgetsBinding.instance】中的一些变量还是没有对应上。
void main() async {
  // var app = Directionality(
  //   textDirection: TextDirection.ltr,
  //   child: Center(
  //     child: Container(
  //       width: 100,
  //       height: 100,
  //       color: Colors.yellow,
  //     ),
  //   ),
  // );

//  WidgetsFlutterBinding.ensureInitialized()..scheduleAttachRootWidget(app);
//  return;
  WidgetsFlutterBinding.ensureInitialized();

  // var buildOwner = WidgetsBinding.instance!.buildOwner;
//  var renderView = WidgetsBinding.instance!.renderView;
  var renderView = MyRenderView(configuration: createViewConfiguration(), window: window);
  renderView.attach(WidgetsBinding.instance!.pipelineOwner);
  renderView.prepareInitialFrame();

  // var renderViewElement = MyRenderObjectToWidgetAdapter<RenderBox>(
  //   container: renderView,
  //   debugShortDescription: '[root]',
  //   child: app,
  // );

  // renderViewElement.attachToRenderTree(buildOwner!, null);

//  WidgetsBinding.instance!.renderView = renderView;

  window.scheduleFrame();

//  WidgetsBinding.instance!.scheduleAttachRootWidget(app);
//  WidgetsBinding.instance!.scheduleWarmUpFrame();
}
