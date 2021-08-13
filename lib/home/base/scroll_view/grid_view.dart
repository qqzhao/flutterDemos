import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GridViewPage extends StatefulWidget {
  const GridViewPage({Key? key}) : super(key: key);

  @override
  _GridViewPageState createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  @override
  Widget build(BuildContext context) {
    var paddedDayItems = List.generate(20, (index) {
      return Container(
        color: Colors.red,
        child: Text('index:$index'),
      );
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('listView1'),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            color: Colors.black26,
          ),
          Expanded(
            child: Container(
              child: GridView.custom(
                padding: EdgeInsets.zero,
                // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
                gridDelegate: _MonthItemGridDelegate(),
                childrenDelegate: SliverChildListDelegate(
                  paddedDayItems,
                  addRepaintBoundaries: false,
                ),
                // itemBuilder: (context, index) {
                //   return Container(
                //     child: Text('$index'),
                //   );
                // }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

double _monthItemRowHeight = 31.0.w;
double _monthItemSpaceBetweenRows = 8.0.w;
double _horizontalPadding = 48.0.w;
// double _maxCalendarWidthLandscape = 384.0.w;
// double _maxCalendarWidthPortrait = 480.0.w;

extension DoubleExt on double {
  double get w {
    return this;
  }
}

class _MonthItemGridDelegate extends SliverGridDelegate {
  const _MonthItemGridDelegate();

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final double tileWidth = (constraints.crossAxisExtent - 2 * _horizontalPadding) / DateTime.daysPerWeek;
    return _MonthSliverGridLayout(
      crossAxisCount: DateTime.daysPerWeek + 2,
      dayChildWidth: tileWidth,
      edgeChildWidth: _horizontalPadding,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(_MonthItemGridDelegate oldDelegate) => false;
}

class _MonthSliverGridLayout extends SliverGridLayout {
  const _MonthSliverGridLayout({
    required this.crossAxisCount,
    required this.dayChildWidth,
    required this.edgeChildWidth,
    required this.reverseCrossAxis,
  })   : assert(crossAxisCount > 0),
        assert(dayChildWidth >= 0),
        assert(edgeChildWidth >= 0);

  /// 水平轴上每一行的元素个数.
  final int crossAxisCount;

  /// day widget 所暂用的宽度.
  final double dayChildWidth;

  /// 边沿 child 所暂用的宽度
  final double edgeChildWidth;

  /// Whether the children should be placed in the opposite order of increasing
  /// coordinates in the cross axis.
  ///
  /// For example, if the cross axis is horizontal, the children are placed from
  /// left to right when [reverseCrossAxis] is false and from right to left when
  /// [reverseCrossAxis] is true.
  ///
  /// Typically set to the return value of [axisDirectionIsReversed] applied to
  /// the [SliverConstraints.crossAxisDirection].
  /// 水平轴是否翻转=
  final bool reverseCrossAxis;

  /// The number of logical pixels from the leading edge of one row to the
  /// leading edge of the next row.
  double get _rowHeight {
    return _monthItemRowHeight + _monthItemSpaceBetweenRows;
  }

  /// The height in logical pixels of the children widgets.
  double get _childHeight {
    return _monthItemRowHeight;
  }

  @override
  int getMinChildIndexForScrollOffset(double scrollOffset) {
    return crossAxisCount * (scrollOffset ~/ _rowHeight);
  }

  @override
  int getMaxChildIndexForScrollOffset(double scrollOffset) {
    final int mainAxisCount = (scrollOffset / _rowHeight).ceil();
    return math.max(0, crossAxisCount * mainAxisCount - 1);
  }

  double _getCrossAxisOffset(double crossAxisStart, bool isPadding) {
    if (reverseCrossAxis) {
      return ((crossAxisCount - 2) * dayChildWidth + 2 * edgeChildWidth) - crossAxisStart - (isPadding ? edgeChildWidth : dayChildWidth);
    }
    return crossAxisStart;
  }

  @override
  SliverGridGeometry getGeometryForChildIndex(int index) {
    final int adjustedIndex = index % crossAxisCount;
    final bool isEdge = adjustedIndex == 0 || adjustedIndex == crossAxisCount - 1;
    final double crossAxisStart = math.max(0, (adjustedIndex - 1) * dayChildWidth + edgeChildWidth);

    return SliverGridGeometry(
      scrollOffset: (index ~/ crossAxisCount) * _rowHeight,
      crossAxisOffset: _getCrossAxisOffset(crossAxisStart, isEdge),
      mainAxisExtent: _childHeight, // 主轴尺寸
      crossAxisExtent: isEdge ? edgeChildWidth : dayChildWidth, // 辅助轴尺寸
    );
  }

  @override
  double computeMaxScrollOffset(int childCount) {
    assert(childCount >= 0);
    final int mainAxisCount = ((childCount - 1) ~/ crossAxisCount) + 1;
    final double mainAxisSpacing = _rowHeight - _childHeight;
    return _rowHeight * mainAxisCount - mainAxisSpacing;
  }
}
