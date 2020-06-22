import 'package:flutter/material.dart';
import 'package:hello/components/listview.dart';

class ListViewPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('listView1'),
        ),
        body: new Container(
            child: new Column(
          children: <Widget>[
            new Text('Header'),
            new Expanded(
              child: new MyListView.builder(
                header: new Container(
                  padding: new EdgeInsets.symmetric(vertical: 10.0),
                  child: new Text('Header222'),
                ),
                bottom: new Text('Bottom333'),
                itemBuilder: (context, index) {
                  return Text('index = $index');
                },
                itemCount: 10,
              ),
            ),
            new Text('Bottom'),
          ],
        )),
      ),
    );
  }
}
