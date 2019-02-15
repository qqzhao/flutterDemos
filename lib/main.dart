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
import 'package:gbk2utf8/gbk2utf8.dart' as gbk2utf8;

Brightness curBright = Brightness.light;

void _testGBK() {
  String test1 = 'We\'re going to visit Paris.';
  var test1Buffer = latin1.encode(test1);
  print('test1Buffer = $test1Buffer');
  var test2 = gbk2utf8.decodeGbk(test1Buffer);
  print('test2 = $test2');
  try {
    var test2Buffer = latin1.encode(test2);
    print('test2Buffer = $test2Buffer');
  } catch (e) {
    print('excep = $e');
  }
}

void main() {
  var _isProduct = bool.fromEnvironment("dart.vm.product");
  print('_isProduct = $_isProduct');
  _testGBK();
//  print('_isDartStreamEnabled = $_isDartStreamEnabled');

  runZoned(() => runApp(MyApp()), onError: (Object obj, StackTrace stack) {
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
