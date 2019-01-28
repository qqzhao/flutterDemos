import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

var url = 'http://cms-bucket.ws.126.net/2019/01/28/a3faf186ebe34a849d25ea462e23af8e.jpeg?imageView&thumbnail=550x0';

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
          child: new Image.network('$url'),
        ),
      ),
    );
  }
}
