import 'package:flutter/material.dart';

import 'flexible.dart';
import 'month_item_widget.dart';

class PickerHeader extends StatefulWidget {
  final ValueChanged<CustomDateTimeRange>? dateRangeChanged;
  const PickerHeader({Key? key, this.dateRangeChanged}) : super(key: key);

  @override
  _PickerHeaderState createState() => _PickerHeaderState();
}

enum _SelectedRange {
  lastWeek,
  lastMonth,
  lastTerm,
}

class _PickerHeaderState extends State<PickerHeader> {
  CustomDateTimeRange _getTimeRange(_SelectedRange range) {
    CustomDateTimeRange retRange = CustomDateTimeRange();
    retRange.end = DateUtils.dateOnly(DateTime.now());
    if (range == _SelectedRange.lastWeek) {
      retRange.start = retRange.end!.subtract(Duration(days: 6));
    } else if (range == _SelectedRange.lastMonth) {
      // int daysInMonth = DateUtils.getDaysInMonth(retRange.end!.year, retRange.end!.month);
      retRange.start = retRange.end!.subtract(Duration(days: 30));
    } else if (range == _SelectedRange.lastTerm) {
      retRange.start = retRange.end!.subtract(Duration(days: 30 * 6));
    }
    return retRange;
  }

  void _handleCallback(_SelectedRange type) {
    var range = _getTimeRange(type);
    widget.dateRangeChanged?.call(range);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      height: 80.w,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE8E9ED),
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _Button(
            title: '近一周',
            callback: () {
              _handleCallback(_SelectedRange.lastWeek);
            },
          ),
          _Button(
            title: '近一月',
            callback: () {
              _handleCallback(_SelectedRange.lastMonth);
            },
          ),
          _Button(
            title: '本学期',
            callback: () {
              _handleCallback(_SelectedRange.lastTerm);
            },
          ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final VoidCallback? callback;
  final String title;
  const _Button({this.callback, this.title = ''});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        width: 102.w,
        height: 32.w,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFE8E9ED),
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8.w)),
        ),
        child: Center(
          child: Text(
            '$title',
            style: TextStyle(
              color: Color(0xFF292D3E),
              fontSize: 16.w,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
