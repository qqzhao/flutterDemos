class TimeDurationTool {
  static Map<String, DateTime> _maps = {};

  static start(String key) {
    final newKey = key ?? '';
    if (newKey.isNotEmpty) {
      _maps.update(key, (last) => DateTime.now(), ifAbsent: () => DateTime.now());
    }
  }

  static int stop(String key) {
    final newKey = key ?? '';
    if (newKey.isNotEmpty) {
      var last = _maps[newKey] ?? DateTime.now();
      _maps.remove(newKey);
      return DateTime.now().millisecondsSinceEpoch - last.millisecondsSinceEpoch;
    }
    return 0;
  }
}
