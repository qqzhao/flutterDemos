import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello/config/router_config.dart';
import 'package:hello/global.dart';
import 'package:hello/home/base/fitText/baseText.dart';
import 'package:hello/home/base/objectdbPage.dart';
import 'package:hello/utils/route.dart';
import './components/custom_navigator_observe.dart';
import 'home/logic/config_temp.dart' as config;
import 'package:hello/home/logic/config_temp.dart' as config2;

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

  @override
  Widget build(BuildContext context) {
    print('config origin= ${config.testVar}');
    print('config2 origin= ${config2.testVar}');
    config.testVar = '345 by main';
    print('config = ${config.testVar}');
    print('config2 = ${config2.testVar}');
    // dark: 电池条显示白色, 但是页面都是黑底、白字（白字看不见）
    // light: 电池条显示黑色（默认）
    Brightness curBright = Brightness.light;

    return new MaterialApp(
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
        fontFamily: 'PingFang SC',
      ),
      home: new RouterPage(
        routerList: globalRouters,
      ),
      navigatorKey: globalKey,
      routes: {
        '/base/objectpage': (BuildContext context) => new ObjectdbTestPage(),
      },
    );
  }
}
