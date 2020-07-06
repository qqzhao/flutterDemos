import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hello/home/render/simple_render_update_2.dart';

class SimpleRenderPage extends StatefulWidget {
  @override
  _SimpleRenderPageState createState() => _SimpleRenderPageState();
}

class _SimpleRenderPageState extends State<SimpleRenderPage> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      print('setState');
      setState(() {
        counter++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test simple bar'),
      ),
      body: Column(
        children: <Widget>[
          Text('$counter'),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => SimpleRenderPage2(),
              ));
            },
          ),
        ],
      ),
    );
  }
}
