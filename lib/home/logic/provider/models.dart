import 'package:flutter/cupertino.dart';

class Counter with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class NetworkData with ChangeNotifier {
  Map<String, dynamic> _data = {
    'name': '',
    'title': '',
    'list': [],
  };
  Map get data => _data;

  void request() async {
    print('NetworkData request');
    await Future.delayed(Duration(seconds: 3));
    _data = {
      'title': _data['title'] + '111_',
      'name': _data['name'] + '222_',
      'list': [111, 222, 333, 'aaa'],
    };
//    notifyListeners();
  }
}

class MyIntValue {
  final int value2;
  MyIntValue({this.value2});
}
