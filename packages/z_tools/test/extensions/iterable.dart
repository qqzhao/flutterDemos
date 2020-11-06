import 'package:flutter_test/flutter_test.dart';
import 'package:z_tools/z_tools.dart';

void main() {
  test('min & max', () async {
    var min = [1, 2, 3, 4, 5].min;
    var max = [1, 2, 3, 4, 5].max;
    expect(min, 1);
    expect(max, 5);
  });

  test('safeFirst & safeLast', () async {
    List<String> emptyList = [];
    expect(emptyList.safeFirst, null);
    expect(emptyList.safeLast, null);
  });

  test('forEachWithIndex', () async {
    List<String> list = ['value1', 'value2', 'value3'];
    List<String> newList = [];
    list.forEachWithIndex((element, index) => newList.add('${element}_$index'));
    print('newList = $newList');
    expect(newList[0], 'value1_0');
    expect(newList[2], 'value3_2');
  });

  test('mapWithIndex', () async {
    List<String> list = ['value1', 'value2', 'value3'];
    List<String> newList = list.mapWithIndex((element, index) => '${element}_${index}').toList();
    print('newList = $newList');
    expect(newList[0], 'value1_0');
    expect(newList[2], 'value3_2');
  });
}
