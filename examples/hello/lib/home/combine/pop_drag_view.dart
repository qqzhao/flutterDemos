import 'package:flutter/material.dart';

import '../../components/popview.dart';

class PopDragViewPage extends StatefulWidget {
  @override
  _PopDragViewPageState createState() => _PopDragViewPageState();
}

class _PopDragViewPageState extends State<PopDragViewPage> {

  double toBottom = 200.0;
  double height = 200.0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Center(
        child: new GestureDetector(
          onTap: () async{
            print('1234943901');
            var child = new GestureDetector(
              onVerticalDragStart: (DragStartDetails details){
                print('beigin = $details');
              },
              onVerticalDragUpdate: (DragUpdateDetails details){
//                print('update = ${details.delta}');
                num value = -details.delta.dy;
                print('value = $value');
//                height = height + value;
                setState(() {
                  height = height + value;
                });
              },
              onVerticalDragEnd: (DragEndDetails details){
                print('end = $details');
              },
              child: new Container(
//                margin: new EdgeInsets.only(bottom: toBottom),
                child: new Text('aa3'),
                width: MediaQuery.of(context).size.width,
                height: height,
                color: Colors.blue,
              )
            );
            var ret = await showPopView(context: context, child: child);
            print('ret = $ret');
          },
          child: new Center(
            child: new Text('click me $height'),
          ),
        ),
      ),
    );
  }
}