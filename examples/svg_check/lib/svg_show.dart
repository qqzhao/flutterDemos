import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:svg_check/svg_detail.dart';

class SvgShowPage extends StatefulWidget {
  final bool isLocal;
  final bool isAsset;
  final String path;
  SvgShowPage({
    this.isLocal,
    this.path,
    this.isAsset,
  });
  @override
  _SvgShowPageState createState() => _SvgShowPageState();
}

class _SvgShowPageState extends State<SvgShowPage> {
  final List<Widget> _painters = <Widget>[];
  double _dimension;

  Future<bool> _loadDocumentDirectory() async {
    Directory directory = Directory(widget.path); //await getApplicationDocumentsDirectory();

    var list = directory.listSync(recursive: true);
    var pathArray = list.map((item) => item.path).toList(growable: false);
    pathArray.sort((str1, str2) {
      return str1.compareTo(str2);
    });

    var exp = RegExp(r'(svg$)');
    _painters.clear();
    int index = 0;
    for (String path in pathArray) {
      if (exp.hasMatch(path)) {
        index++;
        print('path = $path');
        String fileName = path.split('/').last;
        _painters.add(Container(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return SvgDetailPage(
                      path: path,
                    );
                  },
                ),
              );
            },
            child: Stack(
              children: <Widget>[
                SvgPicture.file(File(path)),
                Positioned(
                  child: Container(
                    height: 20.0,
                    color: Color(0x7fff0000),
                    child: Text(
                      '$index, $fileName',
                      style: TextStyle(
                        fontSize: 9.0,
                      ),
                    ),
                  ),
                  bottom: 0.0,
                ),
              ],
            ),
          ),
        ));
      }
    }
    setState(() {});
    return true;
  }

  @override
  void initState() {
    super.initState();
    _dimension = 203.0;

    _loadDocumentDirectory();
  }

  @override
  Widget build(BuildContext context) {
    if (_dimension > MediaQuery.of(context).size.width - 10.0) {
      _dimension = MediaQuery.of(context).size.width - 10.0;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.path}'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Directory directory = Directory(widget.path);
              directory.deleteSync(recursive: true);
              _loadDocumentDirectory();
            },
            child: Text('删除'),
          ),
        ],
      ),
      body: Column(children: <Widget>[
        Slider(
            min: 5.0,
            max: MediaQuery.of(context).size.width - 10.0,
            value: _dimension,
            onChanged: (double val) {
              setState(() => _dimension = val);
            }),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: _dimension,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _painters[index];
            },
            padding: const EdgeInsets.all(4.0),
            itemCount: _painters.length,
          ),
        ),
      ]),
    );
  }
}
