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

  void reconnect() {
    print('reconnect');

    /// 外部捕获到全局异常，当前没有捕获到。
    /// 问题2：如何监听突然网络断开，失去链接
    try {
      channel = IOWebSocketChannel.connect("ws://localhost:8003", pingInterval: Duration(seconds: 8));
      channel.stream.listen((message) {
        print('message = $message');
      });
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
              channel.sink.add('send message ${count++}');
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
        ],
      ),
    );
  }
}
