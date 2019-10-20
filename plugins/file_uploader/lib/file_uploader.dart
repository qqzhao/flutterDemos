import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:uuid/uuid.dart';

import 'http_upload.dart';
import 'store.dart';
import 'task.dart';
import 'zip.dart';

var uuid = new Uuid();

FileUploaderConfig defaultConfig = FileUploaderConfig(url: 'http://localhost:3000/uploadFiles', archived: true);

class FileUploaderConfig {
  final String url;
  final bool archived; // 是否压缩
  FileUploaderConfig({this.url, this.archived});
}

void test() async {
  await UploadTaskProvider.insert(UploadTaskItem(taskId: 'id1', data: '1111'));
  await UploadTaskProvider.insert(UploadTaskItem(taskId: 'id2', data: '1111'));
  await UploadTaskProvider.insert(UploadTaskItem(taskId: 'id3', data: '3333'));

  var items = await UploadTaskProvider.getItems();
  print('item = ${items}');

  await UploadTaskProvider.remove('id1');
  items = await UploadTaskProvider.getItems(limit: 1);
  print('item = ${items}');
}

void _innerPrint(str) {
  print('$str');
}

class FileUploader {
  static const MethodChannel _channel = const MethodChannel('file_uploader');

  /// 全局uploader对象
  static var _uploader = FlutterUploader();
  static var _taskSession = UploadTaskSession();

  /// 配置对象
  static FileUploaderConfig _config = defaultConfig;

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static init({FileUploaderConfig conf}) {
    _config = conf ?? defaultConfig;
    UploadTaskProvider.open();
    configResult();
  }

  static configResult() async {
    _uploader.result.listen((rsp) {
      print('rsp = ${rsp.statusCode}');
      _taskSession.removeTask(rsp.taskId);
    });
  }

  static Future<String> enqueue(List filePaths) async {
//    test();
//    return '';
    var taskId = uuid.v4();
    _taskSession.addTask(UploadTaskItem(taskId: taskId, data: jsonEncode(filePaths)));
    return '';
  }

  static Future<UploadResponse> executeTask(List filePaths) async {
    _innerPrint('executeTask: ${filePaths}');
    if (_config.archived != null && _config.archived) {
      var filePath = await zipEncoder(filePaths);
      if (filePath != null) {
        filePaths = [filePath];
      }
    }

    var files = [];
//    if (filePaths is List && filePaths.length > 0) {
//      files = filePaths.map((filePath) {
//        List arr = filePath.split('/');
//        String filename = arr.last;
//        String savedDir = filePath.substring(0, filePath.length - filename.length);
//        return FileItem(filename: filename, savedDir: savedDir, fieldname: "file");
//      }).toList();
//    }

//    final taskId = await _uploader.enqueue(
//        url: _config.url,
//        files: files,
//        method: UploadMethod.POST,
//        // HTTP method  (POST or PUT or PATCH)
//        headers: {"apikey": "api_123456", "userkey": "userkey_123456"},
//        data: {"name": "john"},
//        showNotification: false,
//        tag: "upload 1"); // unique tag for upload task
//    print('taskId = $taskId');
    var res = await uploadFile(_config.url, filePaths, fields: {'channel': 'test', 'test': '222'});
    return res;
  }

  static Future<void> cancel({String taskId}) async {
    await _uploader.cancel(taskId: taskId);
  }

  static Future<void> cancelAll() async {
    await _uploader.cancelAll();
  }
}

/// 上传任务的任务管理
class UploadTaskSession extends TaskSession<UploadTaskItem> {
  @override
  Future<bool> taskExist() async {
    List items = await UploadTaskProvider.getItems(limit: 1);
//    _innerPrint('taskExist: ${items.length}');
    if (items.length > 0) {
      return true;
    }
    return false;
  }

  void addTask(UploadTaskItem item) async {
    _innerPrint('addTask: ${item.taskId}');
    await UploadTaskProvider.insert(item);
    await doLoop();
  }

  void removeTask(String taskId) async {
    _innerPrint('removeTask: $taskId');
    await UploadTaskProvider.remove(taskId);
  }

  @override
  Function getNextTask() {
    var task = () async {
      List items = await UploadTaskProvider.getItems(limit: 1);
      if (items.length > 0) {
        var item0 = items[0];
        print('item0 = ${item0}');
        try {
          List filePaths = jsonDecode(item0.data);

//          var uploadRsp = await FileUploader.executeTask(filePaths);
          var uploadRsp = await compute(FileUploader.executeTask, filePaths);
          if (uploadRsp.errCode == 0) {
            await removeTask(item0.taskId);
          }
        } catch (e) {
          print('getNextTask $e');
          await removeTask(item0.taskId);
        }
      }
    };
    return task;
  }
}
