import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  var app = Directionality(
    textDirection: TextDirection.ltr,
    child: Center(
      child: Container(
        width: 100,
        height: 100,
        color: Colors.yellow,
      ),
    ),
  );

  // ignore: invalid_use_of_protected_member
  WidgetsFlutterBinding.ensureInitialized().scheduleAttachRootWidget(app);
  return;
}
