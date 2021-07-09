import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class OnlyOnePointerRecognizer extends OneSequenceGestureRecognizer {
  int _p = 0;
  @override
  void addPointer(PointerDownEvent event) {
    startTrackingPointer(event.pointer);
    if (_p == 0) {
      resolve(GestureDisposition.rejected);
      _p = event.pointer;
    } else {
      resolve(GestureDisposition.accepted);
    }
  }

  @override
  String get debugDescription => 'only one pointer recognizer';

  @override
  void didStopTrackingLastPointer(int pointer) {}

  @override
  void handleEvent(PointerEvent event) {
    if (!event.down && event.pointer == _p) {
      _p = 0;
    }
  }
}

class OnlyOnePointerRecognizerWidget extends StatelessWidget {
  final Widget? child;
  OnlyOnePointerRecognizerWidget({this.child});
  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        OnlyOnePointerRecognizer: GestureRecognizerFactoryWithHandlers<OnlyOnePointerRecognizer>(
          () => OnlyOnePointerRecognizer(),
          (OnlyOnePointerRecognizer instance) {},
        ),
      },
      child: child,
    );
  }
}

class OnlyOnePointerRecognizerWidget2 extends StatelessWidget {
  final int count;
  final Widget? child;
  OnlyOnePointerRecognizerWidget2({this.child, this.count = 0});

  Drag? _handleOnStart(Offset position) {
    if (count < 1) {
//      setState(() {
//        count++;
//      });
      return _DragHandler(_handleDragUpdate, _handleDragEnd);
    }
    return null;
  }

  void _handleDragUpdate(DragUpdateDetails update) {
    //code is here
  }

  void _handleDragEnd(DragEndDetails details) {
    //code is here
  }
//  setState(() {
//    count = 0;
//  });

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      behavior: HitTestBehavior.opaque,
      gestures: <Type, GestureRecognizerFactory>{
        ImmediateMultiDragGestureRecognizer: GestureRecognizerFactoryWithHandlers<ImmediateMultiDragGestureRecognizer>(
          () => ImmediateMultiDragGestureRecognizer(),
          (ImmediateMultiDragGestureRecognizer instance) {
            instance.onStart = _handleOnStart;
          },
        ),
      },
      child: child,
    );
  }
}

class _DragHandler extends Drag {
  _DragHandler(this.onUpdate, this.onEnd);

  final GestureDragUpdateCallback onUpdate;
  final GestureDragEndCallback onEnd;

  @override
  void update(DragUpdateDetails details) {
    onUpdate(details);
  }

  @override
  void end(DragEndDetails details) {
    onEnd(details);
  }

  @override
  void cancel() {}
}
