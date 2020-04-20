import 'package:flutter/material.dart';
import 'package:hello/home/combine/routes/route_base.dart';
import 'package:hello/home/combine/routes/route_page_a.dart';
import 'package:hello/home/combine/routes/route_page_b.dart';
import 'package:hello/home/combine/routes/route_page_c.dart';

class RouteMainPage extends StatefulWidget {
  @override
  _RouteMainPageState createState() => _RouteMainPageState();
}

class _RouteMainPageState extends State<RouteMainPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      key: Routes.rootKey,
      child: Builder(
        builder: (context) {
          return Navigator(
            key: Routes.globalKey,
            initialRoute: Routes.pageA,
            onGenerateRoute: _buildRoute,
          );
        },
      ),
    );
  }
}

Route _buildRoute(RouteSettings settings) {
  print('settings == $settings');
  var pages = {
    Routes.pageA: (context) => RoutePageA(),
    Routes.pageB: (context) => RoutePageB(),
    Routes.pageC: (context) => RoutePageC(),
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
      var builder = pages[settings.name] ?? (context) => Container();
      print('builder = $builder');
      var page = builder(context);
      print('page = $page');
      if (page is RootStatelessPage) {
        page.arguments = settings.arguments;
      } else if (page is RootStatefulPage) {
        page.arguments = settings.arguments;
      }

      if (settings.isInitialRoute && page is RootStatefulPage) {
        // 设置初始化特殊参数
        page.arguments = {'isInitial': true, 'key1': 111};
      }

//      if (page == null) {
//        print('没有发现路由:${settings.name}');
//        return Container();
//      }
      return page;
    },
    settings: settings,
  );
}
