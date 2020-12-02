import 'package:flutter/material.dart';

/// created by qqzhao on 2018/6/10
class FractionallBoxPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Container(
        color: Colors.blue,
        child: new Stack(
          fit: StackFit.expand,
// 会居于左上角，因为loose时候，宽高起作用。expand的时候或扩充到super大小。
//          fit: StackFit.loose,
          children: <Widget>[
            new FractionallySizedBox(
              child: new Container(
                color: Colors.red,
              ),
              widthFactor: 0.5,
              heightFactor: 0.5,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
