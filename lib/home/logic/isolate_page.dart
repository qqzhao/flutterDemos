import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';

Isolate isolateInstance;
ReceivePort responseInstance;
//ReceivePort answerInstance;

Future<dynamic> asyncFuncCreate(String str) async {
  if (isolateInstance != null) {
    print('1111');
//    final sendPort = await responseInstance.first as SendPort;
    final sendPort = isolateInstance.controlPort;

    await Isolate.spawn(_isolate, sendPort);

    final answer = new ReceivePort();
    //发送数据
    sendPort.send([str, answer.sendPort]);
    //获得数据并返回
    return answer.first;
  } else {
    print('2222');
  }

  //首先创建一个ReceivePort，为什么要创建这个？
  //因为创建isolate所需的参数，必须要有SendPort，SendPort需要ReceivePort来创建
  final response = new ReceivePort();
  responseInstance = response;
  //开始创建isolate,Isolate.spawn函数是isolate.dart里的代码,_isolate是我们自己实现的函数
  //_isolate是创建isolate必须要的参数。
  isolateInstance = await Isolate.spawn(_isolate, response.sendPort);

  //获取sendPort来发送数据
  final sendPort = await response.first as SendPort;
  //接收消息的ReceivePort
  final answer = new ReceivePort();
  //发送数据
  sendPort.send([str, answer.sendPort]);

  //获得数据并返回
  return answer.first;
}

//创建isolate必须要的参数
void _isolate(SendPort initialReplyTo) {
  print('_isolate hashcode= ${Isolate.current.hashCode}');

  final port = new ReceivePort();
  //绑定
  initialReplyTo.send(port.sendPort);
  //监听
  port.listen((message) async {
    print('message = $message');
    //获取数据并解析
    final data = message[0] as String;
    final send = message[1] as SendPort;
    //返回结果
//      send.send(syncFibonacci(data));
    var res = await asyncFunTest(data);
    send.send(res);
  });
}

void test() async {
  print('test before');
  var str1 = asyncFuncCreate('test1');
  print('str1 = $str1');
//  var str2 = await asyncFuncCreate('test2');
//  print('str2 = $str2');

  Timer(Duration(seconds: 3), () async {
    var str2 = await asyncFuncCreate('test2');
    print('str2 = $str2');
  });

  print('test after');
}

Future<String> asyncFunTest(String str) async {
  print('asyncFunTest: $str');
  await Future.delayed(Duration(seconds: 2));
  return '$str+++';
}

class IsolateTestPage extends StatefulWidget {
  @override
  _IsolateTestPageState createState() => _IsolateTestPageState();
}

class _IsolateTestPageState extends State<IsolateTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () async {
          print('tap');
          test();
        },
        child: Container(
          width: 100.0,
          height: 100.0,
          color: Colors.red,
          child: Text('tap me'),
        ),
      ),
      appBar: AppBar(
        title: Text('test isolate page'),
      ),
    );
  }
}
