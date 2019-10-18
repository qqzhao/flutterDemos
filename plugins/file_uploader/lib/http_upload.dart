import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

/// 上传问题实现方法
Future<UploadResponse> uploadFile(String url, List filePaths, {Map<String, String> fields}) async {
  var postUri = Uri.parse(url);
  var request = new http.MultipartRequest("POST", postUri);
  request.fields.addEntries(fields.entries);
  for (int i = 0; i < filePaths.length; i++) {
    var filePath = filePaths[i];
    var curFile = File(filePath);
    if (File(filePath).existsSync()) {
      request.files.add(await http.MultipartFile.fromPath('file', filePath, contentType: getMediaType(filePath)));
    }
  }

  http.StreamedResponse response = await request.send();

  UploadResponse retRes = UploadResponse(errCode: -1, streamedResponse: response);
  if (response.statusCode == 200) {
    try {
      var retStr = await response.stream.bytesToString();
      retRes.data = jsonDecode(retStr);
      retRes.errCode = 0;
      print('uploadFile success');
    } catch (e) {
      print('uploadFile 发生错误：$e');
    }
  }
  return retRes;
}

MediaType getMediaType(filePath) {
  var defaultType = MediaType('text', 'plain');
  if (filePath == null || filePath.length == 0) {
    return defaultType;
  }
  var type = defaultType;
  List lastS = filePath.split('.');
  String typeStr = lastS.last;
  switch (typeStr) {
    case 'zip':
      type = MediaType('application', 'zip');
      break;
    case 'png':
      type = MediaType('image', 'png');
      break;
    case 'jpeg':
      type = MediaType('image', 'image');
      break;
    case 'txt':
    case 'log':
      type = MediaType('text', 'plain');
      break;
    case 'mp3':
    case 'pcm':
      type = MediaType('audio', 'mpeg');
      break;
    default:
  }
  return type;
}

/// 上传文件返回结构体
class UploadResponse {
  final http.StreamedResponse streamedResponse;
  dynamic data;
  int errCode;

  UploadResponse({this.streamedResponse, this.data, this.errCode});

  @override
  String toString() {
    var response = streamedResponse;
    return 'UploadResponse{streamedResponse: $streamedResponse, data: $data}, errCode = $errCode, response = ${response.statusCode}, ${response.contentLength}, ${response.reasonPhrase} ';
  }
}
