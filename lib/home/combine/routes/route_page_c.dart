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
          child: Text('pageB'),
          color: Colors.red,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Button'),
      ),
    );
  }
}
