import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello/home/logic/config_temp.dart';
import 'package:hello/home/logic/config_temp.dart' as config_a;
import 'package:hello/home/logic/config_temp.dart' as config_b;

import './config_temp.dart' as config_c;

class ImportTestPage extends StatefulWidget {
  @override
  _ImportTestPageState createState() => _ImportTestPageState();
}

class _ImportTestPageState extends State<ImportTestPage> {
  @override
  void initState() {
    super.initState();
    testImport();
  }

  void testImport() {
    print('testImport begin=============');
    print('origin = $testVar');
    config_a.testVar = 'modify by origin 123';
    print('origin = $testVar, configA = ${config_a.testVar}, configB = ${config_b.testVar}, configC = ${config_c.testVar}');
    print('configD = ${config_c.testVar}');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: CupertinoButton(child: Text('返回'), onPressed: () => Navigator.of(context).maybePop()),
      ),
    );
  }
}
