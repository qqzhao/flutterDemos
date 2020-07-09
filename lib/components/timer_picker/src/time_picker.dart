import 'dart:async';

import 'package:flutter/material.dart';

import 'assistant.dart';
import 'cupertino_picker_wrap.dart';
import 'flexible.dart';
import 'time_picker_help.dart';

const double _defaultHeight = 345.0;
const String _defaultTitle = '请选择时间';

typedef TimePickerCallback = void Function(DateTime time);

/// 时间选择器
class TCRTimePicker extends StatefulWidget {
  final int initialIndex;
  final String title;
  final double height;
  final TimePickerCallback callback;
  final DateTime beginTime;
  final DateTime selectTime;

  TCRTimePicker({
    this.initialIndex = 0,
    this.title = _defaultTitle,
    this.height = _defaultHeight,
    this.callback,
    this.beginTime,
    this.selectTime,
  }) : super() {
    assert(initialIndex >= 0, 'TCRTimePicker中 initialIndex 参数错误');
    if (beginTime != null && selectTime != null) {
      assert(!beginTime.isAfter(selectTime), 'TCRTimePicker中 beginTime应该在selectTime之前');
    }
  }

  @override
  _TCRTimePickerState createState() => _TCRTimePickerState();
}

class _TCRTimePickerState extends State<TCRTimePicker> {
  int _dateIndex;
  int _halfIndex;
  int _hourIndex;
  int _minuteIndex;
  int _secondIndex;
  List<DateTime> _dateList;
  Timer _timer;

  @override
  void initState() {
    _updateData();
    super.initState();
    // 如果两者都为空的话，每间隔一分钟更新一次
    if (widget.beginTime == null && widget.selectTime == null) {
      _timer = Timer.periodic(Duration(minutes: 1), (_) {
        _updateData();
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateData() {
    _dateList = TimerPickerHelper.generateDatesList(widget.beginTime, 100);
    var selectTime = widget.selectTime ?? DateTime.now();
    _updateAllIndex(selectTime);
    // 这里特殊处理，需要再计算一次(条件：selectTime.minute > 55)
    if (_minuteIndex == 12) {
      selectTime = selectTime.add(Duration(minutes: 5));
      _updateAllIndex(selectTime);
      _minuteIndex = 0;
    }
  }

  /// 更新日期列表和索引值
  void _updateAllIndex(DateTime selectTime) {
    var selectTimeZero = DateTime(selectTime.year, selectTime.month, selectTime.day);
    _dateIndex = _dateList.indexOf(selectTimeZero);
    _halfIndex = selectTime.hour >= 12 ? 1 : 0;
    _hourIndex = selectTime.hour == 0 ? 11 : (selectTime.hour % 12 - 1);
    _minuteIndex = (selectTime.minute / 5).ceil();
    _secondIndex = selectTime.second;
    print('selectTime = $selectTime, _secondIndex = $_secondIndex, _minuteIndex= $_minuteIndex');
  }

  /// 生成选中的时间
  DateTime _generateSelectTime() {
    var hour = _halfIndex == 1 ? (_hourIndex + 12 + 1) : (_hourIndex + 1);
    var minus = int.parse(TimerPickerHelper.minuteList[_minuteIndex]);
    var curDay = _dateList[_dateIndex];
    return DateTime(curDay.year, curDay.month, curDay.day, hour, minus);
  }

  @override
  Widget build(BuildContext context) {
    XFlexible.registerWidth(MediaQuery.of(context).size.width);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.w),
          topRight: Radius.circular(10.w),
        ),
      ),
      child: SafeArea(
        child: Container(
          height: widget.height ?? _defaultHeight,
          child: Column(
            children: <Widget>[
              Header(
                callback: () {
                  Navigator.of(context).maybePop();
                },
                title: widget.title ?? _defaultTitle,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.0.w),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 3,
                        child: Container(
                          child: CupertinoPickerWrap(
                            onChange: (value) {
                              setState(() {
                                _dateIndex = value;
                              });
                            },
                            selectedIndex: _dateIndex,
                            items: _dateList.map((date) {
                              if (date.isToday) {
                                return '今天';
                              } else if (date.isTomorrow) {
                                return '明天';
                              }
                              String weekday = TimerPickerHelper.weekDayMap["${date.weekday}"];
                              return '${date.month}月${date.day}日 $weekday';
                            }).toList(),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          color: Colors.yellow,
                          child: CupertinoPickerWrap(
                            onChange: (value) {
                              setState(() {
                                _halfIndex = value;
                              });
                            },
                            selectedIndex: _halfIndex,
                            items: TimerPickerHelper.halfList,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: CupertinoPickerWrap(
                            onChange: (value) {
                              setState(() {
                                _hourIndex = value;
                              });
                            },
                            selectedIndex: _hourIndex,
                            items: TimerPickerHelper.hourList,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          color: Colors.black,
                          child: CupertinoPickerWrap(
                            onChange: (value) {
                              setState(() {
                                _minuteIndex = value;
                              });
                            },
                            selectedIndex: _minuteIndex,
                            items: TimerPickerHelper.minuteList,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Bottom(
                callback: () {
                  Navigator.of(context).maybePop();
                  if (widget.callback != null) {
                    widget.callback(_generateSelectTime());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
