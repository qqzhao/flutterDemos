import 'package:flutter/material.dart';
import '../../components/popview.dart';

class PopViewPage extends StatefulWidget {
  @override
  _PopViewPageState createState() => _PopViewPageState();
}

class _PopViewPageState extends State<PopViewPage> {


  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Center(
        child: new GestureDetector(
          onTap: () async{
            print('123494390');
            var child = new GestureDetector(
              onTap:(){
                print('aaa');
              },
              child: new Container(
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
