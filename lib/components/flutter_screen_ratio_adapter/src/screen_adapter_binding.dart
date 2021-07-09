import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:ui' as ui show window, PointerDataPacket;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'info.dart';
import 'print.dart';
import 'transition_builder_widget.dart';
import 'ui_blueprints_rectangle.dart';

const _cTAG = '【_Fx】';

/// copy from [url](https://github.com/saikiran8787/Gridlex/blob/b22742018b3edf16c6cadd7b76d9db5e7f9064b5/packages/flutter/lib/src/gestures/binding.dart)
/// Class that implements clock used for sampling.
class SamplingClock {
  /// Returns current time.
  DateTime now() => DateTime.now();

  /// Returns a new stopwatch that uses the current time as reported by `this`.
  Stopwatch stopwatch() => Stopwatch();
}

SamplingClock? get debugSamplingClock => null;

@deprecated
void runFxApp(Widget app, {required BlueprintsRectangle uiBlueprints, VoidCallback? onEnsureInitialized, bool enableLog = false}) {
  FxWidgetsFlutterBinding.ensureInitialized(uiBlueprints: uiBlueprints, enableLog: enableLog)
    // ignore: invalid_use_of_protected_member
    ..scheduleAttachRootWidget(app)
    ..scheduleWarmUpFrame();
}

// Info _info;
BlueprintsRectangle _uiBlueprints = const BlueprintsRectangle(0, 0);

bool _enableLog = false;

///还原为设备原始实际值,使用系统像素密度
double restore2DeviceValue(double dpValue) {
  return dpValue * Info.instance.restoreRatio;
}

EdgeInsets restore2DeviceEdgeInsets(EdgeInsets dpEdgeInsets) {
  return dpEdgeInsets * Info.instance.restoreRatio;
}

Size restore2DeviceSize(Size dpSize) {
  return dpSize * Info.instance.restoreRatio;
}

// ignore: non_constant_identifier_names
TransitionBuilder FxTransitionBuilder({TransitionBuilder? builder}) {
  return (context, child) {
    var old = MediaQuery.of(context);
    var deviceShortWidth = ui.window.physicalSize.width <= ui.window.physicalSize.height ? ui.window.physicalSize.width : ui.window.physicalSize.height;
    if (deviceShortWidth == 0) {
      deviceShortWidth = old.size.width < old.size.height ? old.size.width * old.devicePixelRatio : old.size.height * old.devicePixelRatio;
    }
    double actualPixelRatio = deviceShortWidth / _uiBlueprints.width;
    Info.init(actualPixelRatio: actualPixelRatio, uiBlueprints: _uiBlueprints, enableLog: _enableLog).onScreenMetricsChange(old);
    if (_enableLog) print("$_cTAG Info=${Info.instance}");
    return TransitionBuilderWidget(
        builder: builder ?? (__, _) => _!,
        didChangeMetricsCallBack: () {
          // Info.instance.onScreenMetricsChange(old);
          // if (_enableLog) print("$_TAG Info=${Info.instance}");
        },
        child: MediaQuery(
          data: old.copyWith(
            textScaleFactor: 1,
            devicePixelRatio: actualPixelRatio,
            padding: restore2DeviceEdgeInsets(old.padding),
            viewPadding: restore2DeviceEdgeInsets(old.viewPadding),
            viewInsets: restore2DeviceEdgeInsets(old.viewInsets),
            systemGestureInsets: restore2DeviceEdgeInsets(old.systemGestureInsets),
          ),
          child: child!,
        ));
  };
}

class FxWidgetsFlutterBinding extends WidgetsFlutterBinding {
  static WidgetsBinding ensureInitialized({required BlueprintsRectangle uiBlueprints, bool enableLog = false, @deprecated VoidCallback? onEnsureInitialized}) {
    assert(uiBlueprints.width > 0);
    _enableLog = enableLog;
    _uiBlueprints = uiBlueprints;
    assert(WidgetsBinding.instance == null);
    if (WidgetsBinding.instance == null) FxWidgetsFlutterBinding();
    onEnsureInitialized?.call();
    return WidgetsBinding.instance!;
  }

  @protected
  void scheduleAttachRootWidget(Widget rootWidget) {
    Timer.run(() {
      attachRootWidget(_RoorRenderObjectWidget(rootWidget));
    });
  }

  ///override RendererBinding
  @override
  ViewConfiguration createViewConfiguration() {
    //super.createViewConfiguration();
    return ViewConfiguration(
      size: window.physicalSize / adapterDevicePixelRatio,
      devicePixelRatio: adapterDevicePixelRatio,
    );
  }

  ///override GestureBinding
  @override
  void initInstances() {
    super.initInstances();
    ui.window.onPointerDataPacket = _handlePointerDataPacket;
  }

  @override
  void unlocked() {
    super.unlocked();
    _flushPointerEventQueue();
  }

  final Queue<PointerEvent> _pendingPointerEvents = Queue<PointerEvent>();

  void _handlePointerDataPacket(ui.PointerDataPacket packet) {
    _pendingPointerEvents.addAll(PointerEventConverter.expand(packet.data, adapterDevicePixelRatio));
    if (!locked) _flushPointerEventQueue();
  }

  @override
  void cancelPointer(int pointer) {
    if (_pendingPointerEvents.isEmpty && !locked) scheduleMicrotask(_flushPointerEventQueue);
    _pendingPointerEvents.addFirst(PointerCancelEvent(pointer: pointer));
  }

  void _flushPointerEventQueue() {
    assert(!locked);
    while (_pendingPointerEvents.isNotEmpty) {
      handlePointerEvent(_pendingPointerEvents.removeFirst());
    }
  }

  final Map<int, HitTestResult> _hitTests = <int, HitTestResult>{};

  // void _handlePointerEvent(PointerEvent event) {
  //   assert(!locked);
  //   HitTestResult result;
  //   if (event is PointerDownEvent) {
  //     assert(!_hitTests.containsKey(event.pointer));
  //     result = HitTestResult();
  //     hitTest(result, event.position);
  //     _hitTests[event.pointer] = result;
  //     assert(() {
  //       if (debugPrintHitTestResults) debugPrint('$event: $result');
  //       return true;
  //     }());
  //   } else if (event is PointerUpEvent || event is PointerCancelEvent) {
  //     result = _hitTests.remove(event.pointer)!;
  //   } else if (event.down) {
  //     result = _hitTests[event.pointer]!;
  //   } else {
  //     print("@We currently ignore add, remove, and hover move events.");
  //     return; // We currently ignore add, remove, and hover move events.
  //   }
  //   dispatchEvent(event, result);
  // }

  void _handleSampleTimeChanged() {
    if (!locked) {
      if (resamplingEnabled) {
        _resampler.sample(samplingOffset, _samplingClock);
      } else {
        _resampler.stop();
      }
    }
  }

  SamplingClock get _samplingClock {
    SamplingClock value = SamplingClock();
    assert(() {
      final SamplingClock? debugValue = debugSamplingClock;
      if (debugValue != null) value = debugValue;
      return true;
    }());
    return value;
  }

  late final _Resampler _resampler = _Resampler(
    _handlePointerEventImmediately,
    _handleSampleTimeChanged,
    _samplingInterval,
  );

  void handlePointerEvent(PointerEvent event) {
    assert(!locked);

    if (resamplingEnabled) {
      _resampler.addOrDispatch(event);
      _resampler.sample(samplingOffset, _samplingClock);
      return;
    }

    // Stop resampler if resampling is not enabled. This is a no-op if
    // resampling was never enabled.
    _resampler.stop();
    _handlePointerEventImmediately(event);
  }

  void _handlePointerEventImmediately(PointerEvent event) {
    HitTestResult? hitTestResult;
    if (event is PointerDownEvent || event is PointerSignalEvent || event is PointerHoverEvent) {
      assert(!_hitTests.containsKey(event.pointer));
      hitTestResult = HitTestResult();
      hitTest(hitTestResult, event.position);
      if (event is PointerDownEvent) {
        _hitTests[event.pointer] = hitTestResult;
      }
      assert(() {
        if (debugPrintHitTestResults) debugPrint('$event: $hitTestResult');
        return true;
      }());
    } else if (event is PointerUpEvent || event is PointerCancelEvent) {
      hitTestResult = _hitTests.remove(event.pointer);
    } else if (event.down) {
      // Because events that occur with the pointer down (like
      // [PointerMoveEvent]s) should be dispatched to the same place that their
      // initial PointerDownEvent was, we want to re-use the path we found when
      // the pointer went down, rather than do hit detection each time we get
      // such an event.
      hitTestResult = _hitTests[event.pointer];
    }
    assert(() {
      if (debugPrintMouseHoverEvents && event is PointerHoverEvent) debugPrint('$event');
      return true;
    }());
    if (hitTestResult != null || event is PointerAddedEvent || event is PointerRemovedEvent) {
      assert(event.position != null);
      dispatchEvent(event, hitTestResult);
    }
  }

  double get adapterDevicePixelRatio {
    if (Info.initialed) return Info.instance.actualPixelRatio;
    double _adapterDevicePixelRatio;
    var deviceShortWidth = ui.window.physicalSize.width <= ui.window.physicalSize.height ? ui.window.physicalSize.width : ui.window.physicalSize.height;
    _adapterDevicePixelRatio = deviceShortWidth / _uiBlueprints.width;
    return _adapterDevicePixelRatio;
  }
}

class _RoorRenderObjectWidget extends SingleChildRenderObjectWidget {
  _RoorRenderObjectWidget(Widget rootChild) : super(child: rootChild);

  @override
  RenderObject createRenderObject(BuildContext context) {
    _assertOnFuture(() => Info.instance == null,
        errorMsg: "\nError:'FxTransitionBuilder' is not configured"
            "\nMaterialApp("
            "\n  ......"
            "\n  builder: FxTransitionBuilder(builder: null),"
            "\n  ......"
            "\n);");
    return RenderPadding(padding: EdgeInsets.all(0));
  }

  void _assertOnFuture(ValueGetter<bool> conditions, {String errorMsg = "", int time = 1000}) {
    if (Info.isRelease) return;
    Future.delayed(Duration(milliseconds: time), () {
      if (conditions.call()) throw FormatException(errorMsg);
    });
    Future.delayed(Duration(milliseconds: (time * 1.5).toInt()), () {
      if (conditions.call()) exit(0);
    });
  }
}

// const Duration _defaultSamplingOffset = Duration(milliseconds: -38);
const Duration _samplingInterval = Duration(microseconds: 16667);

typedef _HandleSampleTimeChangedCallback = void Function();

class _Resampler {
  _Resampler(this._handlePointerEvent, this._handleSampleTimeChanged, this._samplingInterval);

  // Resamplers used to filter incoming pointer events.
  final Map<int, PointerEventResampler> _resamplers = <int, PointerEventResampler>{};

  // Flag to track if a frame callback has been scheduled.
  bool _frameCallbackScheduled = false;

  // Last frame time for resampling.
  Duration _frameTime = Duration.zero;

  // Time since `_frameTime` was updated.
  Stopwatch _frameTimeAge = Stopwatch();

  // Last sample time and time stamp of last event.
  //
  // Only used for debugPrint of resampling margin.
  Duration _lastSampleTime = Duration.zero;
  Duration _lastEventTime = Duration.zero;

  // Callback used to handle pointer events.
  final HandleEventCallback _handlePointerEvent;

  // Callback used to handle sample time changes.
  final _HandleSampleTimeChangedCallback _handleSampleTimeChanged;

  // Interval used for sampling.
  final Duration _samplingInterval;

  // Timer used to schedule resampling.
  Timer? _timer;

  // Add `event` for resampling or dispatch it directly if
  // not a touch event.
  void addOrDispatch(PointerEvent event) {
    final SchedulerBinding? scheduler = SchedulerBinding.instance;
    assert(scheduler != null);
    // Add touch event to resampler or dispatch pointer event directly.
    if (event.kind == PointerDeviceKind.touch) {
      // Save last event time for debugPrint of resampling margin.
      _lastEventTime = event.timeStamp;

      final PointerEventResampler resampler = _resamplers.putIfAbsent(
        event.device,
        () => PointerEventResampler(),
      );
      resampler.addEvent(event);
    } else {
      _handlePointerEvent(event);
    }
  }

  // Sample and dispatch events.
  //
  // The `samplingOffset` is relative to the current frame time, which
  // can be in the past when we're not actively resampling.
  // The `samplingClock` is the clock used to determine frame time age.
  void sample(Duration samplingOffset, SamplingClock clock) {
    final SchedulerBinding? scheduler = SchedulerBinding.instance;
    assert(scheduler != null);

    // Initialize `_frameTime` if needed. This will be used for periodic
    // sampling when frame callbacks are not received.
    if (_frameTime == Duration.zero) {
      _frameTime = Duration(milliseconds: clock.now().millisecondsSinceEpoch);
      _frameTimeAge = clock.stopwatch()..start();
    }

    // Schedule periodic resampling if `_timer` is not already active.
    if (_timer?.isActive != true) {
      _timer = Timer.periodic(_samplingInterval, (_) => _onSampleTimeChanged());
    }

    // Calculate the effective frame time by taking the number
    // of sampling intervals since last time `_frameTime` was
    // updated into account. This allows us to advance sample
    // time without having to receive frame callbacks.
    final int samplingIntervalUs = _samplingInterval.inMicroseconds;
    final int elapsedIntervals = _frameTimeAge.elapsedMicroseconds ~/ samplingIntervalUs;
    final int elapsedUs = elapsedIntervals * samplingIntervalUs;
    final Duration frameTime = _frameTime + Duration(microseconds: elapsedUs);

    // Determine sample time by adding the offset to the current
    // frame time. This is expected to be in the past and not
    // result in any dispatched events unless we're actively
    // resampling events.
    final Duration sampleTime = frameTime + samplingOffset;

    // Determine next sample time by adding the sampling interval
    // to the current sample time.
    final Duration nextSampleTime = sampleTime + _samplingInterval;

    // Iterate over active resamplers and sample pointer events for
    // current sample time.
    for (final PointerEventResampler resampler in _resamplers.values) {
      resampler.sample(sampleTime, nextSampleTime, _handlePointerEvent);
    }

    // Remove inactive resamplers.
    _resamplers.removeWhere((int key, PointerEventResampler resampler) {
      return !resampler.hasPendingEvents && !resampler.isDown;
    });

    // Save last sample time for debugPrint of resampling margin.
    _lastSampleTime = sampleTime;

    // Early out if another call to `sample` isn't needed.
    if (_resamplers.isEmpty) {
      _timer!.cancel();
      return;
    }

    // Schedule a frame callback if another call to `sample` is needed.
    if (!_frameCallbackScheduled) {
      _frameCallbackScheduled = true;
      // Add a post frame callback as this avoids producing unnecessary
      // frames but ensures that sampling phase is adjusted to frame
      // time when frames are produced.
      scheduler?.addPostFrameCallback((_) {
        _frameCallbackScheduled = false;
        // We use `currentSystemFrameTimeStamp` here as it's critical that
        // sample time is in the same clock as the event time stamps, and
        // never adjusted or scaled like `currentFrameTimeStamp`.
        _frameTime = scheduler.currentSystemFrameTimeStamp;
        _frameTimeAge.reset();
        // Reset timer to match phase of latest frame callback.
        _timer?.cancel();
        _timer = Timer.periodic(_samplingInterval, (_) => _onSampleTimeChanged());
        // Trigger an immediate sample time change.
        _onSampleTimeChanged();
      });
    }
  }

  // Stop all resampling and dispatched any queued events.
  void stop() {
    for (final PointerEventResampler resampler in _resamplers.values) {
      resampler.stop(_handlePointerEvent);
    }
    _resamplers.clear();
    _frameTime = Duration.zero;
  }

  void _onSampleTimeChanged() {
    assert(() {
      if (debugPrintResamplingMargin) {
        final Duration resamplingMargin = _lastEventTime - _lastSampleTime;
        debugPrint('$resamplingMargin');
      }
      return true;
    }());
    _handleSampleTimeChanged();
  }
}
