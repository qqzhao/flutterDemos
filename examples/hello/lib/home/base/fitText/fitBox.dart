import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello/utils/TextSizeCal.dart';

class FitBoxPage extends StatefulWidget {
  @override
  _ContainerWidgetState createState() => new _ContainerWidgetState();
}

class _ContainerWidgetState extends State<FitBoxPage> {
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

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('test'),
      ),
      body: Center(
        child: container,
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////////
class MyFlex extends StatefulWidget {
  final num width;
  final num height;
  final String showText;

  MyFlex({this.width, this.height, this.showText = ''});

  @override
  _MyFlexState createState() => _MyFlexState();
}

class _MyFlexState extends State<MyFlex> {
  num myFontSize;
  num myOpacity; //control the hide or show
  final num initialOpacity = 0.0;

  NotificationListener listener;

  @override
  void initState() {
    super.initState();
    myOpacity = initialOpacity;
    myFontSize = 20.0;
    _calculateAndSetFontSize();
  }

  void _calculateAndSetFontSize() async {
    double retFontSize = await TextSize.caculateFontSize(new Size(widget.width, widget.height), widget.showText);
    if (retFontSize != myFontSize) {
      setState(() {
        myFontSize = retFontSize;
        myOpacity = 1.0;
      });
    }
  }

  @override
  void didUpdateWidget(MyFlex oldWidget) {
    print("didUpdateWidget");
    if (oldWidget.showText != widget.showText) {
      _calculateAndSetFontSize();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print("build next");
    Widget container = new Container(
      child: new Text(
        '${widget.showText}',
        textDirection: TextDirection.ltr,
        style: new TextStyle(fontSize: myFontSize),
      ),
    );

    return Opacity(
      opacity: 1.0,
      child: container,
    );
  }
}
