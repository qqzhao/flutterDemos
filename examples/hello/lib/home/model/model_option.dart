import 'package:flutter/material.dart';
import '../options.dart';
import './json.dart';


List<HomeOption> getCombineOptionList() {
  return [
    HomeOption(name: 'AAA', route: new Text('aaa')),
    HomeOption(name: 'json', route: new JsonTestPage()),
  ];
}