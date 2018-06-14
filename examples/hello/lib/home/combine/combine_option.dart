import 'package:flutter/material.dart';
import '../options.dart';
import 'dialog.dart';
import 'popview.dart';
import 'loading.dart';
import 'pop_drag_view.dart';
import 'video_demo.dart';
import 'bottomSheet.dart';


List<HomeOption> getCombineOptionList() {
  return [
    HomeOption(name: 'AAA', route: new Text('aaa')),
    HomeOption(name: 'Dialog', route: new DialogPage()),
    HomeOption(name: 'PopView', route: new PopViewPage()),
    HomeOption(name: 'PopDragView', route: new PopDragViewPage()),
    HomeOption(name: 'Loading', route: new LoadingPage()),//VideoDemo
    HomeOption(name: 'VideoDemo', route: new VideoDemo()),
    HomeOption(name: 'BottomSheet', route: new BottomSheetPage()),
  ];
}