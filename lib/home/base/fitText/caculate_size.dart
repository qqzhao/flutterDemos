import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CalculatePage extends StatefulWidget {
  @override
  _CalculatePageState createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  final controller = ScrollController();
  OverlayEntry sticky;
  GlobalKey stickyKey = GlobalKey();
  Timer myTimer;

  String testString = 'hello world. this is a long sentence. Please waiting for a moment.';
  double testHeight = 30.0;
  int appendIndex = 0;

  @override
  void initState() {
    if (sticky != null) {
      sticky.remove();
    }

    /// 初始化OverlayEntry实体， 覆盖到顶层。这里没用。
    sticky = OverlayEntry(
      opaque: false,
      builder: (context) {
        return Center(
          child: Opacity(
            opacity: 0.2,
            child: Material(
              child: Text('这是水印,~~~'),
            ),
          ),
        );
      },
    );

    /// not possible inside initState
    /// 帧回调后，将上面的overlay实体插入到构建树中
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        print('addPostFrameCallback callback');
        Overlay.of(context).insert(sticky);

        final keyContext = stickyKey.currentContext;
        if (keyContext != null) {
          final RenderBox box = keyContext.findRenderObject();
          print('box size = ${box.size}');
        }
      },
    );

    myTimer = Timer.periodic(Duration(seconds: 2), (_) {
      setState(() {
        testString = testString + 'append index = $appendIndex;';
        appendIndex++;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    // remove possible overlays on dispose. As they would be visible even after [Navigator.push]
    myTimer.cancel();
    sticky.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: controller,
        itemBuilder: (context, index) {
          if (index == 6) {
            return CalculateBox(
              callback: (Size size) {
                print('xxx size = $size');
                setState(() {
                  testHeight = size.height;
                });
              },
              child: Container(
//                height: 200.0,
                height: testHeight + 40.0,
                child: Text('$testString'),
              ),
            );
          } else if (index == 7) {
            return Container(
              alignment: Alignment.center,
              color: Colors.red,
              height: testHeight + 40.0,
              child: Text('$testString'),
            );
          }
          return ListTile(
            title: Text('Hello $index'),
          );
        },
      ),
    );
  }
}

typedef FrameCallback = void Function(Size size);

/// 希望通过CalculateBox，计算出高度。可以在其他地方使用。
/// 但是 addPostFrameCallback 回调机制。只会调用一次。
/// 所以，不能动态变化。
/// 如果只是修改一次，倒是可以满足，但是没有必要。
class CalculateBox extends StatefulWidget {
  CalculateBox({this.child, this.callback});

  final Widget child;
  final FrameCallback callback;

  @override
  _CalculateBoxState createState() => _CalculateBoxState();
}

class _CalculateBoxState extends State<CalculateBox> {
  GlobalKey calculateKey = GlobalKey();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final keyContext = calculateKey.currentContext;
      if (keyContext != null) {
        final RenderBox box = keyContext.findRenderObject();
        print('box size = ${box.size}');
        if (widget.callback is FrameCallback) {
          widget.callback(box.size);
        }
      }
    });
//    // 每一帧回调只会都会执行
//    SchedulerBinding.instance.addPersistentFrameCallback((aaa) {
//      print('aaa = $aaa');
//    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: calculateKey,
      child: widget.child,
    );
  }
}
