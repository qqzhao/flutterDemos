import 'package:flutter/material.dart';

class CustomNavObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
//    print('didPush');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
//    print('didPop');
  }

  /// The [Navigator] removed `route`.
  ///
  /// If only one route is being removed, then the route immediately below
  /// that one, if any, is `previousRoute`.
  ///
  /// If multiple routes are being removed, then the route below the
  /// bottommost route being removed, if any, is `previousRoute`, and this
  /// method will be called once for each removed route, from the topmost route
  /// to the bottommost route.
  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('didRemove');
  }

  /// The [Navigator] replaced `oldRoute` with `newRoute`.
  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {}

//  @override
//  void didStartUserGesture() {
////    print('didStartUserGesture');
//  }

  @override
  void didStopUserGesture() {
//    print('didStopUserGesture');
  }
}
