import 'package:flutter_test/flutter_test.dart';
import 'package:z_tools/z_tools.dart';

void main() {
  test('removeNullValue', () async {
    Map map1 = {
      'Key1': 'Value1',
      'Key2': 222,
      'KeyNull1': null,
      'Key3': Object(),
      Object: null,
      111: null,
    };

    // var a = mapExt;
    expect(map1.keys.length, 6);
    map1.removeNullValues();
    expect(map1.keys.length, 3);
  });

  test('forceConvertMap: normal', () async {
    Map map1 = {
      'Key1': 'Value1',
      'Key2': 222,
      'KeyNull1': null,
      'Key3': Object(),
      Object: null,
      111: null,
    };

    var map2 = map1.forceConvertMap();
    print('map2 = $map2');
    expect(map2['111'], 'null');
    expect(map2['Object'], 'null');
  });

  test('forceConvertMap: duplicated key', () async {
    Map map1 = {'Key1': 'Value1', 111: '111-value1', '111': '111-value2'};

    var map2 = map1.forceConvertMap();
    print('map2 = $map2');
    expect(map2['111'], '111-value1');
  });

  test('forceConvertMap: duplicated key-2', () async {
    Map map1 = {'Key1': 'Value1', 111: '111-value1', '111': '111-value2'};

    var map2 = map1.forceConvertMap(useFirst: false);
    print('map2 = $map2');
    expect(map2['Key1'], 'Value1');
    expect(map2['111'], '111-value2');
  });
}
