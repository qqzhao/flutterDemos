import 'package:hello/home/logic/json_parse/json_parse_interface.dart';
import 'package:hello/home/logic/json_parse/test_object.dart';

class TestObjectWrap with JsonParseInterface {
  final List<TestObject> testObjectList;
  TestObjectWrap({
    this.testObjectList,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'testObjectList': testObjectList,
    };
  }

  @override
  JsonParseInterface generateObj(inputObj) {
    Map map;
    if (inputObj is Map) {
      map = inputObj;
    } else if (inputObj is String) {
      map = stringToMap(inputObj);
    }

    if (map is Map) {
      try {
        return TestObjectWrap(testObjectList: convertList<TestObject>(map['testObjectList'], TestObject()));
      } catch (e) {
        print('解析TestObjectWrap 失败');
        return null;
      }
    }
    return null;
  }
}
