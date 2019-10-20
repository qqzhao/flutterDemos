import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:file_uploader/file_uploader.dart';

void main() {
  const MethodChannel channel = MethodChannel('file_uploader');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

//  test('getPlatformVersion', () async {
//    expect(await FileUploader.init(), '42');
//  });
}
