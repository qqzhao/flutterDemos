import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class GestureTestPage extends StatefulWidget {
  @override
  _GestureTestPageState createState() => _GestureTestPageState();
}

class _GestureTestPageState extends State<GestureTestPage> {
  @override
  void initState() {
    debugPrintGestureArenaDiagnostics = true;
    debugPrintRecognizerCallbacksTrace = true;
    debugPrintHitTestResults = true;
    super.initState();
  }

  @override
  void dispose() {
    debugPrintGestureArenaDiagnostics = false;
    debugPrintRecognizerCallbacksTrace = false;
    debugPrintHitTestResults = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test gesture'),
      ),
      body: Column(
        children: <Widget>[
          TestGestureWidget(),
        ],
      ),
    );
  }
}

class TestGestureWidget extends StatelessWidget {
  /// 输出 ontap 1
  Widget build12(BuildContext context) {
    return Container(
//      color: Colors.lightBlue,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            child: Container(
              width: 200.0,
              height: 200.0,
              color: Colors.red,
            ),
            onTap: () {
              print('ontap 1');
            },
          ),
          Positioned(
            left: 0,
            top: 0,
            child: GestureDetector(
              child: IgnorePointer(
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.blue,
                ),
              ),
//              onTap: () {
//                print('ontap 2');
//              },
            ),
          ),
        ],
      ),
    );
  }

  /// 不输出 ontap 1
  Widget build11(BuildContext context) {
    return Container(
      width: 300.0,
      height: 300.0,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GestureDetector(
            child: Container(
              color: Colors.red,
            ),
            onTap: () {
              print('ontap 1');
            },
          ),
          IgnorePointer(
            ignoring: false,
            child: Container(
              width: 100.0,
              height: 100.0,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }

  /// 外部依然可以响应
  Widget build10(BuildContext context) {
    return GestureDetector(
//      behavior: HitTestBehavior.translucent,
      child: Container(
        width: 200.0,
        height: 200.0,
        color: Colors.yellow,
        child: IgnorePointer(
          child: GestureDetector(
//            onTap: () {
//              print('inner ontap');
//            },
            child: Center(
              child: Container(
                width: 100.0,
                height: 100.0,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        print('ontap outer');
      },
    );
  }

  /// Container/SizeBox 没有 child的时候，HitTestBehavior.opaque也会响应事件。
  /// 如果，有child，一直都会响应事件。
  Widget build9(BuildContext context) {
    return GestureDetector(
//      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        width: 200.0,
        height: 200.0,
        child: Text('build9'),
//        color: Colors.yellow,
      ),
      onTap: () {
        print('ontap');
      },
    );
  }

  /// 只有子widget会接收点击事件， behavior的设置不起作用
  Widget build8(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 200.0,
        height: 200.0,
        color: Colors.blue,
        child: Center(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Container(
              width: 100.0,
              height: 100.0,
              color: Colors.yellow,
            ),
            onTap: () {
              print('inner tap');
            },
          ),
        ),
      ),
      onTap: () {
        print('outer tap');
      },
    );
  }

  /// 内外都会接收tap down事件(有时候外部能够接收，有时候不能接收？？)
  Widget build7(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 200.0,
        height: 200.0,
        color: Colors.blue,
        child: Center(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Container(
              width: 100.0,
              height: 100.0,
              color: Colors.yellow,
            ),
            onTapDown: (_) {
              print('inner tapdown');
            },
          ),
        ),
      ),
      onTapDown: (_) {
        print('outer tap down');
      },
    );
  }

  Widget build6(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GestureDetector(
        child: ConstrainedBox(
          constraints: BoxConstraints.tight(Size(300.0, 200.0)),
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
              child: GestureDetector(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(Size(200.0, 100.0)),
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.yellow),
                  ),
                ),
                onTap: () {
                  print("down inner");
                },
                behavior: HitTestBehavior.translucent,
              ),
            ),
          ),
        ),
        onTap: () {
          print("down outer");
        },
      ),
    );
  }

  /// HitTestBehavior如何设置，都会接收
  Widget build5(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: Listener(
          child: Container(
            width: 200.0,
            height: 200.0,
            color: Colors.yellow,
            child: Center(
              child: Listener(
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.blue,
                ),
                onPointerDown: (_) {
                  print('inner tapdown');
                },
              ),
            ),
          ),
          onPointerDown: (_) {
            print('outer tapdown');
          },
        ),
      ),
    );
  }

  /// 不会接收，只有down1
  Widget build4(BuildContext context) {
    print('aaa build4');
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          Listener(
            child: ConstrainedBox(
              constraints: BoxConstraints.tight(Size(300.0, 200.0)),
              child: DecoratedBox(decoration: BoxDecoration(color: Colors.blue)),
            ),
            onPointerDown: (event) {
              print("down0");
            },
            behavior: HitTestBehavior.translucent,
          ),
          Listener(
            child: ConstrainedBox(
                constraints: BoxConstraints.tight(Size(200.0, 100.0)),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.yellow),
                )),
            onPointerDown: (event) {
              print("down1");
            },
            behavior: HitTestBehavior.translucent,
          )
        ],
      ),
    );
  }

  Widget build3(BuildContext context) {
    return MaterialApp(
      home: Container(
        child: Stack(
          children: [
            Listener(
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(Size(300.0, 200.0)),
                child: DecoratedBox(decoration: BoxDecoration(color: Colors.blue)),
              ),
              onPointerDown: (event) => print("down0"),
              behavior: HitTestBehavior.translucent,
            ),
            Listener(
              child: ConstrainedBox(
                  constraints: BoxConstraints.tight(Size(200.0, 100.0)),
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.yellow),
                  )),
              onPointerDown: (event) {
                print("down1");
              },
              behavior: HitTestBehavior.translucent,
            )
          ],
        ),
      ),
    );
  }

  Widget build13(BuildContext context) {
    return WrapListen(
      width: 300.0,
      height: 300.0,
      color: Colors.blue,
      name: 'outer',
      child: IgnorePointer(
        child: WrapListen(
          width: 200.0,
          height: 200.0,
          color: Colors.red,
          name: 'middle',
          child: WrapListen(
            width: 100.0,
            height: 100.0,
            color: Colors.green,
            name: 'inner',
          ),
        ),
      ),
    );
  }

  Widget build14(BuildContext context) {
    return Stack(
      children: <Widget>[
        WrapListen(
          width: 300.0,
          height: 300.0,
          color: Colors.blue,
          name: 'lower',
        ),
//        AbsorbPointer(
//          child: WrapListen(
//            width: 200.0,
//            height: 200.0,
//            color: Colors.yellow,
//            name: 'middle',
//          ),
//        ),
        Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: (_) {
            print('onPointerDown outer');
          },
          child: WrapListen(
            width: 100.0,
            height: 100.0,
            color: Colors.red,
            name: 'upper',
          ),
        ),
      ],
    );
  }

  Widget build15(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => print('onTapDown'),
      onTapUp: (_) => print('onTapUp'),
      onTap: () => print('onTap'),
      onLongPress: () => print('onLongPress'),
      onDoubleTap: () => print('onDoubleTap'),
      child: Container(
        width: 300.0,
        height: 300.0,
        color: Colors.red,
      ),
    );
//    return Listener(
//      onPointerDown: (_) => print('onPointerDown'),
//      onPointerUp: (_) => print('onPointerUp'),
//      child: GestureDetector(
//        onTapDown: (_) => print('onTapDown'),
//        onTapUp: (_) => print('onTapUp'),
//        onTap: () => print('onTap'),
//        onLongPress: () => print('onLongPress'),
//        onDoubleTap: () => print('onDoubleTap'),
//        child: Container(
//          width: 300.0,
//          height: 300.0,
//          color: Colors.red,
//        ),
//      ),
//    );
  }

  Widget build16(BuildContext context) {
    return Listener(
      child: GestureDetector(
        onTapDown: (_) => print('outer onTapDown'),
//        onTapUp: (_) => print('onTapUp'),
//        onTap: () => print('onTap'),
//        onLongPress: () => print('onLongPress'),
//        onDoubleTap: () => print('onDoubleTap'),
        child: Container(
          width: 300.0,
          height: 300.0,
          color: Colors.red,
          child: GestureDetector(
            onTapDown: (_) => print('inner tap down'),
            onLongPress: () => print('onLongPress'),
            onHorizontalDragUpdate: (_) => print('onHorizontalDragUpdate'),
            child: Center(
              child: Container(
                width: 100.0,
                height: 100.0,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DemoApp();
  }
}

class WrapListen extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final Color color;
  final Function onTap;
  final String name;

  WrapListen({
    this.width,
    this.height,
    this.child,
    this.color,
    this.onTap,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (_) {
          print('onPointerDown2: $name');
        },
        onPointerUp: (_) {
          print('onPointerUp: $name');
        },
        child: Container(
          width: width,
          height: height,
          color: color,
          child: child,
        ),
      ),
    );
  }
}

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultipleGestureWidget(
      onTap: () {
        print('outer taped');
      },
      child: Container(
        color: Colors.green,
        child: Center(
          //Now, wraps the second container in RawGestureDetector
          child: GestureDetector(
            onTap: () {
              print('inner taped');
            },
            child: Container(
              color: Colors.deepOrange,
              width: 250.0,
              height: 350.0,
            ),
          ),
        ),
      ),
    );
  }
}

class MultipleGestureWidget extends StatelessWidget {
  final Widget child;
  final Function onTap;
  MultipleGestureWidget({
    this.child,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        AllowMultipleGestureRecognizer: GestureRecognizerFactoryWithHandlers<AllowMultipleGestureRecognizer>(
          () => AllowMultipleGestureRecognizer(), //constructor
          (AllowMultipleGestureRecognizer instance) {
            //initializer
            instance.onTap = onTap;
          },
        )
      },
      //Creates the nested container within the first.
      child: child,
    );
  }
}

class AllowMultipleGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}
