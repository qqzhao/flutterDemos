
import 'package:flutter/material.dart';

class MyRouter{
  MyRouter({this.name, this.widget});
  final String name;
  final Widget widget;
}

class MyRouterList{
  MyRouterList({this.lists, this.name});

  final List<MyRouter> lists;
  final String name;
}