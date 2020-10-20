import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hello/global.dart';
import 'package:hello/home/base/object_db_page.dart';
import 'package:hello/home/logic/config_temp.dart' as config2;
import 'package:hello/utils/route.dart';
import 'package:oktoast/oktoast.dart';
import 'package:z_tools/z_tools.dart';

import './components/custom_navigator_observe.dart';
import 'config/router_config.dart';
import 'home/logic/config_temp.dart' as config;

Brightness curBright = Brightness.light;
//
// void testNull(){
//   String? a= '111';
//   print('a = $a');
//
//   String? b = 'ccc';
//   b = null;
//   print('b = $b');
// }
//
// int sign(int x) {
//   // The result is non-nullable.
//   int result;
//   if (x >= 0) {
//     result = 1;
//   } else {
//     result = -1;
//   }
//   // By this point, Dart knows the result cannot be null.
//   return result;
// }
//
// class Goo {
//   late String v;
//   Goo(int m) {
//     v = m.toString();
//   }
// }

void main() async {
  // testNull();
  debugWidgetSize = false;
  var _isProduct = bool.fromEnvironment("dart.vm.product");
  print('_isProduct = $_isProduct');
//  print('_isDartStreamEnabled = $_isDartStreamEnabled');
  var delegate = await LocalizationDelegate.create(fallbackLocale: 'en', supportedLocales: ['zh', 'en', 'es']);

  /// 先用这种方式修改语言，否则默认是中文。
  delegate.changeLocale(Locale.fromSubtags(
    languageCode: 'zh',
  ));

  var test1Str = translatePlural('plural.demo', 10);
  print('test1Str = $test1Str');

  runZoned(
    () => runApp(
      CalculateWidgetAppContainer(
        child: Center(
          child: LocalizedApp(delegate, MyApp()),
        ),
      ),
    ),
    onError: (Object obj, StackTrace stack) {
      print('global exception: obj = $obj;\nstack = $stack');
    },
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    print('config origin= ${config.testVar}');
    print('config2 origin= ${config2.testVar}');
    config.testVar = '345 by main';
    print('config = ${config.testVar}');
    print('config2 = ${config2.testVar}');
    // dark: 电池条显示白色, 但是页面都是黑底、白字（白字看不见
    // ）
    // light: 电池条显示黑色（默认）
    Brightness curBright = Brightness.light;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: OKToast(
        textStyle: TextStyle(fontSize: 22.0, color: Colors.white),
        backgroundColor: Colors.grey,
        radius: 10.0,
        child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            localizationDelegate,
          ],
          supportedLocales: localizationDelegate.supportedLocales,
          locale: localizationDelegate.currentLocale,
//          supportedLocales: [
//            const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'),
//          ],
          showPerformanceOverlay: false,
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            print('deviceLocale: $deviceLocale');
            return deviceLocale;
          },
          debugShowMaterialGrid: false,
          title: translate('app_bar.title'),
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
      ),
    );
  }
}
