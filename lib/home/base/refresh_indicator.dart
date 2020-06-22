import 'dart:async';

import 'package:flutter/material.dart';

class RefreshIndicatorPage extends StatefulWidget {
  @override
  _RefreshIndicatorPageState createState() => new _RefreshIndicatorPageState();
}

class _RefreshIndicatorPageState extends State<RefreshIndicatorPage> {
  Future sleep1() {
    // 异步sleep，不会卡死界面
    return new Future.delayed(const Duration(seconds: 2), () => "1");
  }

  Future<String> _getString() async {
    await sleep1();
    print('_getString');
    return 'test111';
  }

  Future<void> _loadData() async {
//    await _getString();
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget futureBuild = new FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return new ListView(
            children: <Widget>[
              new Text('aaa'),
              new Text('bbb'),
              new Text(snapshot.data),
            ],
          );
        }
        return new Text('loading');
      },
      future: _getString(),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('refresh indicator'),
      ),
      body: new RefreshIndicator(child: futureBuild, onRefresh: _loadData),
    );
  }
}

/**
 * 问题: 如果有多个部分可以刷新，只是刷新某个，怎么做呢？ 套用子的有状态的Widget？
 */
