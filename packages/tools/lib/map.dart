

String join(Map map, {String separator = ''}) {
  if (map is Map){
    Iterator<MapEntry> iterator = map.entries.iterator;

    String entryToString(MapEntry entry) {
      return '${entry.key}:${entry.value}';
    }

    if (!iterator.moveNext()) return '';
    StringBuffer buffer = StringBuffer();
    if (separator == null || separator == '') {
      do {
        buffer.write('${entryToString(iterator.current)};');
      } while (iterator.moveNext());
    } else {
      buffer.write('${entryToString(iterator.current)}');
      buffer.write(separator);
      while (iterator.moveNext()) {
        buffer.write('${entryToString(iterator.current)}');
        buffer.write(separator);
      }
    }
    return buffer.toString();
  }
  return '';
}