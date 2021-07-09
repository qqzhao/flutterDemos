class TimeDurationTool {
  static Map<String, DateTime> _maps = {};

  static start(String key) {
    final newKey = key;
    if (newKey.isNotEmpty) {
      _maps.update(key, (last) => DateTime.now(), ifAbsent: () => DateTime.now());
    }
  }

  static int record(String key) {
    final newKey = key;
    if (newKey.isNotEmpty) {
      var last = _maps[newKey] ?? DateTime.now();
      var ret = DateTime.now().millisecondsSinceEpoch - last.millisecondsSinceEpoch;
      _maps.update(key, (last) => DateTime.now(), ifAbsent: () => DateTime.now());
      return ret;
    }
    return 0;
  }
}
