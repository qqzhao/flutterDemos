import 'package:hello/home/logic/json_parse/json_parse_interface.dart';
import 'package:hello/home/logic/json_parse/test_sub_object.dart';

class TestObject with JsonParseInterface {
  final int index;
  final String id;
  final num age;
  final Map<String, String> map;
  final List<String> list;
  final TestSubObject subObject;
  final List<TestSubObject> subObjectList;
  final Map<String, TestSubObject> subObjectMap;

  TestObject({
    this.index,
    this.id,
    this.age,
    this.map,
    this.list,
    this.subObject,
    this.subObjectList,
    this.subObjectMap,
  });

  @override
  TestObject generateObj(dynamic obj) {
    Map map;
    if (obj is Map) {
      map = obj;
    } else if (obj is String) {
      map = stringToMap(obj);
    }
    if (map != null) {
      try {
        return TestObject(
          index: map['index'] as int,
          id: map['id'] as String,
          age: map['age'] as int,
          map: map['map']?.cast<String, String>() as Map<String, String>,
          list: map['list']?.cast<String>() as List<String>,
          subObject: TestSubObject().generateObj(map['subObject']),
          subObjectList: convertList<TestSubObject>(map['subObjectList'], TestSubObject()),
          subObjectMap: convertMap<TestSubObject>(map['subObjectMap']),
        );
      } catch (e) {
        print('解析TestObject失败: $e, $map');
        return null;
      }
    }
    return null;
  }

  @override
  Map<String, dynamic> toJson() {
    try {
      return {
        'index': index,
        'id': id,
        'age': age,
        'map': map,
        'list': list,
        'subObject': subObject.toJson(),
        'subObjectList': subObjectList,
        'subObjectMap': subObjectMap,
      };
    } catch (e) {
      print('解析 _TestObject失败: $e, $map');
      return null;
    }
  }

  @override
  String toString() {
    return '_TestObject{index: $index, id: $id, age: $age, map: $map, list: $list, subObject: $subObject}';
  }
}
