//Copyright (C) 2019 Potix Corporation. All Rights Reserved.
//History: Tue Apr 24 09:17 CST 2019
// Author: Jerry Chen

library scroll_to_index;

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'auto_scroll_tag.dart';
import 'util.dart';

const defaultScrollDistanceOffset = 100.0;
const _highlightDuration = Duration(seconds: 3);
const defaultDurationUnit = 40;

const _millisecond = Duration(milliseconds: 1);
const scrollAnimationDuration = Duration(milliseconds: 250);

/// 默认是0 ，目前用于层次嵌套，然后外层计算？
typedef ViewportBoundaryGetter = Rect Function();

typedef AxisValueGetter = double Function(Rect rect);

Rect defaultViewportBoundaryGetter() => Rect.zero;

abstract class AutoScrollController implements ScrollController {
  factory AutoScrollController(
      {double initialScrollOffset = 0.0,
      bool keepScrollOffset = true,
      double? suggestedRowHeight,
      ViewportBoundaryGetter viewportBoundaryGetter = defaultViewportBoundaryGetter,
      Axis? axis,
      String? debugLabel,
      AutoScrollController? copyTagsFrom}) {
    return SimpleAutoScrollController(
        initialScrollOffset: initialScrollOffset,
        keepScrollOffset: keepScrollOffset,
        suggestedRowHeight: suggestedRowHeight,
        viewportBoundaryGetter: viewportBoundaryGetter,
        beginGetter: axis == Axis.horizontal ? (r) => r.left : (r) => r.top,
        endGetter: axis == Axis.horizontal ? (r) => r.right : (r) => r.bottom,
        copyTagsFrom: copyTagsFrom,
        debugLabel: debugLabel);
  }

  /// used to quick scroll to a index if the row height is the same
  double? get suggestedRowHeight;

  /// used to make the additional boundary for viewport
  /// e.g. a sticky header which covers the real viewport of a list view
  ViewportBoundaryGetter get viewportBoundaryGetter;

  /// used to choose which direction you are using.
  /// e.g. axis == Axis.horizontal ? (r) => r.left : (r) => r.top
  AxisValueGetter get beginGetter;
  AxisValueGetter get endGetter;

  /// detect if it's in scrolling (scrolling is a async process)
  /// 是否正在自动滑动
  bool get isAutoScrolling;

  /// all layout out states will be put into this map
  /// 两个时机：init/dispose 和 update 的时候。所以，添加的时机是比较早的。
  Map<int, AutoScrollTagState> get tagMap;

  /// used to chaining parent scroll controller
  set parentController(ScrollController parentController);

  /// check if there is a parent controller
  bool get hasParentController;

  /// scroll to the giving index
  Future scrollToIndex(int index, {Duration duration = scrollAnimationDuration, AutoScrollPosition? preferPosition});

  /// highlight the item
  Future highlight(int index, {bool cancelExistHighlights = true, Duration highlightDuration = _highlightDuration, bool animated = true});

  /// cancel all highlight item immediately.
  void cancelAllHighlights();

  /// check if the state is created. that is, is the indexed widget is layout out.
  /// NOTE: state created doesn't mean it's in viewport. it could be a buffer range, depending on flutter's implementation.
  bool isIndexStateInLayoutRange(int index);
}

class SimpleAutoScrollController extends ScrollController with AutoScrollControllerMixin {
  @override
  final double? suggestedRowHeight;
  @override
  final ViewportBoundaryGetter viewportBoundaryGetter;
  @override
  final AxisValueGetter beginGetter;
  @override
  final AxisValueGetter endGetter;

  SimpleAutoScrollController(
      {double initialScrollOffset = 0.0,
      bool keepScrollOffset = true,
      this.suggestedRowHeight,
      this.viewportBoundaryGetter = defaultViewportBoundaryGetter,
      required this.beginGetter,
      required this.endGetter,
      AutoScrollController? copyTagsFrom,
      String? debugLabel})
      : super(initialScrollOffset: initialScrollOffset, keepScrollOffset: keepScrollOffset, debugLabel: debugLabel) {
    if (copyTagsFrom != null) tagMap.addAll(copyTagsFrom.tagMap);
  }
}

class PageAutoScrollController extends PageController with AutoScrollControllerMixin {
  @override
  final double? suggestedRowHeight;
  @override
  final ViewportBoundaryGetter viewportBoundaryGetter;
  @override
  final AxisValueGetter beginGetter = (r) => r.left;
  @override
  final AxisValueGetter endGetter = (r) => r.right;

  PageAutoScrollController(
      {int initialPage = 0,
      bool keepPage = true,
      double viewportFraction = 1.0,
      this.suggestedRowHeight,
      this.viewportBoundaryGetter = defaultViewportBoundaryGetter,
      AutoScrollController? copyTagsFrom,
      String? debugLabel})
      : super(initialPage: initialPage, keepPage: keepPage, viewportFraction: viewportFraction) {
    if (copyTagsFrom != null) tagMap.addAll(copyTagsFrom.tagMap);
  }
}

enum AutoScrollPosition { begin, middle, end }
mixin AutoScrollControllerMixin on ScrollController implements AutoScrollController {
  @override
  final Map<int, AutoScrollTagState> tagMap = <int, AutoScrollTagState>{};
  @override
  double? get suggestedRowHeight;
  @override
  ViewportBoundaryGetter get viewportBoundaryGetter;
  @override
  AxisValueGetter get beginGetter;
  @override
  AxisValueGetter get endGetter;

  bool __isAutoScrolling = false;
  set _isAutoScrolling(bool isAutoScrolling) {
    __isAutoScrolling = isAutoScrolling;
    if (!isAutoScrolling && hasClients) {
      notifyListeners();
    }
  }

  @override
  bool get isAutoScrolling => __isAutoScrolling;

  ScrollController? _parentController;
  @override
  set parentController(ScrollController parentController) {
    if (_parentController == parentController) return;

    final isNotEmpty = positions.isNotEmpty;
    if (isNotEmpty && _parentController != null) {
      for (final p in _parentController!.positions) {
        if (positions.contains(p)) _parentController!.detach(p);
      }
    }

    _parentController = parentController;

    if (isNotEmpty && _parentController != null) {
      for (final p in positions) {
        _parentController!.attach(p);
      }
    }
  }

  @override
  bool get hasParentController => _parentController != null;

  @override
  void attach(ScrollPosition position) {
    super.attach(position);

    _parentController?.attach(position);
  }

  @override
  void detach(ScrollPosition position) {
    _parentController?.detach(position);

    super.detach(position);
  }

  // 这里的意思是最多等待30帧，也就是0.5s 的意思。`_waitForWidgetStateBuild` 是每一次帧结束调用。
  static const maxBound = 30; // 0.5 second if 60fps
  @override
  Future scrollToIndex(int index, {Duration duration = scrollAnimationDuration, AutoScrollPosition? preferPosition}) async {
    return co(this, () => _scrollToIndex(index, duration: duration, preferPosition: preferPosition));
  }

  Future _scrollToIndex(int index, {Duration duration = scrollAnimationDuration, AutoScrollPosition? preferPosition}) async {
    assert(duration > Duration.zero);

    // In listView init or reload case, widget state of list item may not be ready for query.
    // this prevent from over scrolling becoming empty screen or unnecessary scroll bounce.
    // 在 listview 初始化，或者和重新加载的时候，list item的状态可能没有准备好。下面的函数确保状态准备好。
    Future makeSureStateIsReady() async {
      for (var count = 0; count < maxBound; count++) {
        if (_isEmptyStates) {
          await _waitForWidgetStateBuild();
        } else {
          return null;
        }
      }

      return null;
    }

    await makeSureStateIsReady();

    /// scrollController 是否初始化完成.
    if (!hasClients) return null;

    // two cases,
    // 1. already has state. it's in viewport layout
    // 2. doesn't have state yet. it's not in viewport so we need to start scrolling to make it into layout range.
    // 两种场景： 1. 已经存在 state，说明已经有 layout 了。  2. 不存在 state，需要逐步滑动然后，处于 range 范围内。
    if (isIndexStateInLayoutRange(index)) {
      _isAutoScrolling = true;

      await _bringIntoViewportIfNeed(index, preferPosition, (double offset) async {
        await animateTo(offset, duration: duration, curve: Curves.ease);

        /// 这里的作用，为了 _waitForWidgetStateBuild ？
        await _waitForWidgetStateBuild();
        return null;
      });

      _isAutoScrolling = false;
    } else {
      // the idea is scrolling based on either
      // 1. suggestedRowHeight or
      // 2. testDistanceOffset
      double prevOffset = offset - 1;
      double currentOffset = offset;
      bool contains = false;
      Duration spentDuration = const Duration();
      double lastScrollDirection = 0.5; // alignment, default center;
      final moveDuration = duration ~/ defaultDurationUnit;

      _isAutoScrolling = true;

      /// ideally, the suggest row height will move to the final corrent offset approximately in just one scroll(iteration).
      /// if the given suggest row height is the minimal/maximal height in variable row height enviroment,
      /// we can just use viewport calculation to reach the final offset in other iteration.
      bool usedSuggestedRowHeightIfAny = true;
      while (prevOffset != currentOffset && !(contains = isIndexStateInLayoutRange(index))) {
        prevOffset = currentOffset;
        final nearest = _getNearestIndex(index);
        final moveTarget = _forecastMoveUnit(index, nearest, usedSuggestedRowHeightIfAny)!;
        if (moveTarget < 0) {
          return null;
        }
        // assume suggestRowHeight will move to correct offset in just one time.
        // if the rule doesn't work (in variable row height case), we will use backup solution (non-suggested way)
        /// 假设 suggestRowHeight 会一次性移动到正确的位置。如果规则不生效，则使用备选方案。所以，设置 usedSuggestedRowHeightIfAny 一次为 true.
        final suggestedDuration = usedSuggestedRowHeightIfAny && suggestedRowHeight != null ? duration : null;
        usedSuggestedRowHeightIfAny = false; // just use once
        lastScrollDirection = moveTarget - prevOffset > 0 ? 1 : 0;
        currentOffset = moveTarget;
        spentDuration += suggestedDuration ?? moveDuration;
        final oldOffset = offset;
        await animateTo(currentOffset, duration: suggestedDuration ?? moveDuration, curve: Curves.ease);
        await _waitForWidgetStateBuild();
        if (!hasClients || offset == oldOffset) {
          // already scroll to begin or end
          contains = isIndexStateInLayoutRange(index);
          break;
        }
      }
      _isAutoScrolling = false;

      /// contains 表示目标index 的 state 已经创建了，只是没有划到固定位置。下面的函数就是滑动到要求的位置。
      if (contains && hasClients) {
        await _bringIntoViewportIfNeed(index, preferPosition ?? _alignmentToPosition(lastScrollDirection), (finalOffset) async {
          if (finalOffset != offset) {
            _isAutoScrolling = true;
            final remaining = duration - spentDuration;
            await animateTo(finalOffset, duration: remaining <= Duration.zero ? _millisecond : remaining, curve: Curves.ease);
            await _waitForWidgetStateBuild();

            // not sure why it doesn't scroll to the given offset, try more within 3 times
            /// 这里有可能不对，所以多尝试几次。
            if (hasClients && offset != finalOffset) {
              final count = 3;
              for (var i = 0; i < count && hasClients && offset != finalOffset; i++) {
                await animateTo(finalOffset, duration: _millisecond, curve: Curves.ease);
                await _waitForWidgetStateBuild();
              }
            }
            _isAutoScrolling = false;
          }
        });
      }
    }

    return null;
  }

  @override
  Future highlight(int index, {bool cancelExistHighlights = true, Duration highlightDuration = _highlightDuration, bool animated = true}) async {
    final tag = tagMap[index];
    return tag == null ? null : await tag.highlight(cancelExisting: cancelExistHighlights, highlightDuration: highlightDuration, animated: animated);
  }

  @override
  void cancelAllHighlights() {
    cancelAllHighlightsExport();
  }

  @override
  bool isIndexStateInLayoutRange(int index) => tagMap[index] != null;

  /// this means there is no widget state existing, usually happened before build.
  /// we should wait for next frame.
  bool get _isEmptyStates => tagMap.isEmpty;

  /// wait until the [SchedulerPhase] in [SchedulerPhase.persistentCallbacks].
  /// it means if we do animation scrolling to a position, the Future call back will in [SchedulerPhase.midFrameMicrotasks].
  /// if we want to search viewport element depending on Widget State, we must delay it to [SchedulerPhase.persistentCallbacks].
  /// which is the phase widget build/layout/draw
  Future _waitForWidgetStateBuild() => SchedulerBinding.instance!.endOfFrame;

  /// NOTE: this is used to forecast the nearestIndex. if the the index equals targetIndex,
  /// we will use the function, calling _directionalOffsetToRevealInViewport to get move unit.
  double? _forecastMoveUnit(int targetIndex, int? currentNearestIndex, bool useSuggested) {
    assert(targetIndex != currentNearestIndex);
    currentNearestIndex = currentNearestIndex ?? 0; //null as none of state

    final alignment = targetIndex > currentNearestIndex ? 1.0 : 0.0;
    double? absoluteOffsetToViewport;

    if (tagMap[currentNearestIndex] == null) return -1;

    /// 两种情况：1. 如果使用 useSuggested的话，可以通过 index 差来计算（一次完成）；2. 如果不使用，先移动到当前边沿（上边沿或者下边沿）（多次完成）。
    ///
    if (useSuggested && suggestedRowHeight != null) {
      final indexDiff = (targetIndex - currentNearestIndex);
      final offsetToLastState = _offsetToRevealInViewport(currentNearestIndex, indexDiff <= 0 ? 0 : 1)!;
      absoluteOffsetToViewport = math.max(offsetToLastState.offset + indexDiff * suggestedRowHeight!, 0);
    } else {
      final offsetToLastState = _offsetToRevealInViewport(currentNearestIndex, alignment);
      assert((offsetToLastState?.offset ?? 0) >= 0,
          "ERROR: %%%%%%%%%%%%%%: $targetIndex, $currentNearestIndex, $alignment, $offsetToLastState, ${tagMap.keys.toList().join(',')}");
      absoluteOffsetToViewport = offsetToLastState?.offset;
      absoluteOffsetToViewport ??= defaultScrollDistanceOffset;
    }

    return absoluteOffsetToViewport;
  }

  /// 这个函数计算 tapMap 中的顶部偏移和底部偏移，哪一个距离 index 最近。
  int? _getNearestIndex(int index) {
    final list = tagMap.keys;
    // ignore: avoid_returning_null
    if (list.isEmpty) return null;

    /// 这里是按照 key 排序，key 是按照 index 的值。
    final sorted = list.toList()..sort((int first, int second) => first.compareTo(second));
    final min = sorted.first;
    final max = sorted.last;
    return (index - min).abs() < (index - max).abs() ? min : max;
  }

  /// bring the state node (already created but all of it may not be fully in the viewport) into viewport
  /// 将已经存在的 state 的节点可视化。可能不可视或者不完全可视。
  /// 回调 move 是真正的移动，这个函数只是计算 offset 的值。
  Future _bringIntoViewportIfNeed(int index, AutoScrollPosition? preferPosition, Future Function(double offset) move) async {
    /// 注意 begin > end, 可以这样理解：方向向下，begin 在 end 的下边。
    final begin = _directionalOffsetToRevealInViewport(index, 0);
    final end = _directionalOffsetToRevealInViewport(index, 1);

    if (preferPosition != null) {
      /// 如果设置了preferPosition， 则直接计算偏移，然后进行移动
      double targetOffset = _directionalOffsetToRevealInViewport(index, _positionToAlignment(preferPosition));

      if (targetOffset < position.minScrollExtent) {
        targetOffset = position.minScrollExtent;
      } else if (targetOffset > position.maxScrollExtent) {
        targetOffset = position.maxScrollExtent;
      }

      await move(targetOffset);
    } else {
      /// 如果没有设置preferPosition， 先判断是否可视。如果不可视，判断是距离 end 还是 begin 更近，然后作到 begin 或者 end 的移动。
      final alreadyInViewport = offset < begin && offset > end;
      if (!alreadyInViewport) {
        double value;
        if ((end - offset).abs() < (begin - offset).abs()) {
          value = end;
        } else {
          value = begin;
        }

        await move(value > 0 ? value : 0);
      }
    }
  }

  double _positionToAlignment(AutoScrollPosition position) {
    return position == AutoScrollPosition.begin
        ? 0
        : position == AutoScrollPosition.end
            ? 1
            : 0.5;
  }

  AutoScrollPosition _alignmentToPosition(double alignment) => alignment == 0
      ? AutoScrollPosition.begin
      : alignment == 1
          ? AutoScrollPosition.end
          : AutoScrollPosition.middle;

  /// return offset, which is a absolute offset to bring the target index object into the location(depends on [direction]) of viewport
  /// see also: _offsetYToRevealInViewport()
  double _directionalOffsetToRevealInViewport(int index, double alignment) {
    assert(alignment == 0 || alignment == 0.5 || alignment == 1);
    // 1.0 bottom, 0.5 center, 0.0 begin if list is vertically from begin to end
    final tagOffsetInViewport = _offsetToRevealInViewport(index, alignment);

    if (tagOffsetInViewport == null) {
      return -1;
    } else {
      double absoluteOffsetToViewport = tagOffsetInViewport.offset;
      if (alignment == 0.5) {
        return absoluteOffsetToViewport;
      } else if (alignment == 0) {
        return absoluteOffsetToViewport - beginGetter(viewportBoundaryGetter());
      } else {
        return absoluteOffsetToViewport + endGetter(viewportBoundaryGetter());
      }
    }
  }

  /// return offset, which is a absolute offset to bring the target index object into the center of the viewport
  /// see also: _directionalOffsetToRevealInViewport()
  RevealedOffset? _offsetToRevealInViewport(int index, double alignment) {
    final ctx = tagMap[index]?.context;
    if (ctx == null) return null;

    final renderBox = ctx.findRenderObject()!;
    assert(Scrollable.of(ctx) != null);

    ///  根据 renderBox 获取 viewport （RenderViewport#6529d）
    final RenderAbstractViewport viewport = RenderAbstractViewport.of(renderBox)!;

    ///  获取 renderBox 在 viewport 中的偏移
    final revealedOffset = viewport.getOffsetToReveal(renderBox, alignment);

    return revealedOffset;
  }
}
