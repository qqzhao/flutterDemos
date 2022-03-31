// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class _DialogRoute<T> extends PopupRoute<T> {
  _DialogRoute({
    bool barrierDismissible = true,
    this.barrierLabel,
    @required this.child,
    RouteSettings? settings,
  })  : _barrierDismissible = barrierDismissible,
        super(settings: settings);

  final Widget? child;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 450);

  @override
  bool get barrierDismissible => _barrierDismissible;
  final bool _barrierDismissible;

  @override
  Color get barrierColor => const Color(0x5f000000); // 这里透明处理

  @override
  final String? barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return new SafeArea(
      child: new Builder(builder: (BuildContext context) {
        final Widget annotatedChild = new Semantics(
          child: child,
          scopesRoute: true,
          explicitChildNodes: true,
        );
        return annotatedChild;
      }),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return new FadeTransition(opacity: new CurvedAnimation(parent: animation, curve: Curves.easeOut), child: child);
  }
}

bool _isShowing = false; // 标识是否展示loading

Future<T?> showLoading<T>({
  @required BuildContext? context,
  bool barrierDismissible = false,
//  WidgetBuilder builder,
}) async {
  if (_isShowing) {
    return null;
  }
  _isShowing = true;
  return Navigator.of(context!, rootNavigator: true).push(new _DialogRoute<T>(
    child: new Center(
      child: new SizedBox(
        width: 35.0,
        height: 35.0,
        child: new CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
      ),
    ),
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
  ));
}

void hideLoading<T>({
  BuildContext? context,
}) {
  if (_isShowing) {
    Navigator.of(context!).maybePop();
  }
  _isShowing = false;
}
