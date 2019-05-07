import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgDetailPage extends StatefulWidget {
  final String path;
  SvgDetailPage({
    this.path,
  });
  @override
  _SvgDetailPageState createState() => _SvgDetailPageState();
}

class _SvgDetailPageState extends State<SvgDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('detail'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Container(
                color: Color(0x1f000000),
                child: SvgPicture.file(
                  File(widget.path),
                  width: MediaQuery.of(context).size.width - 20,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text('${widget.path}'),
            )
          ],
        ),
      ),
    );
  }
}
