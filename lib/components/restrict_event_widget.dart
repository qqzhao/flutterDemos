import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// restrictEvent widget
/// 不支持双击，长按等事件
/// restrictDuration 指定多久内不允许再次接收事件。
class TapRestrictEventWidget extends SingleChildRenderObjectWidget {
  const TapRestrictEventWidget({
    Key key,
    this.ignoringSemantics,
    this.restrictDuration = const Duration(milliseconds: 100),
    Widget child,
  }) : super(key: key, child: child);

  final Duration restrictDuration;
  final bool ignoringSemantics;

  @override
  RenderRestrictEvent createRenderObject(BuildContext context) {
    return RenderRestrictEvent(
      restrictDuration: restrictDuration,
      ignoringSemantics: ignoringSemantics,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderRestrictEvent renderObject) {
    renderObject..ignoringSemantics = ignoringSemantics;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
//    properties.add(DiagnosticsProperty<bool>('ignoring', ignoring));
    properties.add(DiagnosticsProperty<bool>('restrictEventSemantics', ignoringSemantics, defaultValue: null));
  }
}

class RenderRestrictEvent extends RenderProxyBox {
  RenderRestrictEvent({
    RenderBox child,
    @required Duration restrictDuration,
    bool ignoringSemantics,
  })  : assert(restrictDuration != null),
        _ignoringSemantics = ignoringSemantics,
        _restrictDuration = restrictDuration,
        super(child);

  bool get ignoringSemantics => _ignoringSemantics;

  DateTime _lastResponseTime = DateTime.now();

  bool _ignoringSemantics;
  final Duration _restrictDuration;

  set ignoringSemantics(bool value) {
    if (value == _ignoringSemantics) return;
    final bool oldEffectiveValue = _effectiveIgnoringSemantics;
    _ignoringSemantics = value;
    if (oldEffectiveValue != _effectiveIgnoringSemantics) markNeedsSemanticsUpdate();
  }

  bool get _effectiveIgnoringSemantics => ignoringSemantics;

  bool get _canResponseEvent {
    if (_lastResponseTime == null) {
      _lastResponseTime = DateTime.now();
      return true;
    }

    if (DateTime.now().difference(_lastResponseTime).compareTo(_restrictDuration) >= 0) {
      _lastResponseTime = DateTime.now();
//      print('execute event');
      return true;
    }
//    print('ignore event');
    return false;
  }

  @override
  bool hitTest(BoxHitTestResult result, {Offset position}) {
    return _canResponseEvent && super.hitTest(result, position: position);
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    if (child != null && !_effectiveIgnoringSemantics) visitor(child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
//    properties.add(DiagnosticsProperty<bool>('absorbing', absorbing));
    properties.add(
      DiagnosticsProperty<bool>(
        'ignoringSemantics',
        _effectiveIgnoringSemantics,
        description: ignoringSemantics == null ? 'implicitly $_effectiveIgnoringSemantics' : null,
      ),
    );
  }
}
