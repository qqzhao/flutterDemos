import 'package:flutter/material.dart';
import 'package:hello/utils/text_size_cal.dart';

/// 给定一个固定大小的区域，可以智能的显示文本（列排版）：
/// * 可以智能的调整字体大小的显示
/// * 如果，小于或等于最小的字体，说明字体太多排不下，则增加滑动。
/// * 如果超出或等于最大字体，说明可以排版下，这时候使header和content还有bottom都居中显示。
class WisdomFitTextPage extends StatefulWidget {
  @override
  _WisdomFitTextPageState createState() => _WisdomFitTextPageState();
}

class _WisdomFitTextPageState extends State<WisdomFitTextPage> {
  String textString = 'init text';
  int appendIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test wisdom fit text'),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: 100.0 + 30.0 + 50.0,
          color: Colors.red[200],
          child: _FitTextBox(
            showText: textString,
            fixedHeightHeaderWidget: Container(
              width: 100.0,
              height: 30.0,
              color: Colors.blue,
            ),
            fixedHeightBottomWidget: Container(
              width: 100.0,
              height: 50.0,
              color: Colors.yellow[300],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          textString = textString + ' hello world, index($appendIndex)';
          appendIndex++;
          setState(() {});
        },
        child: Text('ADD'),
      ),
    );
  }
}

class _FitTextBox extends StatefulWidget {
  final String showText;
  final Widget fixedHeightHeaderWidget;
  final Widget fixedHeightBottomWidget;
  _FitTextBox({this.showText, this.fixedHeightHeaderWidget, this.fixedHeightBottomWidget});
  @override
  __FitTextBoxState createState() => __FitTextBoxState();
}

class __FitTextBoxState extends State<_FitTextBox> {
  double _realFontSize;
  bool _layoutReady = false;
  bool _needCenter = false;
  bool _needScroll = false;

  void _calculateAndSetFontSize(Size size) {
    print('size = $size');
    double retFontSize = TextSize.calculateFontSizeSync(
      size,
      widget.showText,
    );
    _realFontSize = retFontSize;
    if (_realFontSize >= TextSize.maxFontSize) {
      _needCenter = true;
    } else {
      _needCenter = false;
    }
    if (_realFontSize <= TextSize.minFontSize) {
      _needScroll = true;
    } else {
      _needScroll = false;
    }
    print('needCenter = $_needCenter');
    _layoutReady = true;

    Future.delayed(Duration(milliseconds: 0), () {
      setState(() {});
    });
//    setState(() {});
  }

  @override
  void didUpdateWidget(_FitTextBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
    if (oldWidget.showText != widget.showText) {
      _layoutReady = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('__FitTextBoxState build');

    var headerWidget = widget.fixedHeightHeaderWidget ?? Container();
    var bottomWidget = widget.fixedHeightBottomWidget ?? Container();
    if (!_layoutReady) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          headerWidget,
          Expanded(
            child: Container(
              child: LayoutBuilder(builder: (context, constraints) {
                _calculateAndSetFontSize(Size(constraints.maxWidth, constraints.maxHeight));
                return Container(
                  child: Text('empty'),
                );
              }),
            ),
          ),
          bottomWidget,
        ],
      );
    }

    Widget childWidget = Container(
      child: Center(
        child: Text(
          widget.showText,
          style: TextStyle(
            fontSize: _realFontSize,
          ),
        ),
      ),
    );

    if (_needScroll) {
      childWidget = SingleChildScrollView(
        child: childWidget,
      );
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          headerWidget,
          _needCenter
              ? childWidget
              : Expanded(
                  child: childWidget,
                ),
          bottomWidget,
        ],
      ),
    );
  }
}
