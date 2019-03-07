import 'package:flutter/material.dart';

class BoxTestPage extends StatefulWidget {
  @override
  _BoxTestPageState createState() => _BoxTestPageState();
}

class _BoxTestPageState extends State<BoxTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test box'),
      ),
      body: Test2View(),
    );
  }
}

class Test1View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
//        width: double.infinity,
//        height: double.infinity,
      color: Colors.red,
      child: Center(
        widthFactor: 1.0,
        heightFactor: 6.0,
        child: LayoutBuilder(builder: (context, constraint) {
          print('constraint: ${constraint.maxHeight}--${constraint.maxWidth}');
          print('constraint: ${constraint.minHeight}--${constraint.minWidth}');
          return Text(
            'aa',
            style: TextStyle(fontSize: 100.0),
          );
        }),
      ),
    );
  }
}

class Test2View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(minHeight: 40.0, minWidth: 200.0, maxHeight: 200.0, maxWidth: 200.0),
            color: Colors.red,
            child: Text('aa\nfdask\nfdsak\nfsak\n'),
          ),
          Container(
            color: Colors.blue,
            constraints: BoxConstraints(minHeight: 80.0, minWidth: 200.0, maxHeight: 200.0, maxWidth: 200.0),
          ),
        ],
      ),
    );
  }
}
