import 'package:flutter/cupertino.dart';

class TimerPickerHelper {
  static Locale _locale;
  static const _halfListZh = const <String>["上午", "下午"];
  static const _halfListEn = const <String>['A.M.', "P.M."];

  static const hourList = const <String>["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"];

  static const minuteList = const <String>["00", "05", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55"];

  static const _weekDayMap = const <String, String>{"1": "周一", "2": "周二", "3": "周三", "4": "周四", "5": "周五", "6": "周六", "7": "周日"};

  static const _monthMap = const <String, String>{
    "1": "Jan.",
    "2": "Feb.",
    "3": "Mar.",
    "4": "Apr.",
    "5": "May.",
    "6": "Jun.",
    "7": "Jul.",
    '8': 'Aug.',
    '9': 'Sept.',
    '10': 'Oct.',
    '11': 'Nov.',
    '12': 'Dec.'
  };

  static registerLocale(Locale locale) {
    _locale = locale;
  }

  static bool get _isEnglish {
    var myLocale = _locale ?? Locale.fromSubtags(languageCode: 'en');
    if (myLocale.languageCode == 'en') {
      return true;
    }
    return false;
  }

  static String get confirmString {
    return _isEnglish ? 'Confirm' : '确定';
  }

  static String get defaultTimeString {
    return _isEnglish ? 'Please select time' : '请选择时间';
  }

  static get halfList {
    return _isEnglish ? _halfListEn : _halfListZh;
  }

  static String convertDateToString(DateTime date) {
    if (_isEnglish) {
      if (date.isToday) {
        return 'Today';
      } else if (date.isTomorrow) {
        return 'Tomorrow';
      }
      var month = date.month.toString();
      return '${_monthMap[month]} ${date.day}';
    }
    if (date.isToday) {
      return '今天';
    } else if (date.isTomorrow) {
      return '明天';
    }
    String weekday = _weekDayMap["${date.weekday}"];
    return '${date.month}月${date.day}日 $weekday';
  }

//  static List<String> generateDateList(DateTime time, int num) {
//    DateTime currentDate = time;
//    if (time == null) {
//      currentDate = new DateTime.now();
//    }
//
//    List<String> dateList = [];
//    for (int i = 0; i < num; ++i) {
//      DateTime newDateTime = currentDate.add(new Duration(days: i));
//
//      int year = newDateTime.year;
//      int month = newDateTime.month;
//      int day = newDateTime.day;
//      String weekday = weekDayMap["${newDateTime.weekday}"];
//
//      dateList.add('$year $month月$day日 $weekday');
//    }
//
//    return dateList;
//  }

  /// 获取从某个时间开始的整零时日期
  static List<DateTime> generateDatesList(DateTime time, int num) {
    DateTime currentDate = time;
    if (time == null) {
      currentDate = new DateTime.now();
    }

    // 转换成今日零时
    currentDate = DateTime(currentDate.year, currentDate.month, currentDate.day);
    var dateList = List.generate(num, (index) => currentDate.add(new Duration(days: index)));
    return dateList;
  }
}

extension DateTimeExt on DateTime {
  /// 判断一个日期是否是今天内
  bool get isToday {
    var now = new DateTime.now();
    var begin = DateTime(now.year, now.month, now.day);
    var end = DateTime(now.year, now.month, now.day).add(Duration(days: 1));
    return this.millisecondsSinceEpoch >= begin.millisecondsSinceEpoch && this.millisecondsSinceEpoch < end.millisecondsSinceEpoch;
  }

  /// 判断一个日期是否是明天内
  bool get isTomorrow {
    var now = new DateTime.now();
    var begin = DateTime(now.year, now.month, now.day).add(Duration(days: 1));
    var end = DateTime(now.year, now.month, now.day).add(Duration(days: 2));
    return this.millisecondsSinceEpoch >= begin.millisecondsSinceEpoch && this.millisecondsSinceEpoch < end.millisecondsSinceEpoch;
  }
}
