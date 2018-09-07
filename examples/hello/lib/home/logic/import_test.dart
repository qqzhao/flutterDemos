import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hello/home/logic/config_temp.dart';
import 'package:hello/home/logic/config_temp.dart' as configA;
import 'package:hello/home/logic/config_temp.dart' as configB;

import 'config_temp.dart' as configC;
import './config_temp.dart' as configD;

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

  void testImport(){
    print('testImport begin=============');
    print('origin = $testVar');
    configA.testVar = 'modify by origin 123';
    print('origin = $testVar, configA = ${configA.testVar}, configB = ${configB.testVar}, configC = ${configC.testVar}');
    print('configD = ${configD.testVar}');
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

