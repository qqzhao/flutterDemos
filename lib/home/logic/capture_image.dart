import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui show ImageByteFormat, Image;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class TestCaptureImage extends StatefulWidget {
  @override
  _TestCaptureImageState createState() => _TestCaptureImageState();
}

class _TestCaptureImageState extends State<TestCaptureImage> {
  GlobalKey globalKey = new GlobalKey();

  // 截图boundary，并且返回图片的二进制数据。
  Future<Uint8List> _capturePng() async {
    RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject() as RenderRepaintBoundary;
    // pixelRatio 设置截图的清晰程度。但宽高也相应翻倍了。
    ui.Image image = await boundary.toImage(pixelRatio: 2.0);

    print('image width = ${image.width}');
    print('image height = ${image.height}');
    // 注意：png是压缩后格式，如果需要图片的原始像素数据，请使用rawRgba
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    Directory directory = await getTemporaryDirectory();
    print('directory = $directory');
    var path = join(directory.path, 'test.png');
    File file = File(path);
    file.writeAsBytes(pngBytes, flush: true);
    return pngBytes;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('test capture image'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RepaintBoundary(
              key: globalKey,
              child: Container(
                width: 100.0,
                height: 100.0,
                color: Colors.blue,
                child: Text(
                  'capture image test png',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _capturePng,
        child: const Icon(
          Icons.school,
          color: Colors.white,
        ),
      ),
    ));
  }
}
