import 'package:flutter/material.dart';
import 'package:z_notification/z_notification.dart';

class NotificationTestPage extends StatefulWidget {
  @override
  _NotificationTestPageState createState() => _NotificationTestPageState();
}

class _NotificationTestPageState extends State<NotificationTestPage> {
  Object? _message;
  @override
  void initState() {
    super.initState();
    NotificationCenter.shared.addObserver(
        observer: this,
        key: 'testKey',
        callback: (message) {
          print('data from message: $message');
          setState(() {
            _message = message;
          });
        });
  }

  @override
  void dispose() {
    NotificationCenter.shared.removeObserver(observer: this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('notification test1'),
      ),
      body: Container(
        child: Text('$_message'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NotificationTest2Page(),
          ));
        },
      ),
    );
  }
}

class NotificationTest2Page extends StatefulWidget {
  @override
  _NotificationTest2PageState createState() => _NotificationTest2PageState();
}

class _NotificationTest2PageState extends State<NotificationTest2Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('notification test2'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('post data');
          NotificationCenter.shared.post(key: 'testKey', sendObject: this, data: '11,22,33');
        },
      ),
    );
  }
}
