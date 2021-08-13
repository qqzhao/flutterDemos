import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'flexible.dart';

// const Duration _monthScrollDuration = Duration(milliseconds: 200);

// double _monthItemHeaderHeight = 58.w;
double _monthItemFooterHeight = 4.0.w;
double _monthItemRowHeight = 31.0.w;
double _monthItemSpaceBetweenRows = 8.0.w;
double _horizontalPadding = 8.0.w;
double _maxCalendarWidthLandscape = 384.0.w;
double _maxCalendarWidthPortrait = 480.0.w;

Color _colorBlue = Color(0xFF0088FB);

const _MonthItemGridDelegate _monthItemGridDelegate = _MonthItemGridDelegate();

class CustomDateTimeRange {
  DateTime? start;
  DateTime? end;

  CustomDateTimeRange({this.start, this.end});
}

class MonthItemWidget extends StatelessWidget {
  final DateTime displayedMonth;
  final CustomDateTimeRange range;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime> changedCallback;
  MonthItemWidget({
    required this.displayedMonth,
    required this.range,
    required this.firstDate,
    required this.lastDate,
    required this.changedCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100.w,
      child: Column(
        children: [
          Row(
            children: [],
          ),
          _MonthItem(
            selectedDateEnd: range.end,
            selectedDateStart: range.start,
            currentDate: DateTime.now().add(Duration(days: 1)),
            onChanged: changedCallback,
            displayedMonth: displayedMonth,
            firstDate: firstDate,
            lastDate: lastDate,
          ),
        ],
      ),
    );
  }
}

class _MonthItem extends StatefulWidget {
  /// Creates a month item.
  _MonthItem({
    Key? key,
    this.selectedDateStart,
    this.selectedDateEnd,
    required this.currentDate,
    required this.onChanged,
    required this.firstDate,
    required this.lastDate,
    required this.displayedMonth,
    this.dragStartBehavior = DragStartBehavior.start,
  })  : assert(!firstDate.isAfter(lastDate)),
        assert(selectedDateStart == null || !selectedDateStart.isBefore(firstDate)),
        assert(selectedDateEnd == null || !selectedDateEnd.isBefore(firstDate)),
        assert(selectedDateStart == null || !selectedDateStart.isAfter(lastDate)),
        assert(selectedDateEnd == null || !selectedDateEnd.isAfter(lastDate)),
        assert(selectedDateStart == null || selectedDateEnd == null || !selectedDateStart.isAfter(selectedDateEnd)),
        super(key: key);

  /// 选中开始时间-高亮开始
  final DateTime? selectedDateStart;

  /// 选中结束时间-高亮结束
  final DateTime? selectedDateEnd;

  /// 当前显示的时间-目前没用.
  final DateTime currentDate;

  /// 点击某一天的时候调用.
  final ValueChanged<DateTime> onChanged;

  /// 允许被选中的最早的时间
  final DateTime firstDate;

  /// 允许被选中的最晚的时间
  final DateTime lastDate;

  /// 显示月份开始的时间
  final DateTime displayedMonth;

  /// 决定拖动行为：[DragStartBehavior.start]/[DragStartBehavior.down] 开始拖动
  final DragStartBehavior dragStartBehavior;

  @override
  _MonthItemState createState() => _MonthItemState();
}

class _MonthItemState extends State<_MonthItem> {
  /// List of [FocusNode]s, one for each day of the month.
  late List<FocusNode> _dayFocusNodes;

  @override
  void initState() {
    super.initState();

    /// 获取当前月份中的天数
    final int daysInMonth = DateUtils.getDaysInMonth(widget.displayedMonth.year, widget.displayedMonth.month);
    _dayFocusNodes = List<FocusNode>.generate(daysInMonth, (int index) => FocusNode(skipTraversal: true, debugLabel: 'Day ${index + 1}'));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check to see if the focused date is in this month, if so focus it.
    final DateTime? focusedDate = _FocusedDate.of(context)?.date;
    if (focusedDate != null && DateUtils.isSameMonth(widget.displayedMonth, focusedDate)) {
      _dayFocusNodes[focusedDate.day - 1].requestFocus();
    }
  }

  @override
  void dispose() {
    for (final FocusNode node in _dayFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  Color _highlightColor(BuildContext context) {
    return _colorBlue.withOpacity(0.3);
  }

  // void _dayFocusChanged(bool focused) {
  //   if (focused) {
  //     final TraversalDirection? focusDirection = _FocusedDate.of(context)?.scrollDirection;
  //     if (focusDirection != null) {
  //       ScrollPositionAlignmentPolicy policy = ScrollPositionAlignmentPolicy.explicit;
  //       switch (focusDirection) {
  //         case TraversalDirection.up:
  //         case TraversalDirection.left:
  //           policy = ScrollPositionAlignmentPolicy.keepVisibleAtStart;
  //           break;
  //         case TraversalDirection.right:
  //         case TraversalDirection.down:
  //           policy = ScrollPositionAlignmentPolicy.keepVisibleAtEnd;
  //           break;
  //       }
  //       Scrollable.ensureVisible(
  //         primaryFocus!.context!,
  //         duration: _monthScrollDuration,
  //         alignmentPolicy: policy,
  //       );
  //     }
  //   }
  // }

  /// build 某天的 Widget
  /// firstDayOffset：距离第一天偏移；daysInMonth： 这个月一共多少天；dayToBuild 构建的日期值；
  Widget _buildDayItem(BuildContext context, DateTime dayToBuild, int firstDayOffset, int daysInMonth) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextTheme textTheme = theme.textTheme;
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final TextDirection textDirection = Directionality.of(context);
    final Color highlightColor = _highlightColor(context);
    final int day = dayToBuild.day;

    final bool isDisabled = dayToBuild.isAfter(widget.lastDate) || dayToBuild.isBefore(widget.firstDate);

    BoxDecoration? decoration;
    TextStyle? itemStyle = textTheme.bodyText2!.copyWith(fontSize: 16.w);

    final bool isRangeSelected = widget.selectedDateStart != null && widget.selectedDateEnd != null;
    final bool isSelectedDayStart = widget.selectedDateStart != null && dayToBuild.isAtSameMomentAs(widget.selectedDateStart!);
    // final bool isSelectedDayStart = widget.selectedDateStart != null && dayToBuild.isAtSameDayAs(widget.selectedDateStart!);
    final bool isSelectedDayEnd = widget.selectedDateEnd != null && dayToBuild.isAtSameMomentAs(widget.selectedDateEnd!);
    // final bool isSelectedDayEnd = widget.selectedDateEnd != null && dayToBuild.isAtSameDayAs(widget.selectedDateEnd!);
    final bool isInRange = isRangeSelected && dayToBuild.isAfter(widget.selectedDateStart!) && dayToBuild.isBefore(widget.selectedDateEnd!);

    _HighlightPainter? highlightPainter;

    if (isSelectedDayStart || isSelectedDayEnd) {
      // The selected start and end dates gets a circle background
      // highlight, and a contrasting text color.
      itemStyle = textTheme.bodyText2?.apply(color: colorScheme.onPrimary);
      decoration = BoxDecoration(
        color: _colorBlue,
        shape: BoxShape.circle,
      );

      /// 开始或者结束点
      if (isRangeSelected && widget.selectedDateStart != widget.selectedDateEnd) {
        final _HighlightPainterStyle style = isSelectedDayStart ? _HighlightPainterStyle.highlightTrailing : _HighlightPainterStyle.highlightLeading;
        highlightPainter = _HighlightPainter(
          color: highlightColor,
          style: style,
          textDirection: textDirection,
        );
      }
    } else if (isInRange) {
      /// 区域中间的点
      highlightPainter = _HighlightPainter(
        color: highlightColor,
        style: _HighlightPainterStyle.highlightAll,
        textDirection: textDirection,
      );
    } else if (isDisabled) {
      /// 不可选的值，目前没有使用
      itemStyle = textTheme.bodyText2?.apply(color: colorScheme.onSurface.withOpacity(0.38));
    } else if (DateUtils.isSameDay(widget.currentDate, dayToBuild)) {
      // The current day gets a different text color and a circle stroke border.
      // itemStyle = textTheme.bodyText2?.apply(color: _colorBlue);
      // decoration = BoxDecoration(
      //   border: Border.all(color: _colorBlue, width: 1),
      //   shape: BoxShape.circle,
      // );
    }

    /// 增加semanticLabel
    String semanticLabel = '${localizations.formatDecimal(day)}, ${localizations.formatFullDate(dayToBuild)}';
    if (isSelectedDayStart) {
      semanticLabel = localizations.dateRangeStartDateSemanticLabel(semanticLabel);
    } else if (isSelectedDayEnd) {
      semanticLabel = localizations.dateRangeEndDateSemanticLabel(semanticLabel);
    }

    Widget dayWidget = Container(
      decoration: decoration,
      child: Center(
        child: Semantics(
          label: semanticLabel,
          selected: isSelectedDayStart || isSelectedDayEnd,
          child: ExcludeSemantics(
            child: Text(localizations.formatDecimal(day), style: itemStyle),
          ),
        ),
      ),
    );

    if (highlightPainter != null) {
      dayWidget = CustomPaint(
        painter: highlightPainter,
        child: dayWidget,
      );
    }

    if (!isDisabled) {
      dayWidget = InkResponse(
        // focusNode: _dayFocusNodes[day - 1],
        onTap: () => widget.onChanged(dayToBuild),
        radius: _monthItemRowHeight / 2 + 4,
        splashColor: _colorBlue.withOpacity(0.38),
        // onFocusChange: _dayFocusChanged,
        child: dayWidget,
      );
    }

    return dayWidget;
  }

  Widget _buildEdgeContainer(BuildContext context, bool isHighlighted) {
    return Container(color: isHighlighted ? _highlightColor(context) : null);
  }

  @override
  Widget build(BuildContext context) {
    // final ThemeData themeData = Theme.of(context);
    // final TextTheme textTheme = themeData.textTheme;
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final int year = widget.displayedMonth.year;
    final int month = widget.displayedMonth.month;
    final int daysInMonth = DateUtils.getDaysInMonth(year, month);

    /// 获取第一天在星期中的偏移值。比如：2021.8.1是星期日，偏移值是0
    final int dayOffset = DateUtils.firstDayOffset(year, month, localizations);

    /// 每周7天，计算需要几行
    final int weeks = ((daysInMonth + dayOffset) / DateTime.daysPerWeek).ceil();

    /// 计算总高度： _monthItemRowHeight是每行高度；_monthItemSpaceBetweenRows行间距
    final double gridHeight = weeks * _monthItemRowHeight + (weeks - 1) * _monthItemSpaceBetweenRows;
    final List<Widget> dayItems = <Widget>[];

    for (int i = 0; true; i += 1) {
      // 1-based day of month, e.g. 1-31 for January, and 1-29 for February on a leap year.
      /// day 标识每月的第几天，从1开始计数，才有相应的 item；否则返回空的占位 Container(主要是将dayOffset偏移排除)
      final int day = i - dayOffset + 1;
      if (day > daysInMonth) {
        break;
      }
      if (day < 1) {
        dayItems.add(Container());
      } else {
        final DateTime dayToBuild = DateTime(year, month, day);
        final Widget dayItem = _buildDayItem(
          context,
          dayToBuild,
          dayOffset,
          daysInMonth,
        );
        dayItems.add(dayItem);
      }
    }

    /// 这里是添加leading/trailing边界 container，为了显示 range 高亮范围
    final List<Widget> paddedDayItems = <Widget>[];
    for (int i = 0; i < weeks; i++) {
      final int start = i * DateTime.daysPerWeek;
      final int end = math.min(
        start + DateTime.daysPerWeek,
        dayItems.length,
      );

      /// 每次取7个
      final List<Widget> weekList = dayItems.sublist(start, end);

      final DateTime dateAfterLeadingPadding = DateTime(year, month, start - dayOffset + 1);
      // Only color the edge container if it is after the start date and
      // on/before the end date.
      final bool isLeadingInRange = !(dayOffset > 0 && i == 0) &&
          widget.selectedDateStart != null &&
          widget.selectedDateEnd != null &&
          dateAfterLeadingPadding.isAfter(widget.selectedDateStart!) &&
          !dateAfterLeadingPadding.isAfter(widget.selectedDateEnd!);
      weekList.insert(0, _buildEdgeContainer(context, isLeadingInRange));

      // Only add a trailing edge container if it is for a full week and not a
      // partial week.
      if (end < dayItems.length || (end == dayItems.length && dayItems.length % DateTime.daysPerWeek == 0)) {
        final DateTime dateBeforeTrailingPadding = DateTime(year, month, end - dayOffset);
        // Only color the edge container if it is on/after the start date and
        // before the end date.
        final bool isTrailingInRange = widget.selectedDateStart != null &&
            widget.selectedDateEnd != null &&
            !dateBeforeTrailingPadding.isBefore(widget.selectedDateStart!) &&
            dateBeforeTrailingPadding.isBefore(widget.selectedDateEnd!);
        weekList.add(_buildEdgeContainer(context, isTrailingInRange));
      }

      /// weekList 中元素变成9个
      paddedDayItems.addAll(weekList);
    }

    final double maxWidth = MediaQuery.of(context).orientation == Orientation.landscape ? _maxCalendarWidthLandscape : _maxCalendarWidthPortrait;
    return Column(
      children: <Widget>[
        // Container(
        //   constraints: BoxConstraints(maxWidth: maxWidth),
        //   height: _monthItemHeaderHeight,
        //   padding: const EdgeInsets.symmetric(horizontal: 16),
        //   alignment: AlignmentDirectional.centerStart,
        //   child: ExcludeSemantics(
        //     child: Text(
        //       localizations.formatMonthYear(widget.displayedMonth),
        //       style: textTheme.bodyText2!.apply(color: themeData.colorScheme.onSurface),
        //     ),
        //   ),
        // ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          width: maxWidth,
          margin: EdgeInsets.only(bottom: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((e) {
              return Container(
                color: Colors.transparent,
                width: 20.w,
                child: Center(
                  child: Text(
                    '$e',
                    style: TextStyle(
                      fontSize: 16.w,
                      color: Color(0xFF80838D),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Container(
          constraints: BoxConstraints(
            maxWidth: maxWidth,
            maxHeight: gridHeight,
          ),
          child: GridView.custom(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: _monthItemGridDelegate,
            childrenDelegate: SliverChildListDelegate(
              paddedDayItems,
              addRepaintBoundaries: false,
            ),
          ),
        ),
        SizedBox(height: _monthItemFooterHeight),
      ],
    );
  }
}

/// Determines which style to use to paint the highlight.
enum _HighlightPainterStyle {
  /// Paints nothing.
  none,

  /// Paints a rectangle that occupies the leading half of the space.
  highlightLeading,

  /// Paints a rectangle that occupies the trailing half of the space.
  highlightTrailing,

  /// Paints a rectangle that occupies all available space.
  highlightAll,
}

/// This custom painter will add a background highlight to its child.
///
/// This highlight will be drawn depending on the [style], [color], and
/// [textDirection] supplied. It will either paint a rectangle on the
/// left/right, a full rectangle, or nothing at all. This logic is determined by
/// a combination of the [style] and [textDirection].
class _HighlightPainter extends CustomPainter {
  _HighlightPainter({
    required this.color,
    this.style = _HighlightPainterStyle.none,
    this.textDirection,
  });

  final Color color;
  final _HighlightPainterStyle style;
  final TextDirection? textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    if (style == _HighlightPainterStyle.none) {
      return;
    }

    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Rect rectLeft = Rect.fromLTWH(0, 0, size.width / 2, size.height);
    final Rect rectRight = Rect.fromLTWH(size.width / 2, 0, size.width / 2, size.height);

    switch (style) {
      case _HighlightPainterStyle.highlightTrailing:
        canvas.drawRect(
          textDirection == TextDirection.ltr ? rectRight : rectLeft,
          paint,
        );
        break;
      case _HighlightPainterStyle.highlightLeading:
        canvas.drawRect(
          textDirection == TextDirection.ltr ? rectLeft : rectRight,
          paint,
        );
        break;
      case _HighlightPainterStyle.highlightAll:
        canvas.drawRect(
          Rect.fromLTWH(0, 0, size.width, size.height),
          paint,
        );
        break;
      case _HighlightPainterStyle.none:
        break;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// InheritedWidget indicating what the current focused date is for its children.
///
/// This is used by the [_MonthPicker] to let its children [_DayPicker]s know
/// what the currently focused date (if any) should be.
class _FocusedDate extends InheritedWidget {
  const _FocusedDate({
    Key? key,
    required Widget child,
    this.date,
    this.scrollDirection,
  }) : super(key: key, child: child);

  final DateTime? date;
  final TraversalDirection? scrollDirection;

  @override
  bool updateShouldNotify(_FocusedDate oldWidget) {
    return !DateUtils.isSameDay(date, oldWidget.date) || scrollDirection != oldWidget.scrollDirection;
  }

  static _FocusedDate? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_FocusedDate>();
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

  /// The number of children in the cross axis.
  final int crossAxisCount;

  /// The width in logical pixels of the day child widgets.
  final double dayChildWidth;

  /// The width in logical pixels of the edge child widgets.
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
