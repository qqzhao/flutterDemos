import 'package:flutter/material.dart';
import '../options.dart';
import './textfield.dart';
import './listview.dart';
import './future_builder.dart';
import './refresh_indicator.dart';
import './fractionally_sized_box.dart';


List<HomeOption> getBaseOptionList() {
  return [
    HomeOption(name: 'TestField', route: new TextFieldPage()),
    HomeOption(name: 'ListView1', route: new ListViewPage1()),
    HomeOption(name: 'Future Build', route: new FutureBuildPage()),
    HomeOption(name: 'Refresh Indicator', route: new RefreshIndicatorPage()),
    HomeOption(name: 'FractionallySizedBox', route: new FractionallBoxPage()),
  ];
}