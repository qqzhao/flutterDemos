import 'package:flutter/material.dart';

class ImageCenterSlicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('ImageCenterSlicePage'),
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new Container(
              width: 200.0,
              height: 200.0,
              color: Colors.red,
              child: new Align(
                child: new Container(
                  width: 160.0,
                  height: 58.0,
                  color: Colors.blue,
                  child: Image.asset(
                    'assets/images/sound_bg.png',
                    fit: BoxFit.fill,
                    centerSlice: Rect.fromLTRB(54.0, 15.0, 56.0, 22.0),
//                    centerSlice: new Rect.fromCircle(center: const Offset(50.0, 27.0), radius: 1.0),
//                alignment: Alignment.bottomRight,
//                color: Colors.greenAccent,
                  ),
                ),
              ),
            ),
            new SizedBox(
              height: 10.0,
            ),
            new Container(
              width: 200.0,
              height: 200.0,
              color: Colors.red,
              child: new Align(
                child: new Container(
                  width: 160.0,
                  height: 34.0,
                  color: Colors.blue,
                  child: Image.asset(
                    'assets/images/sound_bg.png', // 115 * 34
                    fit: BoxFit.fill,
                    centerSlice: Rect.fromLTRB(48.0, 25.0, 52.0, 26.0),
//                    centerSlice: new Rect.fromCircle(center: const Offset(50.0, 27.0), radius: 2.0),
//                alignment: Alignment.bottomRight,
//                color: Colors.greenAccent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
