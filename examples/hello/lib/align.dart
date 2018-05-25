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
    title: new Text('Test Align'),
    centerTitle: true,
  ),
  body: new Home(),
) ;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var stack = new Stack(
      children: <Widget>[
        new Container(
          color: Colors.red,
          width: 200.0,
          height: 200.0,
          child: new Text('aaa'),
          alignment: Alignment.center,
        ),
        new Container(
//      width: 200.0,
//      height: 100.0,
          margin: new EdgeInsets.all(40.0),
          padding: new EdgeInsets.all(20.0),
          color: Colors.yellow,
          width: MediaQuery.of(context).size.width,
          child: new ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index){
                return new Text('aaa = $index');
              }
          ),
        ),
      ],
    );

    var home = new Container(
      color: Colors.red,
      child: new Row(
        children: <Widget>[
          stack,
        ],
      ),
    );

    return home;
  }
}



/***
    Column 中嵌套ListView的结果。或者说其中可能会有多个元素。
    flutter: The following assertion was thrown during performResize():
    flutter: Vertical viewport was given unbounded height.
    flutter: Viewports expand in the scrolling direction to fill their container.In this case, a vertical
    flutter: viewport was given an unlimited amount of vertical space in which to expand. This situation
    flutter: typically happens when a scrollable widget is nested inside another scrollable widget.
    flutter: If this widget is always nested in a scrollable widget there is no need to use a viewport because
    flutter: there will always be enough vertical space for the children. In this case, consider using a Column
    flutter: instead. Otherwise, consider using the "shrinkWrap" property (or a ShrinkWrappingViewport) to size
    flutter: the height of the viewport to the sum of the heights of its children.

    换成Row也不行。-- 可以加上宽度.
    flutter: The following assertion was thrown during performResize():
    flutter: Vertical viewport was given unbounded width.
    flutter: Viewports expand in the cross axis to fill their container and constrain their children to match
    flutter: their extent in the cross axis. In this case, a vertical viewport was given an unlimited amount of
    flutter: horizontal space in which to expand.
 */


