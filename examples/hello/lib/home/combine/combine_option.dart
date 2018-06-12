import 'package:flutter/material.dart';
import '../options.dart';
import 'dialog.dart';
import 'popview.dart';


List<HomeOption> getCombineOptionList() {
  return [
    HomeOption(name: 'AAA', route: new Text('aaa')),
    HomeOption(name: 'Dialog', route: new DialogPage()),
    HomeOption(name: 'PopView2', route: new PopViewPage()),
  ];
}