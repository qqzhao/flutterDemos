import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:z_tools/z_tools.dart';

void main() {
  test('tcrBase64Encode & tcrBase64Decode', () async {
    const String _string = 'one-two-three';
    String encodeStr = _string.tcrBase64Encode;
    expect(encodeStr, 'b25lLXR3by10aHJlZQ==');

    String str = encodeStr.tcrBase64Decode;
    expect(str, _string);
  });

  test('tcrGetUpdateUrl', () async {
    String url1 = 'https://baidu.com';
    String url1Update = url1.tcrGetUpdateUrl;
    print('url1Update = $url1Update');

    url1 = 'https://baidu.com?aa=bb';
    url1Update = url1.tcrGetUpdateUrl;
    print('url1Update = $url1Update');

    url1 = 'https://baidu.com?aa=bb&';
    url1Update = url1.tcrGetUpdateUrl;
    print('url1Update = $url1Update');

    url1 = 'https://baidu.com?';
    url1Update = url1.tcrGetUpdateUrl;
    print('url1Update = $url1Update');
  });

  test('textSizeHeight', () async {
    String text = 'are you ready ,how are you. I am from China.';
    double height = text.textSizeHeight();
    print('height = $height');

    height = text.textSizeHeight(style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), maxWidth: 100);
    print('height = $height');
    expect(height, 144.0);

    height = text.textSizeHeight(style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), maxWidth: 100);
    print('height = $height');
    expect(height, 180.0);

    height = text.textSizeHeight(style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), maxWidth: 50);
    print('height = $height');
    expect(height, 360.0);
  });

  test('textSizeWidthContext', () async {
    String text = 'are you ready ,how are you. I am from China.';
    double width = text.textSizeWidthContext();
    print('width = $width');

    width = text.textSizeWidthContext(style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
    print('width = $width');
    expect(width, 704.0);

    width = text.textSizeWidthContext(style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
    print('width = $width');
    expect(width, 792.0);

    width = text.textSizeWidthContext(style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold));
    print('width = $width');
    expect(width, 528.0);
  });
}
