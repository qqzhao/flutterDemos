import 'package:file_uploader/store.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    UploadTaskProvider.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('test database'),
        ),
        body: GestureDetector(
          onTap: () {
            print('on button1 tap');
            test1();
          },
          child: Container(
            key: ValueKey('button1'),
            width: 100.0,
            height: 100.0,
            child: Text('tap me!'),
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

void test1() async {
  await UploadTaskProvider.insert(UploadTaskItem(taskId: 'id1', data: '1111'));
  await UploadTaskProvider.insert(UploadTaskItem(taskId: 'id2', data: '1111'));
  await UploadTaskProvider.insert(UploadTaskItem(taskId: 'id3', data: '3333'));

  var items = await UploadTaskProvider.getItems();
  print('item = ${items}');

  await UploadTaskProvider.remove('id1');
  items = await UploadTaskProvider.getItems(limit: 1);
  print('item = ${items}');
}
