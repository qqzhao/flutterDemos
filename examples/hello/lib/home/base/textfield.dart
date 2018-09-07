import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../logic/config_temp.dart' as config;
import 'package:hello/home/logic/config_temp.dart' as config2;

class TextFieldPage extends StatelessWidget {

  void test(){
    print('config origin= ${config.testVar}');
    print('config2 origin= ${config2.testVar}');
    config.testVar = '345 in textField';
    print('config = ${config.testVar}');
    print('config2 = ${config2.testVar}');
  }
  @override
  Widget build(BuildContext context) {

    test();
    Widget textField = TextField(
      maxLines: null,
      keyboardType: TextInputType.multiline,
      controller: new TextEditingController(
          text: 'fdak dfasjk fdjaskl fdasjklj'
      ),
    );

    Widget container = new Center(
      child: new Container(
        width: 200.0,
        height: 200.0,
        color: Colors.red,
        child: textField,
      ),
    );

    return container;
  }
}
