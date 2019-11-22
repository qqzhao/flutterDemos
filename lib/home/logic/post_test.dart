import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostTestPage extends StatefulWidget {
  @override
  _PostTestPageState createState() => _PostTestPageState();
}

class _PostTestPageState extends State<PostTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test post'),
      ),
      body: FlatButton(
        onPressed: () {
          testPostDelay();
        },
        child: Container(
          child: Text('tap me'),
        ),
      ),
    );
  }
}

void testPost() async {
  Uri uri = Uri.parse('http://localhost:3000/postDelay');
  Map<String, String> headers = {'aa': 'bb'};
  http.Response response = await http.post(
    uri,
    headers: headers,
  );
  print('_post rsp = $response');
  print('_post rsp statusCode = ${response.statusCode}, ${response.reasonPhrase}');
}

void testPostDelay() async {
  print('in testPostDelay');
  Uri uri = Uri.parse('http://localhost:3000/postDelay');
  Map<String, String> headers = {'aa': 'bb'};

  var response;
  try {
    http.Response response = await http
        .post(
          uri,
          headers: headers,
        )
        .timeout(Duration(seconds: 3));
  } on TimeoutException catch (e) {
    print('timeout = $e');
  } catch (e) {}

  print('_post rsp = $response');
  print('_post rsp statusCode = ${response?.statusCode}, ${response?.reasonPhrase}');
}

void testPost2() async {
  Uri uri = Uri.parse('http://localhost:3000/post');
  Map<String, String> headers = {'aa': 'bb'};
  var request = new http.MultipartRequest("POST", uri);
  request.headers.addAll(headers);

  var response = await request.send();
  print('_post rsp statusCode = ${response.statusCode}, ${response.reasonPhrase}');
  if (response?.statusCode == 200) {
    try {
      var retStr = await response.stream.bytesToString();
      var retRes = jsonDecode(retStr);
      print('_post retRes = $retRes');
    } catch (e) {
      print('_post 发生错误：$e');
    }
  }
}

void testPost3() async {
  print('testPost3');
  Uri uri = Uri.parse('http://ap-guangzhou.cls.myqcloud.com/structuredlog?topic_id=xxx');
  uri = Uri.parse('http://4ap-guangzhou.cls.myqcloud.com/structuredlog?topic_id=xxx');
  var headers = {
    'Content-Type': 'application/x-protobuf',
  };

  var request = new http.MultipartRequest("POST", uri);
//  request.headers.addAll(headers);

  var response;
  try {
    print('send request');
    response = await request.send().timeout(Duration(seconds: 10), onTimeout: () {
      print('on Timeout');
      return http.StreamedResponse(null, 504);
    });
  } catch (e) {
    print('e = $e');
  }

  print('_post rsp statusCode = ${response?.statusCode}, ${response?.reasonPhrase}');
  if (response != null) {
    try {
      var retStr = await response.stream.bytesToString();
      var retRes = jsonDecode(retStr);
      print('_post retRes = $retRes');
    } catch (e) {
      print('_post 发生错误：$e');
    }
  }
}
