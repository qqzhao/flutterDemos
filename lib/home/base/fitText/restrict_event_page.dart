import 'package:flutter/material.dart';
import 'package:hello/components/restrict_event2_widget.dart';
import 'package:hello/components/restrict_event_widget.dart';

class RestrictEventPage extends StatefulWidget {
  @override
  _RestrictEventPageState createState() => _RestrictEventPageState();
}

class _RestrictEventPageState extends State<RestrictEventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('restrict event test'),
      ),
      body: Column(
        children: <Widget>[
          TapRestrictEventWidget(
            restrictDuration: Duration(milliseconds: 300),
            child: Container(
              child: Column(
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      print('red clicked');
                    },
                    color: Colors.red,
                  ),
                  MaterialButton(
                    onPressed: () {
                      print('blue clicked');
                    },
                    color: Colors.blue,
                  ),
                  GestureDetector(
                    onDoubleTap: () {
                      print('purple clicked');
                    },
                    child: Container(
                      width: 50,
                      height: 40,
                      color: Colors.purple,
                    ),
                  )
                ],
              ),
              height: 200,
            ),
          ),
          OnlyOnePointerRecognizerWidget(
//            restrictDuration: Duration(milliseconds: 300),
            child: Container(
              child: Column(
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      print('red clicked');
                    },
                    color: Colors.red,
                  ),
                  MaterialButton(
                    onPressed: () {
                      print('blue clicked');
                    },
                    color: Colors.blue,
                  ),
                  GestureDetector(
                    onDoubleTap: () {
                      print('purple clicked');
                    },
                    onLongPressEnd: (_) {
                      print('purple clicked onLongPressEnd');
                    },
                    onLongPressUp: () {
                      print('purple clicked onLongPressUp');
                    },
                    child: Container(
                      width: 50,
                      height: 40,
                      color: Colors.purple,
                    ),
                  )
                ],
              ),
              height: 200,
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    print('red clicked');
                  },
                  color: Colors.red,
                ),
                MaterialButton(
                  onPressed: () {
                    print('blue clicked');
                  },
                  color: Colors.blue,
                )
              ],
            ),
            height: 200,
          ),
        ],
      ),
    );
  }
}
