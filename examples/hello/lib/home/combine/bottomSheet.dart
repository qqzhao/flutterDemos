import 'package:flutter/material.dart';
import '../../components/bottom_sheet.dart' as My;

class BottomSheetPage extends StatefulWidget {
  @override
  _BottomSheetPageState createState() => _BottomSheetPageState();
}

class _BottomSheetPageState extends State<BottomSheetPage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

    return new Scaffold(
        appBar: new AppBar(title: const Text('Modal bottom sheet')),
        body: new Center(
            child: new RaisedButton(
                child: const Text('SHOW BOTTOM SHEET'),
                onPressed: () {
                  My.showModalBottomSheet<void>(context: context, builder: (BuildContext context) {
                    return new Container(
                        child: new Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: new Text('This is the modal bottom sheet. Click anywhere to dismiss2.',
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 24.0
                                )
                            )
                        )
                    );
                  });

//                  My.showBottomSheet(context: context, builder: (BuildContext context){
//                      return new Container(
//                          child: new Padding(
//                              padding: const EdgeInsets.all(32.0),
//                              child: new Text('This is the modal bottom sheet. Click anywhere to dismiss3.',
//                                  textAlign: TextAlign.center,
//                                  style: new TextStyle(
//                                      color: Theme.of(context).accentColor,
//                                      fontSize: 24.0
//                                  )
//                              )
//                          )
//                      );
//                    });

                }
            )
        )
    );
  }
}
