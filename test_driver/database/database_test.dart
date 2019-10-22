import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Counter App', () {
//    final counterTextFinder = find.byValueKey('counter');
    final buttonFinder = find.byValueKey('button1');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('test1', () async {
      await driver.requestData('send message1');
    });

    test('test2', () async {
      // First, tap the button.
      await Future.delayed(Duration(seconds: 5));
      await driver.tap(buttonFinder);

      await Future.delayed(Duration(seconds: 60));
    }, timeout: Timeout(Duration(minutes: 10)));
  });
}
