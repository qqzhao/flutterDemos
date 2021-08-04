import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hello/global.dart';
import 'package:hello/home/base/object_db_page.dart';
import 'package:hello/utils/route.dart';
import 'package:oktoast/oktoast.dart';
import 'package:z_tools/z_tools.dart';

import './components/custom_navigator_observe.dart';
import 'components/flutter_screen_ratio_adapter/screen_ratio_adapter.dart';
import 'config/router_config.dart';

///设计稿尺寸，单位应是pt或dp
//var uiSize = BlueprintsRectangle(300, 510);
// var uiSize = BlueprintsRectangle(721, 628);
var uiSize = BlueprintsRectangle(640, 1024);

Brightness curBright = Brightness.light;

void main() async {
  // testNull();
  debugWidgetSize = false;
  var _isProduct = true; //bool.fromEnvironment("dart.vm.product");
  print('_isProduct = $_isProduct');
  // print('_isDartStreamEnabled = $_isDartStreamEnabled');
  // var delegate = await LocalizationDelegate.create(fallbackLocale: 'en', supportedLocales: ['zh', 'en', 'es']);
//
//   /// 先用这种方式修改语言，否则默认是中文。
//   delegate.changeLocale(Locale.fromSubtags(
//     languageCode: 'zh',
//   ));
//
//   var test1Str = translatePlural('plural.demo', 10);
//   print('test1Str = $test1Str');

  runZoned(
    () => runFxApp(
      CalculateWidgetAppContainer(
        child: Center(
          // child: LocalizedApp(delegate, MyApp()),
          child: MyApp(),
        ),
      ),
      uiBlueprints: uiSize,
      onEnsureInitialized: () {},
      enableLog: false,
    ),
    onError: (Object obj, StackTrace stack) {
      print('global exception: obj = $obj;\nstack = $stack');
    },
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    // print('size = $size');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OKToast(
        textStyle: TextStyle(fontSize: 22.0, color: Colors.white),
        backgroundColor: Colors.grey,
        radius: 10.0,
        child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'),
          ],
          showPerformanceOverlay: false,
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            print('deviceLocale: $deviceLocale');
            return deviceLocale;
          },
          debugShowMaterialGrid: false,
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
          initialRoute: '/',
          home: RouterPage(
            routerList: globalRouters,
          ),
          builder: FxTransitionBuilder(builder: null),
          // home: GestureTestPage(), //GestureTestPage(),
          navigatorKey: globalKey,
          // routes: {
          //   '/base/objectpage': (BuildContext context) => new ObjectdbTestPage(),
          // },
        ),
      ),
    );
  }
}

class MyAppIgnore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
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
          // builder: FxTransitionBuilder(builder: null),
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
