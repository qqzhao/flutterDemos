import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';




Widget container = new Center(
  child: new Container(
    width: 200.0,
    height: 200.0,
    color: Colors.red,
    child: textField,
  ),
);

Widget textField = TextField(
  maxLines: null,
  keyboardType: TextInputType.multiline,
  controller: new TextEditingController(
      text: 'fdak dfasjk fdjaskl fdasjklj'
  ),
);
