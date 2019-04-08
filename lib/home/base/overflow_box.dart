import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///嵌套OverflowBox可以生效，但是需要设定maxWidth
class OverFlowBoxPage extends StatelessWidget {
  Widget _getTest1() {
    return new Container(
      width: 250.0,
      color: Colors.green,
      child: new Center(
        child: new Container(
          width: 200.0,
          height: 200.0,
          color: Colors.purple,
          child: new Align(
            child: new OverflowBox(
              alignment: Alignment.centerLeft,
              maxWidth: double.infinity,
              minHeight: 100.0,
              child: new Container(
                height: 50.0,
                child: new Text(
                  'ABCDEFGHIJKLMNOPQRSTUVWXYZXXXX',
                  maxLines: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Expand是可以计算出尺寸
  Widget _getTest2() {
    return new Container(
      width: 250.0,
      color: Colors.green,
      child: new Center(
        child: new Container(
          width: 200.0,
          height: 200.0,
          color: Colors.purple,
          child: new Row(
            children: <Widget>[
              new Container(
                width: 50.0,
                color: Colors.amber,
              ),
              SizedBox(),
              new Container(
                width: 50.0,
                color: Colors.black12,
              ),
              new Expanded(
                child: new OverflowBox(
                  alignment: Alignment.bottomLeft,
                  maxWidth: double.infinity,
                  child: new Text(
                    'fdjalfalfdjakfjalfkjdalkjfalf',
                    maxLines: 1,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //这个是给出固定尺寸
  Widget _getTest3() {
    return new Container(
      width: 250.0,
      color: Colors.green,
      child: new Center(
        child: new Container(
          width: 200.0,
          height: 200.0,
          color: Colors.purple,
          child: new Row(
            children: <Widget>[
              new Container(
                width: 50.0,
                color: Colors.amber,
              ),
              new Container(
                width: 50.0,
                color: Colors.black12,
              ),
              new Container(
                width: 80.0,
                color: Colors.red,
                child: new OverflowBox(
                  alignment: Alignment.bottomLeft,
                  maxWidth: double.infinity,
                  child: new Text(
                    'fdjalfalfdjakfjalfkjdalkjfalf',
                    maxLines: 1,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('text overflow'),
      ),
      body: _getTest1(),
    );
  }
}
