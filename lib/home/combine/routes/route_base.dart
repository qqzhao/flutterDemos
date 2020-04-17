import 'package:flutter/cupertino.dart';

class Routes {
  static const String pageA = '/pageA';
  static const String pageB = '/pageB';
  static const String pageC = '/pageC';

  // 外层，用于 alert，toast
  static final GlobalKey<NavigatorState> rootKey = GlobalKey<NavigatorState>();

  // 内层，用于页面
  static final GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
}

// RootStatelessPage
class RootStatelessPage extends StatelessWidget {
  Object arguments;
  RootStatelessPage({this.arguments});
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// RootStatefulPage
class RootStatefulPage extends StatefulWidget {
  Object arguments;
  RootStatefulPage({this.arguments});
  @override
  RootStatefulPageState createState() => RootStatefulPageState();
}

class RootStatefulPageState<T extends RootStatefulPage> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// example 使用方法
class ExamplePage11 extends RootStatefulPage {
  @override
  _ExamplePage11State createState() => _ExamplePage11State();
}

class _ExamplePage11State extends RootStatefulPageState<ExamplePage11> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
