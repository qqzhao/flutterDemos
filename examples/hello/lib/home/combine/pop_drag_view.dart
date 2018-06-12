import 'package:flutter/material.dart';

import '../../components/popview.dart';

class PopDragViewPage extends StatefulWidget {
  @override
  _PopDragViewPageState createState() => _PopDragViewPageState();
}

class _PopDragViewPageState extends State<PopDragViewPage> {

  double toBottom = 0.0;
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
            print('123494390');
            var child = new GestureDetector(
              onTap:(){
                print('aamma');
              },
              onLongPress: (){
                print('long press');
              },
              onVerticalDragStart: (DragStartDetails details){
                print('beigin = $details');
              },
              onVerticalDragUpdate: (DragUpdateDetails details){
                print('update = $details');
              },
              onVerticalDragEnd: (DragEndDetails details){
                print('end = $details');
              },
              child: new Container(
                margin: new EdgeInsets.only(bottom: toBottom),
                child: new Text('aa'),
                width: MediaQuery.of(context).size.width,
                height: 150.0,
                color: Colors.blue,
              ),
            );
            var ret = await showPopView(context: context, child: child);
            print('ret = $ret');
          },
          child: new Center(
            child: new Text('click me'),
          ),
        ),
      ),
    );
  }
}