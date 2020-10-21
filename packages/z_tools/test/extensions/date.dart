import 'package:flutter_test/flutter_test.dart';
import 'package:z_tools/z_tools.dart';

void main() {
  test('isToday & isTomorrow', () async {
    DateTime data = DateTime.now();
    expect(data.isToday, true);

    expect(data.add(Duration(days: 1)).isTomorrow, true);
    expect(data.add(Duration(days: 2)).isTomorrow, false);
    expect(data.subtract(Duration(days: 1)).isToday, false);
  });
}
