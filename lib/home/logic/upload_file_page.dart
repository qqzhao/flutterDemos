import 'dart:io';

// import 'package:file_uploader/file_uploader.dart';
import 'package:flutter/material.dart';
import 'package:hello/buttons/raise_button.dart';

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
File file6 = File('${tempDir.path}/6.mp4');

class _UploadFilePageState extends State<UploadFilePage> {
  bool switchOn = true;

  @override
  void initState() {
    super.initState();
    // initFiles();
    // FileUploader.init();
    // super.initState();
    // FileUploader.finishStream.listen((res) {
    //   print('taskId = ${res.taskId}');
    //   print('success = ${res.success}');
    // });
    //
    // FileUploader.progressStream.listen((res) {
    //   print('progressStream = ${res}');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('uploadFile test'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Switch.adaptive(
            onChanged: (value) {
              print('value = $value');
              setState(() {
                switchOn = !switchOn;
              });
              if (switchOn) {
                _config1();
              } else {
                _config2();
              }
            },
            value: switchOn,
          ),
          FlatButton(
            onPressed: uploadFile,
            child: Container(
              width: 100,
              height: 60,
              child: Text('tap me to upload'),
            ),
          ),
          FlatButton(
            onPressed: uploadFile2,
            child: Container(
              width: 100,
              height: 60,
              child: Text('tap me to upload2'),
            ),
          ),
          FlatButton(
            onPressed: uploadFile3,
            child: Container(
              width: 100,
              height: 60,
              child: Text('tap me to upload3'),
            ),
          ),
        ],
      )),
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

void _config1() async {
  // var config = FileUploaderConfig(url: 'http://localhost:3000/uploadFiles', archived: true, onWifiUse: true);
  // print('archived = true');
  // FileUploader.init(conf: config);
}

void _config2() async {
  // var config = FileUploaderConfig(url: 'http://localhost:3000/uploadFiles', archived: false, onWifiUse: true);
  // print('archived = false');
  // FileUploader.init(conf: config);
}

Future<void> uploadFile() async {
  print('uploadFile');
//  FileUploader.enqueue(
//    [file5.path],
//  );
//  FileUploader.enqueue([file1.path, file2.path]);
//   FileUploader.enqueue([file6.path], immediately: true);
//  FileUploader.enqueue([file1.path], immediately: true);
}

Future<void> uploadFile2() async {
  print('uploadFile2');
//  FileUploader.enqueue(
//    [file5.path],
//  );
//   String taskId = await FileUploader.enqueue([file1.path, file2.path], immediately: true);
//   print('taskId begin: $taskId');
}

Future<void> uploadFile3() async {
  print('uploadFile3');
//  FileUploader.enqueue(
//    [file5.path],
//  );
//   FileUploader.enqueue([file1.path], immediately: false);
}
