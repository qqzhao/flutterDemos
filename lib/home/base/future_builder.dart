import 'dart:async';

import 'package:flutter/material.dart';

class FutureBuildPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future sleep1() {
      // 异步sleep，不会卡死界面
      return new Future.delayed(const Duration(seconds: 3), () => "1");
    }

    /// ignore: unused_element
    Future<String> _caculateText() async {
      await sleep1();
//      sleep(const Duration(seconds:10)); // 同步sleep，会卡死界面
      throw new Exception('error ===');
    }

    Future<String> _caculateText2() async {
      await sleep1();
//      sleep(const Duration(seconds:10));
      return 'Right result';
    }

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('FutureBuild'),
        ),
        body: new Column(
          children: <Widget>[
            new FlatButton(
                onPressed: () async {
                  print('refresh...');
                  _caculateText2();
                },
                child: new Container(
                  child: Text('Refresh'),
                  decoration: new BoxDecoration(
                      border: new Border.all(
                    color: Colors.purple,
                    width: 1.0,
                  )),
                )),
            new Container(
              child: new FutureBuilder<String>(
                  future: _caculateText2(),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    Text text = const Text('loading');
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        text = new Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        text = new Text('path: ${snapshot.data}');
                      } else {
                        text = const Text('path unavailable');
                      }
                    }
                    return new Padding(padding: const EdgeInsets.all(16.0), child: text);
                  }),
            ),
          ],
        ));
  }
}

/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////

class FutureBuildPage extends StatefulWidget {
  @override
  _FutureBuildPageState createState() => new _FutureBuildPageState();
}

class _FutureBuildPageState extends State<FutureBuildPage> {
  @override
  Widget build(BuildContext context) {
    Future sleep1() {
      // 异步sleep，不会卡死界面
      return new Future.delayed(const Duration(seconds: 3), () => "1");
    }

    /// ignore: unused_element
    Future<String> _calculateText() async {
      await sleep1();
//      sleep(const Duration(seconds:10)); // 同步sleep，会卡死界面
      throw new Exception('error ===');
    }

    Future<String> _caculateText2() async {
      await sleep1();
//      sleep(const Duration(seconds:10));
      print('_caculateText2');
      return 'Right result';
    }

    Future<void> _loadData() async {
//      await _caculateText2();
      setState(() {
        // 这里setStatus就可以刷新。
      });
//      await _caculateText2();
    }

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('FutureBuild'),
        ),
        body: new Column(
          children: <Widget>[
            new FlatButton(
                onPressed: () async {
                  print('refresh...');
                  _loadData();
                },
                child: new Container(
                  child: Text('Refresh'),
                  decoration: new BoxDecoration(
                      border: new Border.all(
                    color: Colors.purple,
                    width: 1.0,
                  )),
                )),
            new Container(
              child: new FutureBuilder<String>(
                  future: _caculateText2(),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    Text text = const Text('loading');
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        text = new Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        text = new Text('path: ${snapshot.data}');
                      } else {
                        text = const Text('path unavailable');
                      }
                    }
                    return new Padding(padding: const EdgeInsets.all(16.0), child: text);
                  }),
            ),
          ],
        ));
  }
}
