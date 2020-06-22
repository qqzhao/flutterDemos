import 'package:flutter/material.dart';
import 'package:hello/home/combine/routes/route_base.dart';

/// ignore: must_be_immutable
class RoutePageC extends RootStatelessPage {
  @override
  Widget build(BuildContext context) {
    print('in pagec : $arguments}');

    return Scaffold(
      appBar: AppBar(
        title: Text('pageC'),
      ),
      body: Center(
        child: Container(
          width: 100.0,
          height: 100.0,
          child: Text('pageC'),
          color: Colors.red,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          var name = '${Routes.pageModuleM}${Routes.moduleSeparator}${Routes.pageModuleMPage1}';
          name = '${Routes.pageModuleN}${Routes.moduleSeparator}${Routes.pageModuleM}${Routes.moduleSeparator}${Routes.pageModuleMPage1}';
          Routes.globalKey.currentState.pushNamed(name, arguments: {
            'pageCParams': '111',
            'key2': 222,
          });
        },
        label: Text('Button'),
      ),
    );
  }
}
