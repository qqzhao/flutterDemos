import 'package:flutter/material.dart';

class CustomNavObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
//    print('didPop');
    //test
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('didRemove');
  }

  /// The [Navigator] replaced `oldRoute` with `newRoute`.
  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {}

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
//    print('didStartUserGesture');
  }

  @override
  void didStopUserGesture() {
//    print('didStopUserGesture');
    testNullSafety();
    testNoNullSafety();
  }
}

void testNullSafety() {
  double? a = 0;
  a = null;
  print('test null safety close = $a');
}

void testNoNullSafety() {
  // double a = 0;
  // if (a != null) {
  //   print('xxx');
  // }
}
