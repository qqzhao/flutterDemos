import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new Center(
      child: scaff,
    ),
  ));
}

var scaff = new Scaffold(
  appBar: new AppBar(
    title: new Text('Test Dropdown button'),
    centerTitle: true,
  ),
  body: new Home(),
);

Widget dropdownButton = new DropdownButton(
    items: [
      new DropdownMenuItem(
          child: new Align(
        child: new Text('111'),
      )),
      new DropdownMenuItem(child: new Text(' jfdsk fsajkf af222')),
      new DropdownMenuItem(child: new Text('333')),
    ],
    onChanged: (item) {
      print('onChanged,$item');
    });

Widget popMenu = new PopupMenuButton<String>(
    padding: EdgeInsets.zero,
    onSelected: (String str) {
      print('onSelect =  $str');
    },
    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          new PopupMenuItem<String>(
              value: 'Menu item value one',
              child: const Text('Context menu item one')),
          const PopupMenuItem<String>(
              enabled: false, child: const Text('A disabled menu item')),
          // new PopupMenuDivider(),
          new PopupMenuItem<String>(
              value: 'Menu item value Three',
              child: const Text('Context menu item three')),
        ]);

Widget popMenu2 = new PopupMenuButton<String>(
    padding: EdgeInsets.zero,
    onSelected: (String str) {
      print('onSelect =  $str');
    },
    child: new Text('aaaa'),
    initialValue: 'aaaa',
    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          new PopupMenuItem<String>(
              value: 'Menu item value one2',
              child: const Text('Context menu item one2')),
          const PopupMenuItem<String>(
              enabled: false, child: const Text('A disabled menu item')),
          // new PopupMenuDivider(
          //   height: 16.0,
          // ),
          new PopupMenuItem<String>(
              value: 'Menu item value Three',
              child: const Text('Context menu item three')),
        ]);

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(10.0),
            border: new Border.all(
              color: Color(0xffff0000),
              width: 2.0,
            ),
            color: Colors.green,
          ),
          height: 50.0,
          margin: new EdgeInsets.all(20.0),
          padding: new EdgeInsets.all(5.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text('三年级'),
              popMenu2,
            ],
          ),
        ),
        new Container(
          alignment: Alignment.topCenter,
          width: 300.0,
          height: 100.0,
          child: new ListView.builder(
            itemCount: 3,
            itemBuilder: (_, index) {
              if (index == 2){
                var c = new PopupMenuButton<String>(
                    padding: EdgeInsets.zero,
                    initialValue: 'aaa',
                    onSelected: null,
                    child: new ListTile(
                        title: const Text('An item with a simple menu'),
                        subtitle: new Text('aaa')
                    ),
                    itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                      new PopupMenuItem<String>(
                          value: 'aaa',
                          child: new Text('aaa')
                      ),
                      new PopupMenuItem<String>(
                          value: 'bbb',
                          child: new Text('bbb')
                      ),
                      new PopupMenuItem<String>(
                          value: 'ccc',
                          child: new Text('ccc')
                      )
                    ]
                );
                return c;
              }
              return new Text('index = $index');

            }),
        )
      ],
    );
  }
}
