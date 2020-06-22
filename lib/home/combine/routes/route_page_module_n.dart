import 'package:flutter/material.dart';
import 'package:hello/home/combine/routes/route_base.dart';

class RoutePageModuleN extends StatelessWidget {
  final Widget page;
  RoutePageModuleN({
    this.page,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 400,
        height: 400,
        color: Colors.blue,
        child: page,
      ),
    );
  }
}

/// page1
class RoutePageModuleNPage1 extends StatefulWidget {
  @override
  _RoutePageModuleNPage1State createState() => _RoutePageModuleNPage1State();
}

class _RoutePageModuleNPage1State extends State<RoutePageModuleNPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('moduleN page1'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Routes.globalKey.currentState.pushNamed('${Routes.pageModuleN}${Routes.moduleSeparator}${Routes.pageModuleNPage2}', arguments: {
              'pageCParams': '111',
              'key2': 222,
            });
          },
          child: Container(
            width: 200,
            height: 100,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

/// page2
class RoutePageModuleNPage2 extends StatefulWidget {
  @override
  _RoutePageModuleNPage2State createState() => _RoutePageModuleNPage2State();
}

class _RoutePageModuleNPage2State extends State<RoutePageModuleNPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('moduleN page2'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Routes.globalKey.currentState.pushNamed('${Routes.pageModuleN}${Routes.moduleSeparator}${Routes.pageModuleMPage2}', arguments: {
              'pageCParams': '111',
              'key2': 222,
            });
          },
          child: Container(
            width: 200,
            height: 100,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
