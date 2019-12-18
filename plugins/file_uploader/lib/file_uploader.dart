import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' show WidgetsBindingObserver, AppLifecycleState, WidgetsBinding;
import 'package:uuid/uuid.dart';

import 'exception.dart';
import 'http_upload.dart';
import 'store.dart';
import 'task.dart';
import 'zip.dart';

var uuid = new Uuid();
var connect = Connectivity();

/// log开关
bool enableLog = false;

FileUploaderConfig defaultConfig = FileUploaderConfig(url: 'http://localhost:3000/uploadFiles', archived: true, onWifiUse: true);

class FileUploaderConfig {
  final String url;
  final bool archived; // 是否压缩
  final bool onWifiUse; // 只在wifi下上传
  FileUploaderConfig({this.url, this.archived, this.onWifiUse});
}

FileUploaderConfig _config = defaultConfig; // 环境配置
Map<String, String> commonHeaders;
Map<String, String> commonFields;

void _innerPrint(str) {
  if (enableLog) {
    print('$str');
  }
}

class FileUploaderFinishResponse {
  final String taskId;
  final bool success;
  FileUploaderFinishResponse(this.taskId, this.success);

  @override
  String toString() {
    return '{taskId: $taskId, success: $success}';
  }
}

class FileUploaderProgressResponse {
  final String taskId;
  final num progress;
  FileUploaderProgressResponse({this.taskId, this.progress});

  @override
  String toString() {
    return '{taskId: $taskId, progress: $progress}';
  }
}

class FileUploader {
  static const MethodChannel _channel = const MethodChannel('file_uploader');

  /// 全局uploader对象
//  static var _uploader = FlutterUploader();
  static var _taskSession = UploadTaskSession()..init();
  static var _finishController = StreamController();
  static var _progressController = StreamController();

  static Stream get finishStream => _finishController.stream.asBroadcastStream();
  static Stream get progressStream => _progressController.stream.asBroadcastStream();

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static String getCacheDir() {
    return '${Directory.systemTemp.path}/cache_logs';
  }

  static init({FileUploaderConfig conf}) async {
    _config = conf ?? defaultConfig;
    await UploadTaskProvider.open();

    if (!Directory(getCacheDir()).existsSync()) {
      Directory(getCacheDir()).createSync(recursive: true);
    }

    /// 开启循环
    _taskSession.addTask(null);
  }

  static String _copyTmpFile(List<String> filePaths, String taskId) {
    String newDir = '${getCacheDir()}/${taskId}';
    if (!Directory(newDir).existsSync()) {
      Directory(newDir).createSync(recursive: true);
    }
    int copyCount = 0;
    for (var curPath in filePaths) {
      if (File(curPath).existsSync()) {
        var fileName = curPath.split('/').last;
        File(curPath).copySync('${newDir}/${fileName}');
        copyCount++;
      }
    }
    _innerPrint('copyCount = ${copyCount}');
    return newDir;
  }

  static Future<String> enqueue(
    List<String> filePaths, {
    Map<String, dynamic> headers = const {},
    Map<String, String> fields = const {},
    bool immediately = false,
  }) async {
    Map<String, String> temps = {};
    headers.forEach((str, value) {
      temps.putIfAbsent(str, () => value.toString());
    });
    commonHeaders = temps;
    commonFields = fields;
    var taskId = uuid.v4();
    var dataStr = '{}';
    if (immediately) {
      Function asyncFun = () async {
        var paramsStruct = TaskParamsStruct(
          fields: fields,
          filePaths: filePaths,
          archived: _config.archived ?? true,
          immediately: true,
          taskId: taskId,
        );

        if (_config.archived) {
          String newDir = _copyTmpFile(filePaths, taskId);
          paramsStruct = TaskParamsStruct(
            fields: fields,
            dirPath: newDir,
            archived: _config.archived ?? true,
            immediately: true,
            taskId: taskId,
          );
        }
        bool isWifi = await connect.checkConnectivity() == ConnectivityResult.wifi;
        paramsStruct.config = _config;
        paramsStruct.isWifi = isWifi;
        paramsStruct.headers = commonHeaders;
        var response = UploadResponse(errCode: -1);
        try {
          response = await executeTask(paramsStruct);
        } catch (e) {
          if (checkExceptionValid(e)) {
            response = UploadResponse(errCode: 0);
          }
          print('执行任务异常:$e');
        }

        _finishController.sink.add(FileUploaderFinishResponse(taskId, response.errCode == 0));
      };
      asyncFun();
    } else if (_config.archived) {
      String newDir = _copyTmpFile(filePaths, taskId);
      dataStr = TaskParamsStruct(
        fields: fields,
        dirPath: newDir,
        filePaths: [],
        archived: _config.archived ?? true,
        taskId: taskId,
      ).toStoreString();
      _taskSession.addTask(UploadTaskItem(taskId: taskId, data: dataStr));
    } else {
      dataStr = TaskParamsStruct(
        fields: fields,
        dirPath: '',
        filePaths: filePaths,
        archived: _config.archived ?? true,
        taskId: taskId,
      ).toStoreString();
      _taskSession.addTask(UploadTaskItem(taskId: taskId, data: dataStr));
    }

    return taskId;
  }
}

/// 上传任务的任务管理
class UploadTaskSession extends TaskSession<UploadTaskItem> with WidgetsBindingObserver {
  @override
  Future<bool> taskExist() async {
    List items = await UploadTaskProvider.getItems(limit: 1);
//    _innerPrint('taskExist: ${items.length}');
    if (items.length > 0) {
      return true;
    }
    return false;
  }

  init() {
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    _innerPrint('state = $state in file_uploader');
    if (state == AppLifecycleState.resumed) {
      _handleResumeHandle();
    }
  }

  void _handleResumeHandle() async {
    await UploadTaskProvider.open();
    doLoop();
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
        _innerPrint('item0 = ${item0}');
        try {
          bool isWifi = await connect.checkConnectivity() == ConnectivityResult.wifi;
          TaskParamsStruct paramsStruct = TaskParamsStruct.fromStoreString(item0.data);
          paramsStruct.config = _config;
          paramsStruct.isWifi = isWifi;
          paramsStruct.headers = commonHeaders;

          var uploadRsp = await executeTask(paramsStruct);
          if (uploadRsp.errCode == 0) {
            await removeTask(item0.taskId);
          } else {
            /// 错误延时.
            await Future.delayed(Duration(seconds: 20));
          }
        } catch (e) {
          if (checkExceptionValid(e)) {}
          await removeTask(item0.taskId);
          _innerPrint('getNextTask $e');
        }
      }
    };
    return task;
  }
}

/// isolate 中执行的函数
Future<UploadResponse> executeTask(TaskParamsStruct params) async {
  var onlyWifi = params.config.onWifiUse ?? true;
//  var connect = Connectivity();
  if (onlyWifi && !params.isWifi) {
    _innerPrint('file upload onlyWifi, but current env != wifi');
    await Future.delayed(Duration(seconds: 20));
    return UploadResponse(errCode: -11);
  }

  final config = params.config;
  var filePaths = params.filePaths;
  _innerPrint('executeTask: filePaths = ${params.filePaths}');
  _innerPrint('executeTask: dirPath = ${params.dirPath}');
  var userId = 'unknown';
  if (params.fields != null && params.fields['userId'] is String) {
    userId = params.fields['userId'];
  }

  var now = DateTime.now();
  var timeStr = '${now.hour}_${now.minute}_${now.millisecondsSinceEpoch}';
  var platform = Platform.isIOS ? 'ios' : 'android';
  var newPath = '${Directory.systemTemp.path}/${platform}_${userId}_${timeStr}.zip';
  if (params.archived) {
    var filePath = await compute(zipEncoderDir, params.dirPath);
    if (filePath != null) {
      // 这里重命名文件
      var file = File(filePath);
      file.renameSync(newPath);
      filePaths = [newPath];
      _innerPrint('重命名成功');
    } else {
      _innerPrint('失败成功');
    }
  }

  StreamController controller = StreamController();
  controller.stream.listen((progress) {
    FileUploader._progressController.sink.add(FileUploaderProgressResponse(taskId: params.taskId, progress: progress));
  });
  var res = await uploadFile(
    params.config.url,
    filePaths,
    fields: params.fields,
    headers: params.headers,
    progressController: controller,
  );
  _innerPrint('uploadFile = $res');
  try {
    if (config.archived && res.errCode == 0) {
      if (File(newPath).existsSync()) {
        File(newPath).deleteSync(recursive: true);
      }

      if (params.dirPath != null && Directory(params.dirPath).existsSync()) {
        Directory(params.dirPath).deleteSync(recursive: true);
      }

      _innerPrint('删除缓存数据成功');
    } else if (params?.immediately ?? false) {
      if (File(newPath).existsSync()) {
        File(newPath).deleteSync(recursive: true);
      }

      if (params.dirPath != null && Directory(params.dirPath).existsSync()) {
        Directory(params.dirPath).deleteSync(recursive: true);
      }
      _innerPrint('删除缓存数据成功');
    }
  } catch (e) {
    print('delete upload file: $e');
  }

  return res;
}

/// 执行任务的参数结构体。因为不同的 isolate 不能共享参数。
class TaskParamsStruct {
  final String taskId;
  final List<dynamic> filePaths; // store
  final String dirPath; // store
  final Map<String, String> fields; // store
  final bool archived;
  Map<String, String> headers;
  FileUploaderConfig config;
  bool isWifi;
  bool immediately;

  TaskParamsStruct({
    this.taskId,
    this.filePaths,
    this.headers,
    this.fields,
    this.config,
    this.isWifi = false,
    this.dirPath,
    this.archived,
    this.immediately = false,
  });

  String toStoreString() {
    var map = {
      'filePaths': filePaths,
      'dirPath': dirPath,
      'fields': fields,
      'archived': archived,
      'taskId': taskId.toString(),
    };

    return jsonEncode(map);
  }

  static TaskParamsStruct fromStoreString(String string) {
    try {
      var map = jsonDecode(string);
      return TaskParamsStruct(
        filePaths: map['filePaths'],
        dirPath: map['dirPath'],
        fields: Map<String, String>.from(map['fields']),
        archived: map['archived'],
        taskId: map['taskId'],
      );
    } catch (e) {
      print('fromStoreString fail:$e');
    }
    return null;
  }
}
