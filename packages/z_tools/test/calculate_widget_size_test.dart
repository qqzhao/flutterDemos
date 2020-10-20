import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:z_tools/z_tools.dart';

void main() {
  /// test failed:
  /// 可能原因：[cause](https://github.com/flutter/flutter/issues/24166)
  testWidgets('calc Container size', (WidgetTester tester) async {
    var tapKey = Key('tap');
    await tester.runAsync(() async {
      await tester.pumpWidget(CalculateWidgetAppContainer(
        child: Container(
          width: 600,
          height: 600,
          child: GestureDetector(
            onTap: () async {
              Widget widget1 = Container(
                width: 200,
                height: 100,
              );
              Size size1 = await getWidgetSize(widget1);
              print('size1 = $size1');
              expect(size1, Size(200.0, 100.0));
            },
            key: tapKey,
          ),
        ),
      ));
      // await tester.pump(Duration(seconds: 5));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      tester.tap(find.byKey(tapKey));
      await Future.delayed(Duration(seconds: 5));
    });
  });
}
