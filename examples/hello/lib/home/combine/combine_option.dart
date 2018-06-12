import 'package:flutter/material.dart';
import '../options.dart';
import 'dialog.dart';
import 'popview.dart';
import 'loading.dart';
import 'pop_drag_view.dart';


List<HomeOption> getCombineOptionList() {
  return [
    HomeOption(name: 'AAA', route: new Text('aaa')),
    HomeOption(name: 'Dialog', route: new DialogPage()),
    HomeOption(name: 'PopView', route: new PopViewPage()),
    HomeOption(name: 'PopDragView', route: new PopViewPage()),
    HomeOption(name: 'Loading', route: new LoadingPage()),
  ];
}