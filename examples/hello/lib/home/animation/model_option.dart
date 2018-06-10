import 'package:flutter/material.dart';
import '../options.dart';
import './animation.dart';
import './animation2.dart';
import './animation3.dart';
import './animation4.dart';
import './animation5.dart';
import './animation6.dart';
import './animation7.dart';
import './json.dart';


List<HomeOption> getCombineOptionList() {
  return [
    HomeOption(name: 'animation', route: new AnimationPage()),
    HomeOption(name: 'animation2', route: new AnimatePage2()),
    HomeOption(name: 'animation3', route: new AnimatePage3()),
    HomeOption(name: 'animation4', route: new AnimatePage4()),
    HomeOption(name: 'animation5', route: new AnimatePage5()),
    HomeOption(name: 'animation6', route: new AnimatePage6()),
    HomeOption(name: 'animation7', route: new AnimatePage7()),
  ];
}