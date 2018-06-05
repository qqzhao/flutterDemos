import 'package:flutter/material.dart';
import '../options.dart';
import './dialog.dart';


List<HomeOption> getCombineOptionList() {
  return [
    HomeOption(name: 'AAA', route: new Text('aaa')),
    HomeOption(name: 'Dialog', route: new DialogPage()),
  ];
}