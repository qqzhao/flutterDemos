import 'dart:io';

import 'package:archive/archive_io.dart';

const zipName = 'zip_out.zip';

void _innerPrint(message) {
//  print('$message');
}

//Future<String> zipEncoder(List filePaths) async {
//  String dataStr = '${DateTime.now().millisecondsSinceEpoch}';
//  final dirPath = '${Directory.systemTemp.path}/zip_out_$dataStr';
//  Directory dir = Directory(dirPath);
//  var zipFilePath = '${Directory.systemTemp.path}/zip_out_$dataStr.zip';
//
//  try {
//    if (dir.existsSync()) {
//      dir.deleteSync(recursive: true);
//    }
//    dir.createSync();
//
//    if (File(zipFilePath).existsSync()) {
//      File(zipFilePath).deleteSync();
//    }
//
//    for (var i = 0; i < filePaths.length; i++) {
//      var finePath = filePaths[i];
//      var curFile = File(finePath);
//      if (curFile.existsSync()) {
//        List arr = finePath.split('/');
//        var name = arr.last;
//        curFile.copySync('${dir.path}/${name}');
//      }
//    }
//
//    var encoder = ZipFileEncoder();
//    await encoder.zipDirectory(dir, filename: zipFilePath);
//  } catch (e) {
//    print('zipEncoder 异常, $e');
//    return null;
//  }
//
////  encoder.close();
//  _innerPrint('zipEncoder 成功: $zipFilePath');
//  return zipFilePath;
//}

Future<String?> zipEncoderDir(String dirPath) async {
  String newDirPath = dirPath ?? '';
  if (newDirPath.isEmpty) {
    print('zipEncoderDir , newDirPath === null');
    return null;
  }

  Directory dir = Directory(dirPath);
  var zipFilePath = '${Directory.systemTemp.path}/zip_out_${DateTime.now().millisecondsSinceEpoch}.zip';

  if (File(zipFilePath).existsSync()) {
    File(zipFilePath).deleteSync();
  }

  if (!dir.existsSync()) {
    print('zipEncoderDir, 目录不存在');
    return null;
  }
  try {
    var encoder = ZipFileEncoder();
    await encoder.zipDirectory(dir, filename: zipFilePath);
  } catch (e) {
    print('zipEncoder 异常, $e');
    return null;
  }
  _innerPrint('zipEncoderDir 成功: $zipFilePath');
  return zipFilePath;
}
