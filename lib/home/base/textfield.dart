import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello/components/text_field/custom_text_field.dart';

class TextFieldPage extends StatefulWidget {
  @override
  _TextFieldPageState createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  TextEditingController _editingController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    var fontSize = 20.0;
    return Scaffold(
      appBar: AppBar(
        title: Text('test text field'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                minHeight: 200,
              ),
              child: CustomTextField(
                maxLines: null,
                style: TextStyle(fontSize: fontSize, color: Colors.black, height: (22 / fontSize)),
                decoration: InputDecoration(
                  hintText: '请在这里输入文字',
                  hintStyle: TextStyle(fontSize: fontSize, color: Colors.black.withOpacity(0.3)),
                  border: InputBorder.none,
                  // TODO: How to avoid clipping of vertical padding?
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                keyboardType: TextInputType.multiline,
                controller: _editingController,
              ),
            ),
          ),
          Container(
            height: 80,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
//                    FocusScopeNode().requestFocus();
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Container(
                    color: Colors.red,
                    width: 80,
                    height: 80,
                    child: Text('111'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
