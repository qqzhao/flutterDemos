import 'dart:io';

import 'package:sqflite/sqflite.dart';

final String tableName = "upload_log_table_v0";
final String columnId = "id";
final String columnData = "data"; // json data

class UploadTaskItem {
  final String taskId;
  final String data;

  UploadTaskItem({this.taskId, this.data});

  static UploadTaskItem fromObj(Map map) {
    if (map is Map) {
      return UploadTaskItem(taskId: map['id'], data: map['data']);
    }
    return null;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': taskId,
      'data': data,
    };
  }

  @override
  String toString() {
    return 'UploadTaskItem{taskId: $taskId, data: $data}';
  }
}

class UploadTaskProvider {
  static Database db;

  static Future<void> open() async {
    var filePath = '${Directory.systemTemp.path}/upload_file.db';
    try {
      db = await openDatabase(filePath, version: 1, onCreate: (Database db, int version) async {});
      print("打开Sql数据库 $filePath");
      await db.execute('''
          create table if not exists  $tableName ( 
            $columnId text, 
            $columnData text,
            PRIMARY KEY (${columnId}))
          ''');
    } catch (e) {
      print("打开Sql数据库 $e");
    }
  }

  static Future<void> close() async {
    if (db is Database) {
      await db.close();
    }
  }

  static insert(UploadTaskItem item) async {
    if (item is UploadTaskItem) {
      try {
        await db.insert(tableName, item.toMap());
      } catch (e) {
        print('insert $e');
      }
    }
  }

  static remove(String taskId) async {
    if (taskId is String && taskId.isNotEmpty) {
      try {
        await db.delete(tableName, where: "$columnId = ?", whereArgs: [taskId]);
      } catch (e) {
        print('remove $e');
      }
    }
  }

  static Future<List<UploadTaskItem>> getItems({int limit = 3}) async {
    try {
      List<Map> maps = await db.query(tableName, columns: [columnId, columnData], limit: limit);
      if (maps.length > 0) {
        List<UploadTaskItem> list = maps.map((item) => UploadTaskItem.fromObj(item)).toList(growable: false);
        return list;
      }
    } catch (e) {
      print('getItems $e');
    }

    return [];
  }
}
