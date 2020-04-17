import 'package:flutter/material.dart';
import 'package:hello/home/combine/routes/route_base.dart';

class RoutePageA extends StatefulWidget {
  @override
  _RoutePageAState createState() => _RoutePageAState();
}

class _RoutePageAState extends State<RoutePageA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pageA'),
      ),
      body: Center(
        child: Container(
          width: 100.0,
          height: 100.0,
          child: Text('pageA'),
          color: Colors.red,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Routes.globalKey.currentState.pushNamed(Routes.pageB, arguments: {
            'pageAParams': '111',
            'key2': 222,
          });
        },
        label: Text('Button'),
      ),
    );
  }
}
