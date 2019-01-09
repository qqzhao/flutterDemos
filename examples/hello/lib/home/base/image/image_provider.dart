import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
          child: new Container(
              child: Image.asset(
            'assets/images/sound_bg.png',
            fit: BoxFit.contain,
          )),
        ),
      ),
    );
  }
}
