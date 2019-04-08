import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../../components/popview.dart';

String selectedUrl = "https://flutter.io";
const kAndroidUserAgent =
    "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36";

class PopViewPage extends StatefulWidget {
  @override
  _PopViewPageState createState() => _PopViewPageState();
}

class _PopViewPageState extends State<PopViewPage> {
  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Center(
        child: new GestureDetector(
          onTap: () async {
            print('123494390');
            var child = new GestureDetector(
              onTap: () {
                print('aaa');
              },
              child: new Container(
                child: new WebviewScaffold(
                  url: selectedUrl,
                  appBar: new AppBar(
                    title: new Text("Widget webview"),
                  ),
                  withZoom: true,
                  withLocalStorage: true,
                ),
                width: MediaQuery.of(context).size.width,
                height: 150.0,
                color: Colors.blue,
              ),
            );
            var ret = await showPopView(context: context, child: child);
            print('ret = $ret');
          },
          child: new Center(
            child: new Text('click me'),
          ),
        ),
      ),
    );
  }
}
