/*
1. onNotification 和 scrollController 可以同时监听滑动事件。
2. _handleNotificationOuter怎么设置都接受不到消息。

atEdge → bool - 是否能够正好匹配 min/maxScrollExtent。
axis → Axis - 视图滚动的轴。
axisDirection → AxisDirection - 滚动的方向。
extentAfter → double - 位于可滚动视口的“下方”的数量。
extentBefore → double - 位于可滚动视口的“上方”的数量。
extentInside → double - 可见内容的数量。
maxScrollExtent → double - 滚动最大的范围。
minScrollExtent → double - 滚动最小的范围。
outOfRange → bool - 是否在范围内。
pixels → double - 当前滚动位置。
viewportDimension → double - 沿着 axisDirection 的视口范围。
链接：https://www.jianshu.com/p/e6dafb114855
 */
import 'dart:math' as math;

import 'package:flutter/material.dart';

class CustomScrollableScrollPhysics extends ScrollPhysics {
  /// Creates scroll physics that does not let the user scroll.
  const CustomScrollableScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  CustomScrollableScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollableScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) {
    print('position.outOfRange = ${position.outOfRange}');
    if (position.outOfRange) {
      return false;
    }
    return true;
  }

  @override
  bool get allowImplicitScrolling => false;
}

class Custom2ScrollPhysics extends ScrollPhysics {
  /// Creates scroll physics that prevent the scroll offset from exceeding the
  /// bounds of the content..
  const Custom2ScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  Custom2ScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return Custom2ScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    assert(() {
      if (value == position.pixels) {
        throw FlutterError('$runtimeType.applyBoundaryConditions() was called redundantly.\n'
            'The proposed new position, $value, is exactly equal to the current position of the '
            'given ${position.runtimeType}, ${position.pixels}.\n'
            'The applyBoundaryConditions method should only be called when the value is '
            'going to actually change the pixels, otherwise it is redundant.\n'
            'The physics object in question was:\n'
            '  $this\n'
            'The position object in question was:\n'
            '  $position\n');
      }
      return true;
    }());
    if (value < position.pixels && position.pixels <= position.minScrollExtent) // underscroll
    {
      return value - position.pixels;
    }
    if (position.maxScrollExtent <= position.pixels && position.pixels < value) // overscroll
    {
      return value - position.pixels;
    }
    if (value < position.minScrollExtent && position.minScrollExtent < position.pixels) // hit top edge
    {
      return value - position.minScrollExtent;
    }
    if (position.pixels < position.maxScrollExtent && position.maxScrollExtent < value) // hit bottom edge
    {
      return value - position.maxScrollExtent;
    }
    return 0.0;
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    final Tolerance tolerance = this.tolerance;
    if (position.outOfRange) {
      double? end;
      if (position.pixels > position.maxScrollExtent) end = position.maxScrollExtent;
      if (position.pixels < position.minScrollExtent) end = position.minScrollExtent;
      assert(end != null);
      return ScrollSpringSimulation(spring, position.pixels, end!, math.min(0.0, velocity), tolerance: tolerance);
    }
    if (velocity.abs() < tolerance.velocity) return null;
    if (velocity > 0.0 && position.pixels >= position.maxScrollExtent) return null;
    if (velocity < 0.0 && position.pixels <= position.minScrollExtent) return null;
    return ClampingScrollSimulation(
      position: position.pixels,
      velocity: velocity,
      tolerance: tolerance,
    );
  }
}

class TestListView2 extends StatefulWidget {
  @override
  _TestListView1State createState() => _TestListView1State();
}

class _TestListView1State extends State<TestListView2> {
  ScrollController scrollController = ScrollController();

  bool _handleNotificationOuter(ScrollNotification note) {
    print('_handleNotificationOuter');
    return false;
  }

  bool _handleNotification(ScrollNotification note) {
    print('notification: ${note.metrics.pixels.toInt()}'); // 滚动位置。
//    print('note.metrics.atEdge = ${note.metrics.atEdge}');
//    print('note.metrics.extentAfter = ${note.metrics.extentAfter}');
//    print('note.metrics.extentBefore = ${note.metrics.extentBefore}');
//    print('note.metrics.extentInside = ${note.metrics.extentInside}');
//    print('note.metrics.maxScrollExtent = ${note.metrics.maxScrollExtent}');
//    print('note.metrics.minScrollExtent = ${note.metrics.minScrollExtent}');
//    print('note.metrics.outOfRange = ${note.metrics.outOfRange}');
//    print('note.metrics.pixels = ${note.metrics.pixels}');
//    print('note.metrics.viewportDimension = ${note.metrics.viewportDimension}');
//    print('note.context = ${note.context}');
//    if (note.metrics.pixels <= 0) {
//      scrollController.jumpTo(0);
//    }
    return false;
  }

  @override
  void initState() {
    scrollController.addListener(() {
      print('scrollController value: ${scrollController.offset}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text('test listview 2'),
          ),
          body: NotificationListener(
            child: ListView.builder(
                itemCount: 40,
                controller: scrollController,
                physics: Custom2ScrollPhysics(),
                itemBuilder: (context, index) {
                  return Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 40.0,
                          child: Text('Data: $index'),
                        ),
                        Divider(),
                      ],
                    ),
                  );
                }),
            onNotification: _handleNotification,
          ),
        ),
      ),
      onNotification: _handleNotificationOuter,
    );
  }
}
