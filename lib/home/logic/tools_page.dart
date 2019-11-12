import 'package:flutter/material.dart';
import 'package:tools/map.dart';
import 'package:tools/src/time.dart';

class ToolsDebugPage extends StatefulWidget {
  @override
  _ToolsDebugPageState createState() => _ToolsDebugPageState();
}

class _ToolsDebugPageState extends State<ToolsDebugPage> {
  @override
  void initState() {
    testDuration();
    testMapJoin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('aa'),
      ),
      appBar: AppBar(
        title: Text('tools debug'),
      ),
    );
  }
}

void testMapJoin() {
  Map a = {'111': 'key1', '222': 'key2', '333': 333};
//  List<MapEntry> maps = a.entries.toList();
  print('a = ${join(a, separator: ';')}');
}

void testDuration() {
  TimeDurationTool.start('main');
  var cost = TimeDurationTool.stop('main');
  print('cost = $cost');
}
