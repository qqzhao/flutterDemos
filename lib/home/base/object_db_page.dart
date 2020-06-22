import 'dart:io';

import 'package:flutter/material.dart';
import 'package:objectdb/objectdb.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

bool forOnce = false;

class ObjectdbTestPage extends StatelessWidget {
  void _testDB() async {
    print('enter _testDB');
//    final path = Directory.current.path + '/my.db';
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "demo.db");

    print('path = $path');
    var db = ObjectDB(path);
    db.open();

    // insert documents
    await db.insertMany([
      {
        "name": {"first": "Maria", "last": "Smith"},
        "age": 20,
        "active": false
      },
      {
        "name": {"first": "James", "last": "Jones"},
        "age": 32,
        "active": false
      },
    ]);

    // update documents
    db.update({"name.first": "Maria"}, {"active": true});

    // remove documents
    db.remove({
      Op.inList: {
        "name.last": ["Jones", "Miller", "Wilson"]
      },
      "active": false,
    });

    // find documents
    print(await db.find({
      Op.lte: {"age": 40}
    }));

    // close db
    await db.close();
  }

  @override
  Widget build(BuildContext context) {
    if (!forOnce) {
      forOnce = true;
      _testDB();
    }
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('ObjectdbTestPage'),
      ),
      body: new Center(
        child: new Text('body'),
      ),
    );
  }
}
