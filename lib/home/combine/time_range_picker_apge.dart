import 'package:date_range_picker/date_range_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeRangePickerPage extends StatefulWidget {
  @override
  _TimerPickerPageState createState() => _TimerPickerPageState();
}

class _TimerPickerPageState extends State<TimeRangePickerPage> {
  int selectedValue = 0;
  String _dateSelectText = '';
  CustomDateTimeRange dateTimeRange = CustomDateTimeRange();

  void _showDataPicker() async {
    Locale myLocale = Localizations.localeOf(context);
    await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2016), lastDate: DateTime(2030), locale: Locale("zh", "CH"));
    // await showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  void showDateSelect() async {
    //获取当前的时间
    DateTime start = DateTime.now();
    //在当前的时间上多添加4天
    DateTime end = DateTime(start.year, start.month, start.day + 4);

    //显示时间选择器
    DateTimeRange? selectTimeRange = await showDateRangePicker(
        //语言环境
        locale: Locale("zh", "CH"),
        context: context,
        //开始时间
        firstDate: DateTime(2020, 1),
        //结束时间
        lastDate: DateTime(2022, 1),
        cancelText: "取消",
        confirmText: "确定",
        //初始的时间范围选择
        initialDateRange: DateTimeRange(start: start, end: end));
    //结果
    _dateSelectText = selectTimeRange.toString();
    //选择结果中的开始时间
    DateTime selectStart = selectTimeRange!.start;
    //选择结果中的结束时间
    DateTime selectEnd = selectTimeRange.end;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test range picker $_dateSelectText'),
      ),
      body: Column(
        children: [
          Container(
            child: FloatingActionButton(
              onPressed: () async {
                var res = await showTCRDateRangePicker(
                  context: context,
                  // selectRange: CustomDateTimeRange(start: DateTime.now(), end: DateTime.now().add(Duration(days: 6))),
                  selectRange: dateTimeRange,
                  validRange: CustomDateTimeRange(start: DateTime(2021, 1), end: DateTime(2022, 7)),
                );
                if (res != null) {
                  dateTimeRange = res;
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.timer),
        onPressed: () {
          // showDateSelect();
          _showDataPicker();
        },
      ),
    );
  }
}
