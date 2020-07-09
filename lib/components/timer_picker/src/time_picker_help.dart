class TimerPickerHelper {
  static const halfList = const <String>["上午", "下午"];

  static const hourList = const <String>["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"];

  static const minuteList = const <String>["00", "05", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55"];

  static const weekDayMap = const <String, String>{"1": "周一", "2": "周二", "3": "周三", "4": "周四", "5": "周五", "6": "周六", "7": "周日"};

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
