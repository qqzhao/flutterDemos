import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adds one to input values', () async {
    print('1111');
    await Future.delayed(Duration(seconds: 3));
    print('2222');
  });

  testWidgets('calc Container size', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(Container(
        child: TestOne(),
      ));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await Future.delayed(Duration(seconds: 5));
    });
  });
}

class TestOne extends StatefulWidget {
  @override
  _TestOneState createState() => _TestOneState();
}

class _TestOneState extends State<TestOne> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      setState(() {
        counter = 2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text('$counter'),
    );
  }
}
