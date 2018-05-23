

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import './utils/TextSizeCal.dart';


void main() {
  runApp(new ContainerWidget());
}

class ContainerWidget extends StatefulWidget {
  @override
  _ContainerWidgetState createState() => new _ContainerWidgetState();
}

class _ContainerWidgetState extends State<ContainerWidget> {

  String text = 'dfak dfsaj';
  @override
  Widget build(BuildContext context) {
    Widget container = new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new RaisedButton(
          onPressed: () {
            print("button clicked: $text");
            String newText = text + 'hello world';
            setState(() {
              text = newText;
            });
          },
          textColor: Colors.blue,
          child: new Text(
            'Add Text',
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
          ),
        ),
        new RaisedButton(
          onPressed: () {
            print("button clicked: $text");
            String newText = 'hello world';
            setState(() {
              text = newText;
            });
          },
          textColor: Colors.blue,
          child: new Text(
            'Recovery',
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
          ),
        ),
        new Container(
            width: 200.0,
            height: 100.0,
            color: Colors.red,
            child: new MyFlex(
              width: 200.0,
              height: 100.0,
              showText: text,
            ),
        ),
      ],
    );

    return container;
  }
}


/////////////////////////////////////////////////////////////////////////////////////
class MyFlex extends StatefulWidget {

  num width;
  num height;
  String showText = '';

  _MyFlexState state;
  MyFlex({this.width, this.height, this.showText}): super();

  @override
  _MyFlexState createState() {
    state =  _MyFlexState();
    return state;
  }
}

class _MyFlexState extends State<MyFlex> {

  num myFontSize;
  num myOpicity; //control the hide or show
  final num initialOpicity = 0.0;


  NotificationListener listener;

  @override
  void initState() {
    super.initState();
    myOpicity = initialOpicity;
    myFontSize = 20.0;

    _caculateAndSetFontSize();
//    listener = new NotificationListener(child: widget, onNotification: _onNotifycation,);
  }

  _caculateAndSetFontSize() async {
    double retFontSize = await TextSize.caculateFontSize(new Size(widget.width, widget.height), widget.showText);
    if (retFontSize != myFontSize) {
      setState(() {
        myFontSize = retFontSize;
        myOpicity = 1.0;
      });
    }
  }

  bool _onNotifycation<Notification>(Notification notify) {
    print("notify = $notify");
    if (notify is! OverscrollNotification) {
      return true;
    }
    return true;
  }

  @override
  void didUpdateWidget(MyFlex oldWidget) {
    print("didUpdateWidget");
    if (oldWidget.showText != widget.showText) {
      _caculateAndSetFontSize();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print("build next");
//    myOpicity = initialOpicity;
    Widget container = new Container(
      child: new NotificationListener(
        onNotification: _onNotifycation,
        child: new Text(
          '${widget.showText}',
          textDirection: TextDirection.ltr,
          style: new TextStyle(
              fontSize: myFontSize
          ),
        ),
      )
    );

    return Opacity(
      opacity: 1.0,
      child: container,
    );
  }
}
