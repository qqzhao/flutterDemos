import 'dart:io';

import 'package:archive/archive_io.dart';

const zipName = 'zip_out.zip';

Future<String> zipEncoder(List filePaths) async {
  final dirPath = '${Directory.systemTemp.path}/zip_out';
  Directory dir = Directory(dirPath);
  var zipFilePath = '${Directory.systemTemp.path}/zip_out.zip';

  try {
    if (dir.existsSync()) {
      dir.deleteSync(recursive: true);
    }
    dir.createSync();

    if (File(zipFilePath).existsSync()) {
      File(zipFilePath).deleteSync();
    }

    for (var i = 0; i < filePaths.length; i++) {
      var finePath = filePaths[i];
      var curFile = File(finePath);
      if (curFile.existsSync()) {
        List arr = finePath.split('/');
        var name = arr.last;
        curFile.copySync('${dir.path}/${name}');
      }
    }

    var encoder = ZipFileEncoder();
    await encoder.zipDirectory(dir, filename: zipFilePath);
  } catch (e) {
    print('zipEncoder 异常, $e');
    return null;
  }

//  encoder.close();
  print('zipEncoder 成功, $zipFilePath');
  return zipFilePath;
}
