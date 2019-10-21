import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import 'http_upload.dart';
import 'store.dart';
import 'task.dart';
import 'zip.dart';

var uuid = new Uuid();
var connect = Connectivity();
bool enableLog = false;

FileUploaderConfig defaultConfig = FileUploaderConfig(url: 'https://localhost:3000', archived: true, onWifiUse: true);

class FileUploaderConfig {
  final String url;
  final bool archived; // 是否压缩
  final bool onWifiUse; // 只在wifi下上传
  FileUploaderConfig({this.url, this.archived, this.onWifiUse});
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

FileUploaderConfig _config = defaultConfig; // 环境配置
Map<String, String> commonHeaders;
Map<String, String> commonFields;

void _innerPrint(str) {
  if (enableLog) {
    print('$str');
  }
}

class FileUploader {
  static const MethodChannel _channel = const MethodChannel('file_uploader');

  /// 全局uploader对象
//  static var _uploader = FlutterUploader();
  static var _taskSession = UploadTaskSession();

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static init({FileUploaderConfig conf}) {
    _config = conf ?? defaultConfig;
    UploadTaskProvider.open();

    /// 开启循环
    Timer(Duration(seconds: 10), () {
      _taskSession.addTask(null);
    });
//    configResult();
  }

//  static configResult() async {
//    _uploader.result.listen((rsp) {
//      print('rsp = ${rsp.statusCode}');
//      _taskSession.removeTask(rsp.taskId);
//    });
//  }

  static Future<String> enqueue(List<String> filePaths, {Map<String, dynamic> headers = const {}, Map<String, String> fields = const {}}) async {
    Map<String, String> temps = {};
    headers.forEach((str, value) {
      temps.putIfAbsent(str, () => value.toString());
    });
    commonHeaders = temps;
    commonFields = fields;
    var taskId = uuid.v4();
    _taskSession.addTask(UploadTaskItem(taskId: taskId, data: jsonEncode(filePaths)));
    return '';
  }

//  static Future<void> cancel({String taskId}) async {
//    await _uploader.cancel(taskId: taskId);
//  }
//
//  static Future<void> cancelAll() async {
//    await _uploader.cancelAll();
//  }
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
    _innerPrint('addTask: ${item?.taskId}');
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
          bool isWifi = await connect.checkConnectivity() == ConnectivityResult.wifi;
          var uploadRsp = await compute(
              executeTask, UploadParamsStruct(filePaths: filePaths, config: _config, headers: commonHeaders, fields: commonFields, isWifi: isWifi));
          if (uploadRsp.errCode == 0) {
            await removeTask(item0.taskId);
          } else {
            /// 错误延时.
            await Future.delayed(Duration(seconds: 20));
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

/// isolate 中执行的函数
Future<UploadResponse> executeTask(UploadParamsStruct params) async {
  var onlyWifi = params.config.onWifiUse ?? true;
//  var connect = Connectivity();
  if (onlyWifi && !params.isWifi) {
    _innerPrint('file upload onlyWifi, but current env != wifi');
    await Future.delayed(Duration(seconds: 20));
    return UploadResponse(errCode: -11);
  }

  final config = params.config;
  var filePaths = params.filePaths;
  _innerPrint('executeTask: ${params.filePaths}');
  var userId = 'unknown';
  if (params.fields != null && params.fields['userId'] is String) {
    userId = params.fields['userId'];
  }

  var now = DateTime.now();
  var timeStr = '${now.hour}_${now.minute}_${now.second}_${now.millisecondsSinceEpoch}';
  var newPath = '${Directory.systemTemp.path}/${userId}_${timeStr}.zip';
  if (config.archived != null && config.archived) {
    var filePath = await zipEncoder(params.filePaths);
    if (filePath != null) {
      // 这里重命名文件
      var file = File(filePath);
      file.rename(newPath);
      filePaths = [newPath];
    }
  }

  var res = await uploadFile(params.config.url, filePaths, fields: params.fields, headers: params.headers);
  try {
    if (config.archived && res.errCode == 0 && await File(newPath).existsSync()) {
      File(newPath).deleteSync(recursive: true);
    }
  } catch (e) {
    print('delete upload file: $e');
  }

  return res;
}

/// 执行任务的参数结构体。因为不同的 isolate 不能共享参数。
class UploadParamsStruct {
  final List<dynamic> filePaths;
  final Map<String, String> headers;
  final Map<String, String> fields;
  final FileUploaderConfig config;
  final bool isWifi;

  UploadParamsStruct({this.filePaths, this.headers, this.fields, this.config, this.isWifi = false});
}
