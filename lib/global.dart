import 'package:flutter/material.dart';

GlobalKey<NavigatorState> _globalKey = new GlobalKey<NavigatorState>(); // private

GlobalKey<NavigatorState> get globalKey => _globalKey;
