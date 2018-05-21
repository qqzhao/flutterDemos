

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';



void main() {
  runApp(new ContainerWidget());
}

class ContainerWidget extends StatefulWidget {
  @override
  _ContainerWidgetState createState() => new _ContainerWidgetState();
}

class _ContainerWidgetState extends State<ContainerWidget> {

  String text = 'dfak dfsaj ';

  MyFlex flexObj = new MyFlex(
    width: 200.0,
    height: 100.0,
    maxFontSize: 80.0,
  );

  @override
  Widget build(BuildContext context) {
    flexObj.showText = text;
    Widget container = new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new RaisedButton(
          onPressed: () {
            print("button clicked: $text");
            text = text + 'hello world';
            flexObj.showText = text;
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
            text = 'hello world';
            flexObj.showText = text;
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
            child: flexObj,
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
  num maxFontSize;
  num minFontSize;
//  String showText = '';
  String _showText = 'abcd';

  _MyFlexState state;

  MyFlex({this.width, this.height,this.maxFontSize, this.minFontSize = 16}): super();

  set showText(String newText) {
    _showText = newText;
    if (state != null && state._updateText != null) {
      state._updateText(_showText);
    }
  }

  String get showText{
    return _showText;
  }

  @override
  _MyFlexState createState() {
    state =  _MyFlexState();
    return state;
  }
}

class _MyFlexState extends State<MyFlex> {

  Timer _myTimer;
  num myFontSize;
  num stepFont = 2.0;
  num myOpicity; //control the hide or show
  final duration = 20;
  final num initialOpicity = 0.0;

  num lastLowerFontSize = 0; // save mid result
  num lastHighFontSize = 0; // save mid result
  final num availableHeightError = 3; // 小于这个值

  NotificationListener listener;

  @override
  void initState() {
    print("init State");
    super.initState();
    myOpicity = initialOpicity;
    myFontSize = (widget.maxFontSize + widget.minFontSize) / 2 ;//widget.maxFontSize;
    lastLowerFontSize = widget.minFontSize;
    lastHighFontSize = widget.maxFontSize;
    _myTimer = new Timer.periodic(Duration(milliseconds: duration), _timerCallback);

//    listener = new NotificationListener(child: widget, onNotification: _onNotifycation,);
  }

  bool _onNotifycation<Notification>(Notification notify) {
    print("notify = $notify");
    if (notify is! OverscrollNotification) {
      return true;
    }
    return true;
  }

  _cancelTimer () {
    print("_cancelTimer ,$_myTimer");
    if (_myTimer != null) {
      _myTimer.cancel();
      _myTimer = null;
    }
  }

  _updateText(String text) {
    print("updateText: $text");
    _cancelTimer();
    setState(() {
      myFontSize = (widget.maxFontSize + widget.minFontSize) / 2;
//      widget.showText = text;
      myOpicity = initialOpicity;
    });

    lastLowerFontSize = widget.minFontSize;
    lastHighFontSize = widget.maxFontSize;
    _myTimer = Timer.periodic(Duration(milliseconds: duration), _timerCallback);
  }

  _timerCallback(timer) {
    RenderBox box = context.findRenderObject() as RenderBox;
    num height = box.getMinIntrinsicHeight(widget.width);
    DateTime now = new DateTime.now();
    print("height = $height, fontSize = $myFontSize");
    print("low = $lastLowerFontSize, high = $lastHighFontSize");

    bool isNotToralatable = lastHighFontSize - lastLowerFontSize > stepFont;
    print("isNotToralatable = $isNotToralatable");
    if (!isNotToralatable) { // 可以容忍的话
      _cancelTimer();
      if (height > widget.height) {
        setState(() {
          myFontSize = myFontSize - stepFont;
          myOpicity = 1.0;
        });
      } else {
        setState(() {
          myOpicity = 1.0;
        });
      }
    } else {
      if (height > widget.height) {
        lastHighFontSize = myFontSize;
        setState(() {
          myFontSize = (lastHighFontSize + lastLowerFontSize) / 2;
        });
      } else if (height < widget.height && (widget.height - height) >= availableHeightError) {
        lastLowerFontSize = myFontSize;
        setState(() {
          myFontSize = (lastHighFontSize + lastLowerFontSize) / 2;
        });
      } else {
        _cancelTimer();
        setState(() {
          myOpicity = 1.0;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget container = new Container(
//      color: Colors.yellow,
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
      opacity: myOpicity,
      child: container,
    );
  }
}
