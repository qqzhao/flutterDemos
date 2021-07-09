import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

double _textSizeWidth(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(text: TextSpan(text: text, style: style), maxLines: 1, textDirection: TextDirection.ltr)
    ..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size.width;
}

/// 显示评语内容组件，包含展示和收起按钮。
class CommentTextWrap extends StatefulWidget {
  final String? text;
  final double textSize;
  CommentTextWrap({
    this.text,
    this.textSize = 13.0,
  });
  @override
  _CommentTextWrapState createState() => _CommentTextWrapState();
}

class _CommentTextWrapState extends State<CommentTextWrap> {
  /// 如果是多行展示，是否展开
  bool showDetail = true;

  /// 是否是单行展示
  bool isSingleLine = true;
  late TapGestureRecognizer _tapGestureRecognizer;
  final GlobalKey _keyContainer = GlobalKey();

  @override
  void initState() {
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          showDetail = !showDetail;
        });
      };
    WidgetsBinding.instance!.addPostFrameCallback((value) => _getSizes());
    super.initState();
  }

  @override
  void didUpdateWidget(CommentTextWrap? oldWidget) {
    if (oldWidget != null && oldWidget.text != widget.text) {
      _getSizes();
    }
    print('didUpdateWidget');
    super.didUpdateWidget(oldWidget!);
  }

  void _getSizes() {
    print('_getSizes');
    final RenderBox renderContainer = _keyContainer.currentContext!.findRenderObject() as RenderBox;
    final sizeContain = renderContainer.size;

    var width = _textSizeWidth(
        widget.text ?? '',
        TextStyle(
          fontSize: widget.textSize,
        ));

    if (width > sizeContain.width && isSingleLine) {
      setState(() {
        isSingleLine = false;
      });
    }

    if (width < sizeContain.width && !isSingleLine) {
      setState(() {
        isSingleLine = true;
      });
    }

    print("SIZE of BOX:, $sizeContain ,$width, $isSingleLine");
  }

  @override
  Widget build(BuildContext context) {
    var _imageSpan = WidgetSpan(
        child: GestureDetector(
      onTap: _tapGestureRecognizer.onTap,
      child: Container(
        width: 16.0,
        height: 16.0,
        color: Colors.red,
        margin: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 5.0,
        ),
        child: Transform.rotate(
          angle: showDetail ? pi : 0,
          child: Icon(
            Icons.arrow_drop_down,
            size: 15,
          ),
        ),
      ),
    ));

    return Container(
      key: _keyContainer,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: RichText(
                /// iOS 上面会变小，所以这里进行缩放。
                textScaleFactor: MediaQuery.of(context).textScaleFactor,
                text: TextSpan(
                  text: widget.text,
                  style: TextStyle(
                    fontSize: widget.textSize,
                    color: Colors.white,
                  ),
//                  style: TextStyle(fontSize: widget.textSize, color: Colors.white, height: 1.6),
                  children: [if (showDetail && !isSingleLine) _imageSpan],
                ),
                maxLines: showDetail ? 50 : 1,
                overflow: isSingleLine ? TextOverflow.visible : TextOverflow.ellipsis,
              ),
            ),
          ),
          if (!showDetail && !isSingleLine)
            Container(
              padding: EdgeInsets.only(top: 3),
              child: RichText(
                textScaleFactor: MediaQuery.of(context).textScaleFactor,
                text: TextSpan(
                  children: [_imageSpan],
                ),
                maxLines: 1,
              ),
            ),
        ],
      ),
    );
  }
}
