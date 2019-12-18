import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello/config/router_config.dart';
import 'package:hello/global.dart';
import 'package:hello/home/base/objectdbPage.dart';
import 'package:hello/home/logic/config_temp.dart' as config2;
import 'package:hello/utils/route.dart';
import 'package:oktoast/oktoast.dart';

import './components/custom_navigator_observe.dart';
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
  Widget build6(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GestureDetector(
        child: ConstrainedBox(
          constraints: BoxConstraints.tight(Size(300.0, 200.0)),
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
              child: GestureDetector(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(Size(200.0, 100.0)),
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.yellow),
                  ),
                ),
                onTap: () {
                  print("down inner");
                },
                behavior: HitTestBehavior.translucent,
              ),
            ),
          ),
        ),
        onTap: () {
          print("down outer");
        },
      ),
    );
  }

  /// HitTestBehavior如何设置，都会接收
  Widget build5(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Listener(
        child: ConstrainedBox(
          constraints: BoxConstraints.tight(Size(300.0, 200.0)),
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
              child: Listener(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(Size(200.0, 100.0)),
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.yellow),
                  ),
                ),
                onPointerDown: (event) {
                  print("down inner");
                },
                behavior: HitTestBehavior.deferToChild,
              ),
            ),
          ),
        ),
        onPointerDown: (event) {
          print("down outer");
        },
      ),
    );
  }

  /// 不会接收，只有down1
  Widget build4(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          Listener(
            child: ConstrainedBox(
              constraints: BoxConstraints.tight(Size(300.0, 200.0)),
              child: DecoratedBox(decoration: BoxDecoration(color: Colors.blue)),
            ),
            onPointerDown: (event) {
              print("down0");
            },
            behavior: HitTestBehavior.translucent,
          ),
          Listener(
            child: ConstrainedBox(
                constraints: BoxConstraints.tight(Size(200.0, 100.0)),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.yellow),
                )),
            onPointerDown: (event) {
              print("down1");
            },
            behavior: HitTestBehavior.translucent,
          )
        ],
      ),
    );
  }

  Widget build3(BuildContext context) {
    return MaterialApp(
      home: Container(
        child: Stack(
          children: [
            Listener(
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(Size(300.0, 200.0)),
                child: DecoratedBox(decoration: BoxDecoration(color: Colors.blue)),
              ),
              onPointerDown: (event) => print("down0"),
              behavior: HitTestBehavior.translucent,
            ),
            Listener(
              child: ConstrainedBox(
                  constraints: BoxConstraints.tight(Size(200.0, 100.0)),
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.yellow),
                  )),
              onPointerDown: (event) {
                print("down1");
              },
              behavior: HitTestBehavior.translucent,
            )
          ],
        ),
      ),
    );
  }

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
          fontFamily: 'rokkittFamily', //PingFang SC
        ),
        home: new RouterPage(
          routerList: globalRouters,
        ),
        navigatorKey: globalKey,
        routes: {
          '/base/objectpage': (BuildContext context) => new ObjectdbTestPage(),
        },
      ),
    );
  }
}
