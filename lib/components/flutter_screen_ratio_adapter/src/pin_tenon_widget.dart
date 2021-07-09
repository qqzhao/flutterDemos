import 'package:flutter/material.dart';

import '../screen_ratio_adapter.dart';

class PinTenonWidget extends StatefulWidget {
  const PinTenonWidget();

  @override
  _PinTenonWidgetState createState() {
    return _PinTenonWidgetState();
  }
}

class _PinTenonWidgetState extends State<PinTenonWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    // setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (Info.instance.deltaLength <= 0) return SizedBox.fromSize(size: Size.zero);
    Widget result = const SizedBox();
    assert(() {
      result = Container(
          color: Colors.deepOrangeAccent, height: Info.instance.deltaLength, width: double.infinity, alignment: Alignment.center, child: Text('我是多余的'));
      return true;
    }());
    return SizedBox(height: Info.instance.deltaLength, width: double.infinity, child: result);
  }
}
