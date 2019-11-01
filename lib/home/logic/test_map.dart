import 'package:flutter/material.dart';

class TestMapPage extends StatefulWidget {
  @override
  _TestMapPageState createState() => _TestMapPageState();
}

class _TestMapPageState extends State<TestMapPage> {
  Map<String, String> testMap = {'key1': 'value1'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test map'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                /// putIfAbsent 的用法， 存在的时候不更新
                print('test1');
                Map<String, String> map1 = {};
                map1.putIfAbsent('key1', () => 'test1');
                print('value = ${map1['key1']}');

                map1.putIfAbsent('key1', () => 'testAnother');
                print('value = ${map1['key1']}');
              },
              child: Text('test1'),
            ),
            FlatButton(
              onPressed: () {
                /// update 的用法
                print('test2');
                Map<String, String> map1 = {};
                map1.putIfAbsent('key1', () => 'test1');
                print('value = ${map1['key1']}');

                map1.update('key1', (last) => 'testAnother', ifAbsent: () => 'testAnotherExcep');
                print('value = ${map1['key1']}');

                map1.update('key2', (last) => 'testAnother2', ifAbsent: () => 'testAnotherExcep2');
                print('value = ${map1['key2']}');
              },
              child: Text('test2'),
            ),
            FlatButton(
              onPressed: () {
                /// 直接这样赋值会生效
                print('test3');
                Map<String, String> map1 = {};
                map1.putIfAbsent('key1', () => 'test1');
                print('value = ${map1['key1']}');

                map1['key1'] = 'testAnother';
                print('value = ${map1['key1']}');
              },
              child: Text('test3'),
            ),
            FlatButton(
              onPressed: () {
                /// 说明指针，浅拷贝
                print('test4');
                Map<String, String> map1 = {'key1': 'value1', 'key2': 'value2'};

                Map map2 = map1;
                map2.putIfAbsent('key3', () => 'value3');
                print('map2 = $map2');

                print('map1 = $map1');

                map2.putIfAbsent('key3', () => 'value3Another');
                print('map1 = $map1');
                print('map2 = $map2');
              },
              child: Text('test4'),
            ),
            FlatButton(
              onPressed: () {
                /// 说明指针，浅拷贝
                print('test5');
                Map<String, String> map2 = testMap;

                map2['key2'] = 'value2';
                print('map2 = $map2');
                print('testMap = $testMap');
              },
              child: Text('test5'),
            ),
            FlatButton(
              onPressed: () {
                /// from 函数是深拷贝
                print('test6');
                Map<String, String> map2 = Map.from(testMap);

                map2['key2'] = 'value2';
                print('map2 = $map2');
                print('testMap = $testMap');
              },
              child: Text('test6'),
            ),
          ],
        ),
      ),
    );
  }
}
