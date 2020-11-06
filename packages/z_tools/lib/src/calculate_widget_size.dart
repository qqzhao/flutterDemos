part of '../z_tools.dart';

/// 当前 key，用于获取 state
GlobalKey _currentKey = GlobalKey<__WidgetContainerState>();
GlobalKey _appContainerKey = GlobalKey();

/// 需要计算的当前 widget
Widget _currentWidget = Container(
  width: 100,
  height: 100,
  color: Colors.green,
);

/// 外层 state，调用这个进行刷新
__WidgetContainerState _containerState;

/// 是否打开调试开关: 背景目前为红色
/// 注意：需要在  main函数中设置才生效
bool debugWidgetSize = false;

class _WidgetContainer extends StatefulWidget {
  @override
  __WidgetContainerState createState() => __WidgetContainerState();
}

class __WidgetContainerState extends State<_WidgetContainer> {
  @override
  void initState() {
    _containerState = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: Container(
          color: debugWidgetSize ? Colors.red : Colors.transparent,
          key: _currentKey,
          child: _currentWidget,
        ),
      ),
    );
  }
}

Future<Size> getWidgetSize(Widget widget) async {
  _currentWidget = widget;
  // ignore: invalid_use_of_protected_member
  _containerState.setState(() {});
  await Future.delayed(Duration(milliseconds: 32));
  Size size = _currentKey?.currentContext?.size ?? Size.zero;
  return size;
}

class CalculateWidgetAppContainer extends StatelessWidget {
  final Widget child;
  CalculateWidgetAppContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      key: _appContainerKey,
      child: Stack(
        children: [
          Stack(children: [
            child,
            Opacity(
              opacity: debugWidgetSize ? 1.0 : 0.01,
              child: _WidgetContainer(),
            ),
          ]),
        ],
      ),
    );
  }
}
