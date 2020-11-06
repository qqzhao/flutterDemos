part of '../../z_tools.dart';

// used by import file
String mapExt = '';

extension MapEx on Map {
  Map removeNullValues() {
    // this.keys.toList().forEach((element) {
    //   if (this[element] == null) {
    //     this.remove(element);
    //   }
    // });
    this.removeWhere((key, value) => value == null);
    return this;
  }

  /// force to convert Map from Map<dynamic, dynamic> to Map<String, String>
  /// useFirst: mark the use the first value when multi value.
  /// example: {'111': 'value1', 111: 'value2'}
  Map<String, String> forceConvertMap({bool useFirst = true}) {
    try {
      Map<String, String> b = Map.from(this);
      return b;
    } catch (e) {
      Map<String, String> c = {};
      this.keys.forEach((curKey) {
        if (useFirst) {
          c.putIfAbsent('$curKey', () => '${this[curKey]}');
        } else {
          c.update('$curKey', (value) => '${this[curKey]}', ifAbsent: () => '${this[curKey]}');
        }
      });
      return c;
    }
  }
}
