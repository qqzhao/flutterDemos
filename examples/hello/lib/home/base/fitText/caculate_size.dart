import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CaculatePage extends StatefulWidget {
  @override
  _CaculatePageState createState() => _CaculatePageState();
}

class _CaculatePageState extends State<CaculatePage> {
  final controller = new ScrollController();
  OverlayEntry sticky;
  GlobalKey stickyKey = new GlobalKey();
  Timer myTimer;

  String testString = '111 jfdal ljdf lasjflkas jfdlkajflksdajflkasjfksjalfkjsalkfjsakl \n fkjdsaljfalkjf asjkfdjaslfj a';
  double testHeight = 30.0;

  @override
  void initState() {
    if (sticky != null) {
      sticky.remove();
    }
    sticky = new OverlayEntry(
        opaque: false,
        // lambda created to help working with hot-reload
//      builder: (context) => stickyBuilder(context),
        builder: (context) {
          return new Center(
            child: new Container(
              width: 100.0,
              height: 100.0,
              child: new Text('aaa'),
            ),
          );
        });

    // not possible insite initState
    SchedulerBinding.instance.addPostFrameCallback((_) {
      print('addPostFrameCallback callback');
      Overlay.of(context).insert(sticky);

      final keyContext = stickyKey.currentContext;
      if (keyContext != null) {
        final RenderBox box = keyContext.findRenderObject();
        print('box size = ${box.size}');
      }
    });

    myTimer = Timer.periodic(new Duration(seconds: 2), (_) {
      setState(() {
        testString = testString + '22';
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
    return new Scaffold(
      body: new ListView.builder(
        controller: controller,
        itemBuilder: (context, index) {
          if (index == 6) {
//            return new Container(
//              key: stickyKey,
//              height: 100.0,
//              color: Colors.green,
//              child: new Text("I'm fat: $testString"),
//            );
            return new CaculateBox(
              callback: (Size size) {
                print('xxx size = $size');
                setState(() {
                  testHeight = size.height;
                });
              },
              child: new Container(
//                height: 200.0,
                height: testHeight + 40.0,
                child: new Text('$testString'),
              ),
            );
          } else if (index == 7) {
            return new Container(
              alignment: Alignment.center,
              color: Colors.red,
              height: testHeight + 40.0,
              child: new Text('$testString'),
            );
          }
          return new ListTile(
            title: new Text('Hello $index'),
          );
        },
      ),
    );
  }

//  Widget stickyBuilder(BuildContext context) {
//    return new AnimatedBuilder(
//      animation: controller,
//      builder: (_, child) {
//        final keyContext = stickyKey.currentContext;
//        if (keyContext != null) {
//          // widget is visible
//          final RenderBox box = keyContext.findRenderObject();
//          final pos = box.localToGlobal(Offset.zero);
//          return new Positioned(
//            top: pos.dy + box.size.height,
//            left: 50.0,
//            right: 50.0,
//            height: box.size.height,
//            child: new Material(
//              child: new Container(
//                alignment: Alignment.center,
//                color: Colors.purple,
//                child: new Text("^ Nah I think you're Okey"),
//              ),
//            ),
//          );
//        }
//        return new Offstage();
//      },
//    );
//  }
}

typedef FrameCallback = void Function(Size size);

/// 问题： addPostFrameCallback 回调机制。只会调用一次。
class CaculateBox extends StatefulWidget {
  CaculateBox({this.child, this.callback});

  final Widget child;
  FrameCallback callback;

  @override
  _CaculateBoxState createState() => _CaculateBoxState();
}

class _CaculateBoxState extends State<CaculateBox> {
  GlobalKey caculateKey = new GlobalKey();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final keyContext = caculateKey.currentContext;
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: caculateKey,
      child: widget.child,
    );
  }
}
