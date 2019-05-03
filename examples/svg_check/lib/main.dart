import 'dart:io';

import 'package:common_tools/common_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SVG demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter SVG Demo Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> paths = [];

  initState() {
    super.initState();
    initSync();
  }

  void initSync() async {
    var dirStr = await CommonTools.getAssetPathPrefix('assets/svgs/test_1.svg');
    print('dirStr = $dirStr');

    var readDirPath = '$dirStr' + 'assets/svgs/';
    Directory directory = Directory(readDirPath);
    var pathList = directory.listSync(recursive: false);
    print('pathList = $pathList');
    setState(() {
      paths = pathList.map((item) => item.path).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          children: paths.map(
            (path) {
              return Container(
                color: Colors.red[100],
                child: SvgPicture.asset(
                  path,
//                  width: 130.0,
                  fit: BoxFit.fitWidth,
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
