import 'package:flutter/widgets.dart';

class TransitionBuilderWidget extends StatefulWidget {
  final TransitionBuilder builder;
  final Widget child;
  final VoidCallback didChangeMetricsCallBack;

  /// add didChangeMetricsCallBack
  const TransitionBuilderWidget(
      {Key? key,
      required this.builder,
      required this.child,
      required this.didChangeMetricsCallBack})
      : super(key: key);

  @override
  _TransitionBuilderWidgetState createState() {
    return _TransitionBuilderWidgetState();
  }
}

class _TransitionBuilderWidgetState extends State<TransitionBuilderWidget>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  ///应用尺寸改变时回调，例如旋转
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    widget.didChangeMetricsCallBack.call();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, widget.child);
}
