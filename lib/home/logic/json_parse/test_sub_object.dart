import 'package:hello/home/logic/json_parse/json_parse_interface.dart';

class TestSubObject with JsonParseInterface {
  final int index;
  final String id;

  TestSubObject({
    this.index,
    this.id,
  });
//  _TestSubObject.map({
//    this.index,
//    this.id,
//  });

//  _TestSubObject.json(Object key, Object value): super();

//  static _TestSubObject fromObj2(Map map) {
//    if (map != null) {
//      try {
//        return _TestSubObject.map(
//          index: map['index'],
//          id: map['id'],
//        );
//      } catch (e) {
//        print('解析_TestSubObject失败: $e, $map');
//        return null;
//      }
//    }
//    return null;
//  }

  TestSubObject generateObj(dynamic obj) {
    Map map;
    if (obj is Map) {
      map = obj;
    } else if (obj is String) {
      map = stringToMap(obj);
    }
    if (map != null) {
      try {
        return TestSubObject(
          index: map['index'] as int,
          id: map['id'] as String,
        );
      } catch (e) {
        print('解析TestSubObject失败: $e, $map');
        return null;
      }
    }
    return null;
  }

  /// encoder 定义的解析函数
  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'id': id,
    };
  }

  static reviver(Object key, Object value) {
//    return _TestSubObject(key.toString(), value);
    return null;
  }

  @override
  String toString() {
    return 'TestSubObject{index: $index, id: $id}';
  }
}
