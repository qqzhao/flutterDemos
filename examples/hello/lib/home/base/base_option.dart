import 'package:flutter/material.dart';
import '../options.dart';
import './textfield.dart';
import './listview.dart';


List<HomeOption> getBaseOptionList() {
  return [
    HomeOption(name: 'TestField', route: new TextFieldPage()),
    HomeOption(name: 'ListView1', route: new ListViewPage1()),
  ];
}