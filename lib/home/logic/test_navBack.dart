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
            var res = await Navigator.of(context).push(MaterialPageRoute<String>(builder: (context) {
              return TestBavBPage();
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

class _TestBavBPageState extends State<TestBavBPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('B page'),
      ),
      body: FlatButton(
          onPressed: () {
            print('pop TestBavBPage');
//            Navigator.of(context).pop('return string');
            /// 不加任何东西，发生下面的异常。
            /// global exception: obj = type 'MaterialPageRoute<dynamic>' is not a subtype of type 'Route<String>';
            Navigator.of(context).maybePop('maybe return string');
          },
          child: new Container(
            width: 100.0,
            height: 100.0,
            color: Colors.blue[200],
          )),
    );
  }
}
