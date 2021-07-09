part of '../../z_tools.dart';

const dateExt = "for import use";

extension DateTimeExt2 on DateTime {
  /// 判断一个日期是否是今天内
  bool get isToday {
    var now = new DateTime.now();
    var begin = DateTime(now.year, now.month, now.day);
    var end = DateTime(now.year, now.month, now.day).add(Duration(days: 1));
    return millisecondsSinceEpoch >= begin.millisecondsSinceEpoch && millisecondsSinceEpoch < end.millisecondsSinceEpoch;
  }

  /// 判断一个日期是否是明天内
  bool get isTomorrow {
    var now = new DateTime.now();
    var begin = DateTime(now.year, now.month, now.day).add(Duration(days: 1));
    var end = DateTime(now.year, now.month, now.day).add(Duration(days: 2));
    return millisecondsSinceEpoch >= begin.millisecondsSinceEpoch && millisecondsSinceEpoch < end.millisecondsSinceEpoch;
  }
}
