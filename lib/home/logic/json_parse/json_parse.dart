import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello/home/logic/json_parse/json_parse_interface.dart';
import 'package:hello/home/logic/json_parse/test_object.dart';
import 'package:hello/home/logic/json_parse/test_object_wrap.dart';
import 'package:hello/home/logic/json_parse/test_sub_object.dart';

class JsonParsePage extends StatefulWidget {
  @override
  _JsonParsePageState createState() => _JsonParsePageState();
}

class _JsonParsePageState extends State<JsonParsePage> {
  @override
  void initState() {
    super.initState();
    test4();
//    test2();
  }

  void test3() {
    JsonParseInterface subObject = TestSubObject(index: 10, id: 'testId');
    var encoderStr = subObject.jsonString();
    var subObject2 = TestSubObject().generateObj(encoderStr);
    print('encoderStr = $encoderStr, subObject2 = $subObject2');
  }

  void test2() {
    TestSubObject subObject = TestSubObject(index: 10, id: 'testId');
    var encoderStr = json.encode(subObject);
//    var subObject2 = json.decode(encoderStr, reviver: TestSubObject.reviver);
    var subObject2 = TestSubObject().generateObj(json.decode(encoderStr, reviver: null));
    print('encoderStr = $encoderStr, subObject2 = $subObject2');
  }

  void test() {
//    TestSubObject subObject = TestSubObject(index: 10, id: 'testId');
    TestSubObject subObject = TestSubObject(id: 'testId');
    var encoderStr = json.encode(subObject.toJson());
    print('edcoderStr = $encoderStr');
    var map = json.decode(encoderStr);
    TestSubObject subObject2 = TestSubObject().generateObj(map);
    print('subObject2 = $subObject2');

    print('\n =============================');
    dynamic testStr = '123';
    TestObject _testObject = TestObject(
      index: 39,
      age: 100,
      map: {
        '123': testStr.toString(),
      },
      list: [
        '123fajk',
        '22',
//          11,
      ],
      subObject: subObject,
    );
    encoderStr = json.encode(_testObject.toJson());
    print('edcoderStr = $encoderStr');
    map = json.decode(encoderStr);
    TestObject _testObject2 = TestObject().generateObj(map);
    print('_testSubObject2 = $_testObject2');
  }

  void test4() {
    TestSubObject subObject1 = TestSubObject(id: 'testId1', index: 10);
    TestSubObject subObject2 = TestSubObject(id: 'testId2', index: 99);
    TestSubObject subObject3 = TestSubObject(id: 'testId3');
    TestSubObject subObject4 = TestSubObject(id: 'testId4');
    TestObject _testObject = TestObject(
      index: 39,
      age: 100,
      list: [
        '123fajk',
        '22',
      ],
      subObject: subObject1,
      subObjectList: [subObject2, subObject3, subObject4],
      subObjectMap: {'key1': subObject1, 'key2': subObject2},
    );
    var str = _testObject.jsonString();
    var _testObjectDecoder = TestObject().generateObj(str);
    print('_testObjectDecoder = $_testObjectDecoder');

    TestObjectWrap objectWrap = TestObjectWrap(testObjectList: [_testObject]);
    var str2 = objectWrap.jsonString();
    var _testObjectWrap = TestObjectWrap().generateObj(str2);
    print('_testObjectWrap = $_testObjectWrap');
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
