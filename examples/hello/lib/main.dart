import 'package:flutter/material.dart';
import 'package:hello/config/router_config.dart';
import 'package:hello/global.dart';
import 'package:hello/home/base/objectdbPage.dart';
import 'package:hello/utils/route.dart';
import './components/custom_navigator_observe.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    // dark: 电池条显示白色, 但是页面都是黑底、白字（白字看不见）
    // light: 电池条显示黑色（默认）
    Brightness curBright = Brightness.light;

    return new MaterialApp(
      title: 'Flutter Demo',
      navigatorObservers: <NavigatorObserver>[new CustomNavObserver()],
      theme: new ThemeData(
//        primarySwatch: Colors.blue,
        // NavBar 背景的颜色
        primaryColor: Colors.red,
        accentColor: Colors.blue,
        primaryColorLight: Colors.green,

        brightness: curBright,
        primaryColorBrightness: curBright,
        accentColorBrightness: curBright,
      ),
      home: new RouterPage(routerList: globalRouters,),
      navigatorKey: globalKey,
      routes: {
        '/base/objectpage': (BuildContext context) => new ObjectdbTestPage(),
      },
    );
  }
}
