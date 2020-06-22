import 'package:flutter/material.dart';

class TestNavBackPage extends StatefulWidget {
  @override
  _TestNavBackPageState createState() => _TestNavBackPageState();
}

class _TestNavBackPageState extends State<TestNavBackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A page'),
      ),
      body: FlatButton(
          onPressed: () async {
            print('push TestBavBPage');

            /// 配合这里 <String>， 才能使返回值有效。
//            var res = await Navigator.of(context).push(MaterialPageRoute<String>(builder: (context) {
//              return TestBavBPage();
//            }));
//            print('res = $res');

            var res = await Navigator.of(context).push(MaterialPageRoute<String>(builder: (context) {
              return WillPopScope(
                  child: TestBavBPage(),
                  onWillPop: () {
                    /// 影响maybePop（包括Android物理返回键）
                    return Future.value(true);
                  });
            }));
            print('res = $res');
          },
          child: new Container(
            width: 100.0,
            height: 100.0,
            color: Colors.blue[200],
          )),
    );
  }
}

class TestBavBPage extends StatefulWidget {
  @override
  _TestBavBPageState createState() => _TestBavBPageState();
}

void _popAction({BuildContext context}) {
  print('pop TestBavBPage');

//  /// 不受WillPopScope 返回值影响。相当于强制退出。maybePop 会受到WillPopScope的影响。物理返回键相当于调用Maybe的方法。
//  Navigator.of(context).pop('return string');

  /// 不加任何东西，发生下面的异常。
  /// global exception: obj = type 'MaterialPageRoute<dynamic>' is not a subtype of type 'Route<String>';
  Navigator.of(context).maybePop('maybe return string');
}

class _TestBavBPageState extends State<TestBavBPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('B page'),
        leading: FlatButton(
            onPressed: () {
              _popAction(context: context);
            },
            child: new Container(
              width: 40.0,
              height: 40.0,
              color: Colors.purple[200],
            )),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                _popAction(context: context);
              },
              child: new Container(
                width: 40.0,
                height: 40.0,
                color: Colors.blue[200],
              )),
        ],
      ),
      body: FlatButton(
          onPressed: () {
            _popAction(context: context);
          },
          child: new Container(
            width: 100.0,
            height: 100.0,
            color: Colors.blue[200],
          )),
    );
  }
}
