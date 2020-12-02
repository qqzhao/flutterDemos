import 'package:flutter/material.dart';
import 'package:hello/home/combine/routes/route_base.dart';
import 'package:hello/home/combine/routes/route_page_a.dart';
import 'package:hello/home/combine/routes/route_page_b.dart';
import 'package:hello/home/combine/routes/route_page_c.dart';
import 'package:hello/home/combine/routes/route_page_module_m.dart';
import 'package:hello/home/combine/routes/route_page_module_n.dart';
import 'package:provider/provider.dart';

class RouteMainPage extends StatefulWidget {
  @override
  _RouteMainPageState createState() => _RouteMainPageState();
}

class MyIntValue {
  final int value;
  MyIntValue({this.value});
}

class _RouteMainPageState extends State<RouteMainPage> {
  @override
  Widget build(BuildContext context) {
    bool debugProvider = true;
    if (debugProvider) {
      return MultiProvider(
        providers: [
          Provider<MyIntValue>(
            create: (BuildContext context) {
              return MyIntValue(value: 1999);
            },
            dispose: (BuildContext context, MyIntValue value) {},
          ),
        ],
        child: Navigator(
          key: Routes.globalKey,
          initialRoute: Routes.pageA,
          onGenerateRoute: _buildRoute,
          onPopPage: (Route<dynamic> route, dynamic result) {
            return false;
          },
          onUnknownRoute: (RouteSettings settings) {
            return null;
          },
        ),
      );
    }

    return Material(
      key: Routes.rootKey,
      child: Builder(
        builder: (context) {
          return MultiProvider(
            providers: [
              Provider<MyIntValue>(
                create: (BuildContext context) {
                  return MyIntValue(value: 999);
                },
                dispose: (BuildContext context, MyIntValue value) {},
              ),
            ],
            child: Navigator(
              key: Routes.globalKey,
              initialRoute: Routes.pageA,
              onGenerateRoute: _buildRoute,
            ),
          );
        },
      ),
    );
  }
}

Route _buildRoute(RouteSettings settings) {
  print('settings == $settings');
  Map<String, dynamic> pages = {
    '/': (context) => Container(
          width: 100,
          height: 100,
          color: Colors.redAccent,
        ),
    Routes.pageA: (context) => RoutePageA(),
    Routes.pageB: (context) => RoutePageB(),
    Routes.pageC: (context) => RoutePageC(),
    Routes.pageModuleM: (context, Widget page) => RoutePageModuleM(page: page),
    Routes.pageModuleMPage1: (context) => RoutePageModuleMPage1(),
    Routes.pageModuleMPage2: (context) => RoutePageModuleMPage2(),
    Routes.pageModuleN: (context, Widget page) => RoutePageModuleN(page: page),
    Routes.pageModuleNPage1: (context) => RoutePageModuleNPage1(),
    Routes.pageModuleNPage2: (context) => RoutePageModuleNPage2(),
//    Routes.pageModuleNPage2: (context) => Center(
//          child: Container(
//            width: 200,
//            height: 200,
//            color: Colors.brown,
//          ),
//        ),
  };
//  switch (name) {
//    case Routes.pageB:
//      page = RoutePageB();
//      break;
//    case Routes.pageA:
//      page = RoutePageA();
//      break;
//    case Routes.pageC:
//      page = RoutePageC();
//      break;
//  }

  return MaterialPageRoute(
    builder: (context) {
      Widget result;
      var separatorS = Routes.moduleSeparator;
      if (settings.name.contains(separatorS)) {
        List<String> modules = settings.name.split(separatorS).reversed.toList();
        modules.forEach((element) {
          dynamic builder = pages[element] ?? (context) => Container();
          if (result == null) {
            result = (builder as WidgetBuilder)(context);
          } else {
            /// 这种方式还是无法实现两个页面公用 widget，而是每次都创建了一个新的。
            result = (builder as TransitionBuilder)(context, result);
          }
        });
      } else {
        var builder = pages[settings.name] ?? (context) => Container();
        print('builder = $builder');
        result = (builder as WidgetBuilder)(context);
        print('page = $result');
      }

      return result;
    },
    settings: settings,
  );
}
