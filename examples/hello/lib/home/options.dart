import 'package:flutter/material.dart';
import './base/base.dart';
import './combine/combine.dart';
import './model/model.dart';


class HomeOption{

  HomeOption({
    this.name,
    this.description = '',
    this.route
  });

  String name;
  String description;
  Widget route;
}

List<HomeOption> getAllOptionList() {
  return [
    HomeOption(name: 'Base', route: new BasePage()),
    HomeOption(name: 'Combine', route: new CombinePage()),
    HomeOption(name: 'Layout'),
    HomeOption(name: 'Render'),
    HomeOption(name: 'Model', route: new ModelPage()),
  ];
}