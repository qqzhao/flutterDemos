import 'package:flutter_test/flutter_test.dart';
import 'package:z_tools/z_tools.dart';

void main() {
  test('min & max', () async {
    var min = [1, 2, 3, 4, 5].min;
    var max = [1, 2, 3, 4, 5].max;
    expect(min, 1);
    expect(max, 5);
  });
}
