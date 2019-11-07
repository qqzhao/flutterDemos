import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebSocketTestPage extends StatefulWidget {
  @override
  _WebSocketTestPageState createState() => _WebSocketTestPageState();
}

class _WebSocketTestPageState extends State<WebSocketTestPage> {
  IOWebSocketChannel channel;
  int count = 0;
  @override
  void initState() {
    super.initState();
    reconnect();
  }

  /// 内部没有链接状态，只能自己记录
  void reconnect() {
    print('reconnect');
    try {
      channel = IOWebSocketChannel.connect("ws://localhost:8003", pingInterval: Duration(seconds: 8));
      channel.stream.listen((message) {
        print('message = $message');
      }, onDone: () {
        print('onDone');
      }, onError: (e) {
        print('onError: $e');
      }, cancelOnError: true);
    } catch (e) {
      print('connect exception= $e');
    }
  }

  @override
  void dispose() {
    channel.sink.close(status.normalClosure);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test ws connect'),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            onPressed: () {
              reconnect();
            },
            child: Container(
              color: Colors.blue,
              child: Text('connect'),
              width: 100.0,
              height: 60.0,
            ),
          ),
          FlatButton(
            onPressed: () {
              try {
                channel.sink.add('send message ${count++}');
              } catch (e) {
                print('send exp = $e');
              }
            },
            child: Container(
              color: Colors.blue,
              child: Text('send message'),
              width: 100.0,
              height: 60.0,
            ),
          ),
          FlatButton(
            onPressed: () {
//              channel.sink.add('send message ${count++}');
            },
            child: Container(
              color: Colors.blue,
              child: Text('send ping'),
              width: 100.0,
              height: 60.0,
            ),
          ),
          FlatButton(
            onPressed: () {
//              channel.sink
            },
            child: Container(
              color: Colors.blue,
              child: Text('send pong'),
              width: 100.0,
              height: 60.0,
            ),
          ),
          FlatButton(
            onPressed: () {
              channel.sink.close(status.goingAway);
            },
            child: Container(
              color: Colors.blue,
              child: Text('going away'),
              width: 100.0,
              height: 60.0,
            ),
          ),
          FlatButton(
            onPressed: () {
              channel.sink.close(status.messageTooBig);
            },
            child: Container(
              color: Colors.blue,
              child: Text('message too big'),
              width: 100.0,
              height: 60.0,
            ),
          ),
          FlatButton(
            onPressed: () {
              channel.sink.close(status.abnormalClosure);
            },
            child: Container(
              color: Colors.blue,
              child: Text('abnormalClosure'),
              width: 100.0,
              height: 60.0,
            ),
          ),
          FlatButton(
            onPressed: () async {
              var status = await channel.sink.done;
//              await status();
              print('status = $status');
            },
            child: Container(
              color: Colors.blue,
              child: Text('get status'),
              width: 100.0,
              height: 60.0,
            ),
          ),
        ],
      ),
    );
  }
}
