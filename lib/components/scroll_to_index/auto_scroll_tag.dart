import 'package:flutter/material.dart';
import 'package:hello/components/scroll_to_index/util.dart';

import 'scroll_to_index.dart';

Map<AutoScrollTagState, AnimationController?> _highlights = <AutoScrollTagState, AnimationController?>{};
const _highlightDuration = Duration(seconds: 3);

var cancelAllHighlightsExport = _cancelAllHighlights;

void _cancelAllHighlights([AutoScrollTagState? state]) {
  for (final tag in _highlights.keys) {
    tag._cancelController(reset: tag != state);
  }

  _highlights.clear();
}

class AutoScrollTag extends StatefulWidget {
  final AutoScrollController controller;
  final int index;
  final Widget? child;
  final Color? color;
  final Color? highlightColor;
  final bool disabled; // 决定功能是否生效，可以设置不添加到 tagMap 中。

  AutoScrollTag({required Key key, required this.controller, required this.index, required this.child, this.color, this.highlightColor, this.disabled = false})
      : super(key: key);

  @override
  AutoScrollTagState createState() {
    return new AutoScrollTagState<AutoScrollTag>();
  }
}

class AutoScrollTagState<W extends AutoScrollTag> extends State<W> with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    if (!widget.disabled) {
      register(widget.index);
    }
  }

  @override
  void dispose() {
    _cancelController();
    if (!widget.disabled) {
      unregister(widget.index);
    }
    _controller = null;
    _highlights.remove(this);
    super.dispose();
  }

  @override
  void didUpdateWidget(W oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index || oldWidget.key != widget.key || oldWidget.disabled != widget.disabled) {
      if (!oldWidget.disabled) unregister(oldWidget.index);

      if (!widget.disabled) register(widget.index);
    }
  }

  void register(int index) {
    // the caller in initState() or dispose() is not in the order of first dispose and init
    // so we can't assert there isn't a existing key
    // assert(!widget.controller.tagMap.keys.contains(index));
    widget.controller.tagMap[index] = this;
  }

  void unregister(int index) {
    _cancelController();
    _highlights.remove(this);
    // the caller in initState() or dispose() is not in the order of first dispose and init
    // so we can't assert there isn't a existing key
    // assert(widget.controller.tagMap.keys.contains(index));
    if (widget.controller.tagMap[index] == this) widget.controller.tagMap.remove(index);
  }

  @override
  Widget build(BuildContext context) {
    return new DecoratedBoxTransition(
        decoration: new DecorationTween(
                begin: widget.color != null ? new BoxDecoration(color: widget.color) : new BoxDecoration(),
                end: widget.color != null ? new BoxDecoration(color: widget.color) : new BoxDecoration(color: widget.highlightColor))
            .animate(_controller ?? kAlwaysDismissedAnimation),
        child: widget.child ?? SizedBox());
  }

  //used to make sure we will drop the old highlight
  //it's rare that we call it more than once in same millisecond, so we just make the time stamp as the unique key
  DateTime? _startKey;

  /// this function can be called multiple times. every call will reset the highlight style.
  Future highlight({bool cancelExisting = true, Duration highlightDuration = _highlightDuration, bool animated = true}) async {
    if (!mounted) return null;

    if (cancelExisting) {
      _cancelAllHighlights(this);
    }

    if (_highlights.containsKey(this)) {
      assert(_controller != null);
      _controller!.stop();
    }

    if (_controller == null) {
      _controller = new AnimationController(vsync: this);
      _highlights[this] = _controller;
    }

    final startKey0 = _startKey = DateTime.now();
    const animationShow = 1.0;
    setState(() {});
    if (animated) {
      await catchAnimationCancel(_controller!.animateTo(animationShow, duration: scrollAnimationDuration));
    } else {
      _controller!.value = animationShow;
    }
    await Future.delayed(highlightDuration);

    if (startKey0 == _startKey) {
      if (mounted) {
        setState(() {});
        const animationHide = 0.0;
        if (animated) {
          await catchAnimationCancel(_controller!.animateTo(animationHide, duration: scrollAnimationDuration));
        } else {
          _controller!.value = animationHide;
        }
      }

      // if (startKey0 == _startKey) {
      _controller = null;
      _highlights.remove(this);
      // }
    }
    return null;
  }

  void _cancelController({bool reset = true}) {
    if (_controller != null) {
      if (_controller!.isAnimating) _controller!.stop();

      if (reset && _controller!.value != 0.0) _controller!.value = 0.0;
    }
  }
}
