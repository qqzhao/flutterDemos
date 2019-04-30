import 'dart:convert';

import 'package:flutter/material.dart';

class JsonParsePage extends StatefulWidget {
  @override
  _JsonParsePageState createState() => _JsonParsePageState();
}

class _JsonParsePageState extends State<JsonParsePage> {
  @override
  void initState() {
    super.initState();
    test();
//    test2();
  }

  void test2() {
    _TestSubObject subObject = _TestSubObject.map(index: 10, id: 'testId');
    var encoderStr = json.encode(subObject);
//    var subObject2 = json.decode(encoderStr, reviver: _TestSubObject.reviver);
    var subObject2 = _TestSubObject.fromObj(json.decode(encoderStr, reviver: null));
    print('edcoderStr = $encoderStr');
  }

  void test() {
//    _TestSubObject subObject = _TestSubObject(index: 10, id: 'testId');
    _TestSubObject subObject = _TestSubObject.map(id: 'testId');
    var encoderStr = json.encode(subObject.toMap());
    print('edcoderStr = $encoderStr');
    var map = json.decode(encoderStr);
    _TestSubObject subObject2 = _TestSubObject.fromObj(map);
    print('subObject2 = $subObject2');

    print('\n =============================');
    dynamic testStr = '123';
    _TestObject _testObject = _TestObject(
        index: 39,
        age: 100,
        map: {
          '123': testStr,
        },
        list: [
          '123fajk',
          '22',
//          11,
        ],
        subObject: subObject);
    encoderStr = json.encode(_testObject.toMap());
    print('edcoderStr = $encoderStr');
    map = json.decode(encoderStr);
    _TestObject _testObject2 = _TestObject.fromObj(map);
    print('_testSubObject2 = $_testObject2');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test json parse'),
      ),
      body: Container(),
    );
  }
}

class _TestObject {
  final int index;
  final String id;
  final num age;
  final Map<String, String> map;
  final List<String> list;
  final _TestSubObject subObject;

  _TestObject({
    this.index,
    this.id,
    this.age,
    this.map,
    this.list,
    this.subObject,
  });

  static _TestObject fromObj(Map map) {
    if (map != null) {
      return _TestObject(
        index: map['index'],
        id: map['id'],
        age: map['age'],
        map: map['map']?.cast<String, String>(),
        list: map['list']?.cast<String>(),
        subObject: _TestSubObject.fromObj(map['subObject']),
      );
    }
    return null;
  }

  Map<String, dynamic> toMap() {
    try {
      return {
        'index': index,
        'id': id,
        'age': age,
        'map': map,
        'list': list,
        'subObject': subObject.toMap(),
      };
    } catch (e) {
      print('解析 _TestObject失败: $e, $map');
      return null;
    }
  }

  @override
  String toString() {
    return '_TestObject{index: $index, id: $id, age: $age, map: $map, list: $list, subObject: $subObject}';
  }
}

class _TestSubObject {
  final int index;
  final String id;

  _TestSubObject.map({
    this.index,
    this.id,
  });

//  _TestSubObject.json(Object key, Object value): super();

  static _TestSubObject fromObj(Map map) {
    if (map != null) {
      try {
        return _TestSubObject.map(
          index: map['index'],
          id: map['id'],
        );
      } catch (e) {
        print('解析_TestSubObject失败: $e, $map');
        return null;
      }
    }
    return null;
  }

  Map<String, dynamic> toMap() {
    return {
      'index': index,
      'id': id,
    };
  }

  /// encoder 定义的解析函数
  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'id': id,
    };
  }

  static reviver(Object key, Object value) {
//    return _TestSubObject(key.toString(), value);
    return null;
  }

  @override
  String toString() {
    return '_TestSubObject{index: $index, id: $id}';
  }
}
