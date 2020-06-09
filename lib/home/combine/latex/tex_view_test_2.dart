import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

//class WebViewPlusExample extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: WebViewPlusExampleMainPage(),
//    );
//  }
//}

class WebViewPlusExampleMainPage extends StatefulWidget {
  @override
  _WebViewPlusExampleMainPageState createState() => _WebViewPlusExampleMainPageState();
}

class _WebViewPlusExampleMainPageState extends State<WebViewPlusExampleMainPage> {
  WebViewPlusController _controller;
  double _height = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('webview_flutter_plus Example'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: _height,
            child: WebViewPlus(
              onWebViewCreated: (controller) {
                this._controller = controller;
                controller.loadAsset('assets/html/testLatex/index.html');
              },
              onPageFinished: (url) {
                var containerName = 'exam-content';
                var script = """
getPlusHeight();
function getPlusHeight(){
var element = document.getElementsByClassName('$containerName')[0];
var height = element.offsetHeight,
    style = window.getComputedStyle(element);   
return ['top', 'bottom']
    .map(function (side) {
        return parseInt(style["margin-" + side]);
    })
    .reduce(function (total, side) {
        return total + side;
    }, height)}
                """;
                _controller.evaluateJavascript(script).then((string) {
                  print("string = $string");
                  var height = double.parse(string);
                  setState(() {
                    _height = height + 10;
                  });
                });
              },
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.redAccent,
              child: Center(
                child: Text('aaa'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
