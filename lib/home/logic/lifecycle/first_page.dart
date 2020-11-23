import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hello/home/logic/lifecycle/second_page.dart';

class FirstTestPage extends StatefulWidget {
  @override
  _FirstTestPageState createState() => _FirstTestPageState();
}

class _FirstTestPageState extends State<FirstTestPage> {
  @override
  Widget build(BuildContext context) {
    _log('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('FirstTestPage'),
      ),
      body: Container(
        child: Center(
          child: SizedBox(
            width: 100.0,
            height: 200.0,
            child: _InnerBox(),
          ),
        ),
      ),
      floatingActionButton: FlatButton.icon(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondTestPage()));
          },
          icon: Icon(Icons.add),
          label: Text('')),
    );
  }

  void _log(String str) {
    print('first : $str');
  }

  @override
  void didChangeDependencies() {
    _log('didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _log('dispose');
    super.dispose();
  }

  @override
  void deactivate() {
    _log('deactivate');
    super.deactivate();
  }

  @override
  void didUpdateWidget(FirstTestPage oldWidget) {
    _log('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    _log('initState');
    Timer.periodic(Duration(seconds: 3), (_) {
      print('contextInsecond = $contextInSecond');
//      Element ele = contextInSecond;
//      assert(contextInSecond == stateInSecond.context, 'exception aaa');
      if (stateInSecond != null && stateInSecond.mounted) {
        print('contextInsecond2 = ${MediaQuery.of(contextInSecond).size.height}');
        print('contextInsecond3 = ${contextInSecond.size}');
      } else {
        print('stateInSecond.mounted is false');
      }
    });
  }
}

class _InnerBox extends StatefulWidget {
  @override
  __InnerBoxState createState() => __InnerBoxState();
}

class __InnerBoxState extends State<_InnerBox> {
  Color innerColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    _log('build');
    return Container(
      color: innerColor,
    );
  }

  void _log(String str) {
    print('_InnerBox : $str');
  }

  @override
  void didChangeDependencies() {
    _log('didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _log('dispose');
    super.dispose();
  }

  @override
  void deactivate() {
    _log('deactivate');
    // 这里可以将状态恢复
    innerColor = Colors.blue;
    super.deactivate();
  }

  @override
  void didUpdateWidget(_InnerBox oldWidget) {
    _log('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    _log('initState');
    Timer(Duration(milliseconds: 3000), () {
      /// 只有dispose 之后mounted 才为false。跳转到下一页面并不会使mounted 设置为true.
      if (mounted) {
        _log('timer setState');
        setState(() {
          innerColor = Colors.red;
        });
      } else {
        _log('timer not mounted');
      }
    });
  }
}
