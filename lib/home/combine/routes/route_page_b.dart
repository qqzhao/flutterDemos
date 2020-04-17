import 'package:flutter/material.dart';
import 'package:hello/home/combine/routes/route_base.dart';

class RoutePageB extends RootStatefulPage {
  @override
  _RoutePageBState createState() => _RoutePageBState();
}

class _RoutePageBState extends RootStatefulPageState<RoutePageB> {
  @override
  void initState() {
    print('in pageB: ${widget.arguments}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pageB'),
      ),
      body: Center(
        child: Container(
          width: 100.0,
          height: 100.0,
          child: Text('pageB'),
          color: Colors.red,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Routes.globalKey.currentState.pushReplacementNamed(Routes.pageC, arguments: {
            'pageBParams': '111',
            'key2': 222,
          });
        },
        label: Text('Button'),
      ),
    );
  }
}
