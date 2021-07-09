import 'package:flutter/cupertino.dart';

/// ignore_for_file: must_be_immutable
/// 上面那一句失效了：flutter: 1.22.
class Routes {
  static const String moduleSeparator = '/';

  static const String pageA = 'pageA';
  static const String pageB = 'pageB';
  static const String pageC = 'pageC';
  static const String pageModuleM = 'pageModuleM';
  static const String pageModuleMPage1 = 'pageModuleMPage1';
  static const String pageModuleMPage2 = 'pageModuleMPage2';

  /// 这样页面可以任意组合
  static const String pageModuleN = 'pageModuleN';
  static const String pageModuleNPage1 = 'pageModuleNPage1';
  static const String pageModuleNPage2 = 'pageModuleNPage2';

  /// 生成 path
  static String gen(List<String> paths) {
    return paths.join(Routes.moduleSeparator);
  }

  // 外层，用于 alert，toast
  static final GlobalKey<NavigatorState> rootKey = GlobalKey<NavigatorState>();

  // 内层，用于页面
  static final GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
}

// RootStatelessPage
// ignore: must_be_immutable
abstract class RootStatelessPage extends StatelessWidget {
  Object? arguments;
  RootStatelessPage({this.arguments});
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// RootStatefulPage
// ignore: must_be_immutable
abstract class RootStatefulPage extends StatefulWidget {
  Object? arguments;
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
// ignore: must_be_immutable
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
