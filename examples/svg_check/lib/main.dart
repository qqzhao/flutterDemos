import 'dart:io';

import 'package:common_tools/common_tools.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:svg_check/svg_show.dart';

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
  List<FileSystemEntity> items = [];

  initState() {
    super.initState();
//    initSync();
    initItems();
  }

  void didUpdateWidget(Widget oldWidget) {
    initItems();
    super.didUpdateWidget(oldWidget);
  }

  void initItems() async {
    Directory directory = await getApplicationDocumentsDirectory();

    /// 增加文件共享
    var list = directory.listSync(recursive: true);
    items.clear();
    int index = 0;
    for (FileSystemEntity entity in list) {
      if (entity is Directory) {
        items.add(entity);
      }
    }

    /// 增加本地asset资源
    var dirStr = await CommonTools.getAssetPathPrefix('assets/svgs/test.svg');
    print('dirStr = $dirStr');
    var readDirPath = '$dirStr' + 'assets/svgs/';
    Directory directory2 = Directory(readDirPath);
    print('directory2 = $directory2');
    var list2 = directory2.listSync(recursive: true);
    for (FileSystemEntity entity in list2) {
      if (entity is Directory) {
        items.add(entity);
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.separated(
            itemBuilder: (context, index) {
              FileSystemEntity item = items[index];
              return FlatButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return SvgShowPage(
                      path: item.path,
                      isLocal: false,
                      isAsset: false,
                    );
                  }));
                },
                child: Container(
                  height: 100.0,
                  child: Center(
                    child: Text('$index :${item.path}'),
                  ),
                  color: Colors.red[100],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                height: 2.0,
                color: Colors.blue,
              );
            },
            itemCount: items.length),
      ),
    );
  }
}
