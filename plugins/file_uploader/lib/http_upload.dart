import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

void _innerLog(str) {
//  print('$str');
}

/// 上传问题实现方法
Future<UploadResponse> uploadFile(String url, List filePaths, {Map<String, String> fields, Map<String, String> headers}) async {
  var postUri = Uri.parse(url);
  var request = new http.MultipartRequest("POST", postUri);
  if (fields != null) {
    request.fields.addEntries(fields?.entries);
  }
  if (headers != null) {
    request.headers.addEntries(headers?.entries);
  }

  for (int i = 0; i < filePaths.length; i++) {
    var filePath = filePaths[i];
    if (File(filePath).existsSync()) {
      request.files.add(await http.MultipartFile.fromPath('logs', filePath, contentType: getMediaType(filePath)));
    }
  }

  http.StreamedResponse response;
  _innerLog('uploadFile before...${DateTime.now()}');
  try {
    response = await request.send();
  } catch (e) {
    print('uploadFile 网络发生错误：$e');
  }
  _innerLog('uploadFile after...${DateTime.now()}');

  UploadResponse retRes = UploadResponse(errCode: -1, streamedResponse: response);
  if (response?.statusCode == 200) {
    try {
      var retStr = await response.stream.bytesToString();
      retRes.data = jsonDecode(retStr);
      retRes.errCode = 0;
      _innerLog('uploadFile success');
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
