import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello/global.dart';
import 'package:hello/home/base/objectdbPage.dart';
import 'package:hello/home/logic/config_temp.dart' as config2;
import 'package:hello/utils/route.dart';
import 'package:oktoast/oktoast.dart';

import './components/custom_navigator_observe.dart';
import 'config/router_config.dart';
import 'home/logic/config_temp.dart' as config;

Brightness curBright = Brightness.light;

void main() {
  var _isProduct = bool.fromEnvironment("dart.vm.product");
  print('_isProduct = $_isProduct');
//  print('_isDartStreamEnabled = $_isDartStreamEnabled');

  runZoned(() => runApp(Center(child: MyApp())), onError: (Object obj, StackTrace stack) {
    print('global exception: obj = $obj;\nstack = $stack');
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  /// HitTestBehavior如何设置，都只有inner接收

  @override
  Widget build(BuildContext context) {
//    return GestureDetector(
//      child: Container(
//        color: Colors.red,
//        width: 280,
//        height: 80,
//      ),
//      onDoubleTap: () {
//        print('double tap');
//      },
//      onTapUp: (_) {
//        print('onTapUp');
//      },
//      onHorizontalDragStart: (_) {
//        print('onHorizontalDragStart');
//      },
//      onTap: () {
//        print('ontap...');
//      },
//    );

    print('config origin= ${config.testVar}');
    print('config2 origin= ${config2.testVar}');
    config.testVar = '345 by main';
    print('config = ${config.testVar}');
    print('config2 = ${config2.testVar}');
    // dark: 电池条显示白色, 但是页面都是黑底、白字（白字看不见
    // ）
    // light: 电池条显示黑色（默认）
    Brightness curBright = Brightness.light;

    return OKToast(
      textStyle: TextStyle(fontSize: 22.0, color: Colors.white),
      backgroundColor: Colors.grey,
      radius: 10.0,
      child: MaterialApp(
        showPerformanceOverlay: false,
        debugShowMaterialGrid: false,
        title: 'Flutter demo1',
        navigatorObservers: <NavigatorObserver>[new CustomNavObserver()],
        theme: new ThemeData(
//        primarySwatch: Colors.blue,
          // NavBar 背景的颜色
//        primaryColor: Colors.red,
//        accentColor: Colors.blue,
          primaryColorLight: Colors.green,

          brightness: curBright,
          primaryColorBrightness: curBright,
          accentColorBrightness: curBright,
//          fontFamily: 'rokkittFamily', //PingFang SC
        ),
        home: RouterPage(
          routerList: globalRouters,
        ),
//        home: GestureTestPage(), //GestureTestPage(),
        navigatorKey: globalKey,
        routes: {
          '/base/objectpage': (BuildContext context) => new ObjectdbTestPage(),
        },
      ),
    );
  }
}
