import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() async {
  print('render main');
  var app = Directionality(
    textDirection: TextDirection.ltr,
    child: Center(
      child: Container(
        width: 100,
        height: 100,
        color: Colors.white,
      ),
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();

  var element = WidgetsBinding.instance.createBinaryMessenger();
//  WidgetsBinding.instance.scheduleAttachRootWidget(app);
//  WidgetsBinding.instance.scheduleWarmUpFrame();
}
