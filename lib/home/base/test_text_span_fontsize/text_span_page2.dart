import 'package:flutter/material.dart';
import 'package:hello/home/base/test_text_span_fontsize/comment_text_wrap.dart';

class TextSpanPage2 extends StatefulWidget {
  @override
  _TextSpanPage2State createState() => _TextSpanPage2State();
}

class _TextSpanPage2State extends State<TextSpanPage2> {
  String inputText = '答案解析范德萨范';
  double verticalSpace = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Center(
              child: Text(
                '答案解析',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
          Container(
            color: Colors.blue,

            /// 这里修改，但是有问题。
            padding: EdgeInsets.symmetric(vertical: verticalSpace > 0 ? 0.0 : 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    width: 10.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          color: Colors.red,
//                          height: 22,
                          padding: EdgeInsets.only(right: 0),
                          margin: EdgeInsets.only(top: verticalSpace),
                          child: RichText(
//                            textScaleFactor: 1.0,
                            text: WidgetSpan(
                              child: Icon(
                                Icons.apps,
                                size: 17.5,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: true,
                          child: Container(
                            color: Colors.red,

                            /// iOS 上面，这里需要22。 Android: 可以根据不通的设备去修改这个高度值
                            /// 根本原因是不同设备的行高不一样
//                          height: 22,
                            padding: EdgeInsets.only(right: 0),
                            margin: EdgeInsets.only(top: verticalSpace),
                            child: Icon(
                              Icons.apps,
                              size: 17.5,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.yellow,
                            padding: EdgeInsets.symmetric(vertical: verticalSpace),
                            child: CommentTextWrap(
                              text: inputText,
                              textSize: 13.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10, top: verticalSpace),
                  child: Text(
                    '答案解析',
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            inputText = '答案解析范德萨范' == inputText ? '答案解析范德萨范答案解析范德萨范答案解析范德萨范答案解析范德萨范222' : '答案解析范德萨范';
          });
        },
      ),
    );
  }
}
