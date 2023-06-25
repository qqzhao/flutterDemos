import 'dart:developer';
import 'dart:io' show Platform;
import 'dart:ui' as ui show Scene, SceneBuilder, SingletonFlutterWindow;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'render_object_with_child_mixin.dart';

/// The root of the render tree.
///
/// The view represents the total output surface of the render tree and handles
/// bootstrapping the rendering pipeline. The view has a unique child
/// [RenderBox], which is required to fill the entire output surface.
class MyRenderView extends RenderObject with MyRenderObjectWithChildMixin<RenderBox> {
//class MyRenderView extends RenderView {
  /// Creates the root of the render tree.
  ///
  /// Typically created by the binding (e.g., [RendererBinding]).
  ///
  /// The [configuration] must not be null.
  MyRenderView({
    RenderBox? child,
    @required ViewConfiguration? configuration,
    @required ui.SingletonFlutterWindow? window,
  })  : assert(configuration != null),
        _configuration = configuration,
        _window = window {
    this.child = child;
  }

  /// The current layout size of the view.
  Size get size => _size;
  Size _size = Size.zero;

  /// The constraints used for the root layout.
  ViewConfiguration? get configuration => _configuration;
  ViewConfiguration? _configuration;

  /// The configuration is initially set by the `configuration` argument
  /// passed to the constructor.
  ///
  /// Always call [prepareInitialFrame] before changing the configuration.
  set configuration(ViewConfiguration? value) {
    assert(value != null);
    if (configuration == value) return;
    _configuration = value;
    replaceRootLayer(_updateMatricesAndCreateNewRootLayer());
    assert(_rootTransform != null);
    markNeedsLayout();
  }

  final ui.SingletonFlutterWindow? _window;

  /// Whether Flutter should automatically compute the desired system UI.
  ///
  /// When this setting is enabled, Flutter will hit-test the layer tree at the
  /// top and bottom of the screen on each frame looking for an
  /// [AnnotatedRegionLayer] with an instance of a [SystemUiOverlayStyle]. The
  /// hit-test result from the top of the screen provides the status bar settings
  /// and the hit-test result from the bottom of the screen provides the system
  /// nav bar settings.
  ///
  /// Setting this to false does not cause previous automatic adjustments to be
  /// reset, nor does setting it to true cause the app to update immediately.
  ///
  /// If you want to imperatively set the system ui style instead, it is
  /// recommended that [automaticSystemUiAdjustment] is set to false.
  ///
  /// See also:
  ///
  ///  * [AnnotatedRegion], for placing [SystemUiOverlayStyle] in the layer tree.
  ///  * [SystemChrome.setSystemUIOverlayStyle], for imperatively setting the system ui style.
  bool automaticSystemUiAdjustment = true;

  /// Bootstrap the rendering pipeline by scheduling the first frame.
  ///
  /// Deprecated. Call [prepareInitialFrame] followed by a call to
  /// [PipelineOwner.requestVisualUpdate] on [owner] instead.
  @Deprecated('Call prepareInitialFrame followed by owner.requestVisualUpdate() instead. '
      'This feature was deprecated after v1.10.0.')
  void scheduleInitialFrame() {
    prepareInitialFrame();
    owner?.requestVisualUpdate();
  }

  /// Bootstrap the rendering pipeline by preparing the first frame.
  ///
  /// This should only be called once, and must be called before changing
  /// [configuration]. It is typically called immediately after calling the
  /// constructor.
  ///
  /// This does not actually schedule the first frame. Call
  /// [PipelineOwner.requestVisualUpdate] on [owner] to do that.
  void prepareInitialFrame() {
    assert(owner != null);
    assert(_rootTransform == null);
    scheduleInitialLayout();
    scheduleInitialPaint(_updateMatricesAndCreateNewRootLayer());
    assert(_rootTransform != null);
  }

  Matrix4? _rootTransform;

  TransformLayer _updateMatricesAndCreateNewRootLayer() {
    _rootTransform = configuration?.toMatrix();
    final TransformLayer rootLayer = TransformLayer(transform: _rootTransform);
    rootLayer.attach(this);
    assert(_rootTransform != null);
    return rootLayer;
  }

  // We never call layout() on this class, so this should never get
  // checked. (This class is laid out using scheduleInitialLayout().)
  @override
  void debugAssertDoesMeetConstraints() {
    assert(false);
  }

  @override
  void performResize() {
    assert(false);
  }

  @override
  void performLayout() {
    assert(_rootTransform != null);
    _size = configuration!.size;
    assert(_size.isFinite);

    if (child != null) child!.layout(BoxConstraints.tight(_size));
  }

  @override
  void rotate({int? oldAngle, int? newAngle, Duration? time}) {
    assert(false); // nobody tells the screen to rotate, the whole rotate() dance is started from our performResize()
  }

  /// Determines the set of render objects located at the given position.
  ///
  /// Returns true if the given point is contained in this render object or one
  /// of its descendants. Adds any render objects that contain the point to the
  /// given hit test result.
  ///
  /// The [position] argument is in the coordinate system of the render view,
  /// which is to say, in logical pixels. This is not necessarily the same
  /// coordinate system as that expected by the root [Layer], which will
  /// normally be in physical (device) pixels.
  bool hitTest(HitTestResult result, {Offset? position}) {
    if (child != null) child!.hitTest(BoxHitTestResult.wrap(result), position: position!);
    result.add(HitTestEntry(this));
    return true;
  }

  /// Determines the set of mouse tracker annotations at the given position.
  ///
  /// See also:
  ///
  ///  * [Layer.findAllAnnotations], which is used by this method to find all
  ///    [AnnotatedRegionLayer]s annotated for mouse tracking.
  Iterable<MouseTrackerAnnotation> hitTestMouseTrackers(Offset position) {
    // Layer hit testing is done using device pixels, so we have to convert
    // the logical coordinates of the event location back to device pixels
    // here.
    return layer!.findAllAnnotations<MouseTrackerAnnotation>(position * configuration!.devicePixelRatio).annotations;
  }

  @override
  bool get isRepaintBoundary => true;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) context.paintChild(child!, offset);
  }

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    assert(_rootTransform != null);
    transform.multiply(_rootTransform!);
    super.applyPaintTransform(child, transform);
  }

  /// Uploads the composited layer tree to the engine.
  ///
  /// Actually causes the output of the rendering pipeline to appear on screen.
  void compositeFrame() {
    Timeline.startSync('Compositing', arguments: {});
    try {
      final ui.SceneBuilder builder = ui.SceneBuilder();
      final ui.Scene scene = layer!.buildScene(builder);
      if (automaticSystemUiAdjustment) _updateSystemChrome();
      _window!.render(scene);
      scene.dispose();
    } finally {
      Timeline.finishSync();
    }
  }

  // ignore: code-metrics
  void _updateSystemChrome() {
    final Rect bounds = paintBounds;
    final Offset top = Offset(bounds.center.dx, _window!.padding.top / _window!.devicePixelRatio);
    final Offset bottom = Offset(bounds.center.dx, bounds.center.dy - _window!.padding.bottom / _window!.devicePixelRatio);
    final SystemUiOverlayStyle? upperOverlayStyle = layer!.find<SystemUiOverlayStyle>(top);
    // Only android has a customizable system navigation bar.
    SystemUiOverlayStyle? lowerOverlayStyle;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        lowerOverlayStyle = layer!.find<SystemUiOverlayStyle>(bottom);
        break;
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        break;
    }
    // If there are no overlay styles in the UI don't bother updating.
    if (upperOverlayStyle != null || lowerOverlayStyle != null) {
      final SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
        statusBarBrightness: upperOverlayStyle?.statusBarBrightness,
        statusBarIconBrightness: upperOverlayStyle?.statusBarIconBrightness,
        statusBarColor: upperOverlayStyle?.statusBarColor,
        systemNavigationBarColor: lowerOverlayStyle?.systemNavigationBarColor,
        systemNavigationBarDividerColor: lowerOverlayStyle?.systemNavigationBarDividerColor,
        systemNavigationBarIconBrightness: lowerOverlayStyle?.systemNavigationBarIconBrightness,
      );
      SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    }
  }

  @override
  Rect get paintBounds => Offset.zero & (size * configuration!.devicePixelRatio);

  @override
  Rect get semanticBounds {
    assert(_rootTransform != null);
    return MatrixUtils.transformRect(_rootTransform!, Offset.zero & size);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    // call to ${super.debugFillProperties(description)} is omitted because the
    // root superclasses don't include any interesting information for this
    // class
    assert(() {
      properties.add(DiagnosticsNode.message('debug mode enabled - ${kIsWeb ? 'Web' : Platform.operatingSystem}'));
      return true;
    }());
    properties.add(DiagnosticsProperty<Size>('window size', _window!.physicalSize, tooltip: 'in physical pixels'));
    properties.add(DoubleProperty('device pixel ratio', _window!.devicePixelRatio, tooltip: 'physical pixels per logical pixel'));
    properties.add(DiagnosticsProperty<ViewConfiguration>('configuration', configuration, tooltip: 'in logical pixels'));
    if (_window!.semanticsEnabled) properties.add(DiagnosticsNode.message('semantics enabled'));
  }
}
