import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

String url = 'http://cms-bucket.ws.126.net/2019/01/28/a3faf186ebe34a849d25ea462e23af8e.jpeg?imageView&thumbnail=550x0';

class TestAssetBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async {
    print('TestAssetBundle:key=$key');
    if (key == 'resources/test') return ByteData.view(Uint8List.fromList(utf8.encode('Hello World!')).buffer);
//    return null;
    return rootBundle.load(key);
  }
}

class ImageProviderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('text imageprovider'),
      ),
      body: new Center(
        child: new Container(
          width: 200.0,
          height: 200.0,
          color: Colors.purple,
//          child: new Container(
//              child: Image.asset(
//            'assets/images/sound_bg.png',
//            fit: BoxFit.contain,
//          )),
//          child: new Image.network('$url'),
          child: new DefaultAssetBundle(
              bundle: new TestAssetBundle(),
              child: new Column(
                children: <Widget>[
                  new Container(
                      child: Image.asset(
                    'assets/images/sound_bg.png',
                    fit: BoxFit.contain,
                  )),
                  new TextWidget(
                    resource: 'resources/test',
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class TextWidget extends StatefulWidget {
  final String resource;
  TextWidget({@required this.resource});

  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  var _string;

  @override
  void initState() {
    super.initState();
    Timer(new Duration(milliseconds: 100), () {
      var a = DefaultAssetBundle.of(context).load(widget.resource);
      var b = DefaultAssetBundle.of(context).loadString(widget.resource);
      b.then((strValue) {
        print('bValue = $strValue');
        setState(() {
          _string = strValue;
        });
      });
      a.then((ByteData value) {
        var str = utf8.decode(value.buffer.asUint8List());
        print('aValue = $str');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Text('$_string'),
    );
  }
}
