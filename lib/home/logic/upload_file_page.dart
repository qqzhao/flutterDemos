import 'dart:io';

import 'package:file_uploader/file_uploader.dart';
import 'package:flutter/material.dart';

class UploadFilePage extends StatefulWidget {
  @override
  _UploadFilePageState createState() => _UploadFilePageState();
}

Directory tempDir = Directory.systemTemp;
File file1 = File('${tempDir.path}/1.txt');
File file2 = File('${tempDir.path}/2.txt');
File file3 = File('${tempDir.path}/3.txt');
File file4 = File('${tempDir.path}/4.txt');
File file5 = File('${tempDir.path}/5.txt');

class _UploadFilePageState extends State<UploadFilePage> {
  @override
  void initState() {
    initFiles();
    FileUploader.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('uploadFile test'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            uploadFile();
          },
          child: Container(
            width: 100,
            height: 100,
            color: Colors.red,
            child: Text('tap me to upload'),
          ),
        ),
      ),
    );
  }
}

Future<void> initFiles() async {
  print('initFiles');
  file1.writeAsStringSync(('1111 fdsakj fdsjal fsaljf alsjfalk sfdalf dsl '));
  file2.writeAsStringSync(('2222 fdsakj fdsjal fsaljf alsjfalk sfdalf dsl '));
  file3.writeAsStringSync(('3333 fdsakj fdsjal fsaljf alsjfalk sfdalf dsl '));
  file4.writeAsStringSync(('4444 fdsakj fdsjal fsaljf alsjfalk sfdalf dsl '));
}

Future<void> uploadFile() async {
  print('uploadFile');
  FileUploader.enqueue(
    [file5.path],
  );
  FileUploader.enqueue([file1.path, file2.path]);
}
