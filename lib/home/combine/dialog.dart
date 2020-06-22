import 'package:flutter/material.dart';

enum DialogDemoAction {
  cancel,
  discard,
  disagree,
  agree,
}

class DialogPage extends StatefulWidget {
  @override
  _DialogPageState createState() => new _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
      print('aaaa');
      if (value != null) {
        _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('You selected: $value')));
      }
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('dialog test'),
      ),
      body: new ListView(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 72.0),
          children: <Widget>[
            new RaisedButton(
                child: const Text('ALERT'),
                onPressed: () {
                  showDemoDialog<DialogDemoAction>(
                      context: context,
                      child: new AlertDialog(
                          content: new Text(
                            'text alert',
                          ),
                          actions: <Widget>[
                            new FlatButton(
                                child: const Text('CANCEL'),
                                onPressed: () {
                                  Navigator.pop(context, DialogDemoAction.cancel);
                                }),
                            new FlatButton(
                                child: const Text('DISCARD'),
                                onPressed: () {
                                  Navigator.pop(context, DialogDemoAction.discard);
                                })
                          ]));
                }),
            new RaisedButton(
                child: const Text('ALERT WITH TITLE'),
                onPressed: () {
                  showDemoDialog<DialogDemoAction>(
                      context: context,
                      child: new AlertDialog(
                          title: const Text('Use Google\'s location service?'),
                          content: new Text(
                            'alert text',
                          ),
                          actions: <Widget>[
                            new FlatButton(
                                child: const Text('DISAGREE'),
                                onPressed: () {
                                  Navigator.pop(context, DialogDemoAction.disagree);
                                }),
                            new FlatButton(
                                child: const Text('AGREE'),
                                onPressed: () {
                                  Navigator.pop(context, DialogDemoAction.agree);
                                })
                          ]));
                }),
//            new RaisedButton(
//                child: const Text('CONFIRMATION'),
//                onPressed: () {
//                  showTimePicker(
//                      context: context,
//                      initialTime: _selectedTime
//                  )
//                      .then<Null>((TimeOfDay value) {
//                    if (value != null && value != _selectedTime) {
//                      _selectedTime = value;
//                      _scaffoldKey.currentState.showSnackBar(new SnackBar(
//                          content: new Text('You selected: ${value.format(context)}')
//                      ));
//                    }
//                  });
//                }
//            ),
            new RaisedButton(
                child: const Text('FULLSCREEN'),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (BuildContext context) => new Text('Full Screen'),
                        fullscreenDialog: false,
                      ));
                }),
          ]
              // Add a little space between the buttons
              .map((Widget button) {
            return new Container(padding: const EdgeInsets.symmetric(vertical: 8.0), child: button);
          }).toList()),
    );
  }
}
