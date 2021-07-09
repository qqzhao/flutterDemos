import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'render_object_with_child_mixin.dart';

class MyRenderObjectToWidgetAdapter<T extends RenderObject> extends RenderObjectWidget {
  /// Creates a bridge from a [RenderObject] to an [Element] tree.
  ///
  /// Used by [WidgetsBinding] to attach the root widget to the [RenderView].
  MyRenderObjectToWidgetAdapter({
    this.child,
    this.container,
    this.debugShortDescription = 'description',
  }) : super(key: GlobalObjectKey(container!));

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget? child;

  /// The [RenderObject] that is the parent of the [Element] created by this widget.
  final MyRenderObjectWithChildMixin<T>? container;

  /// 调试描述
  final String debugShortDescription;

  @override
  MyRenderObjectToWidgetElement<T> createElement() => MyRenderObjectToWidgetElement<T>(this);

  @override
  MyRenderObjectWithChildMixin<T> createRenderObject(BuildContext context) => container!;

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {}

  /// Inflate this widget and actually set the resulting [RenderObject] as the
  /// child of [container].
  ///
  /// If `element` is null, this function will create a new element. Otherwise,
  /// the given element will have an update scheduled to switch to this widget.
  ///
  /// Used by [runApp] to bootstrap applications.
  MyRenderObjectToWidgetElement<T> attachToRenderTree(BuildOwner owner, [MyRenderObjectToWidgetElement<T>? element]) {
    if (element == null) {
      owner.lockState(() {
        element = createElement();
        assert(element != null);
        element!.assignOwner(owner);
      });
      owner.buildScope(element!, () {
        element!.mount(null, null);
      });
      // This is most likely the first time the framework is ready to produce
      // a frame. Ensure that we are asked for one.
      SchedulerBinding.instance!.ensureVisualUpdate();
    } else {
      element._newWidget = this;
      element.markNeedsBuild();
    }
    return element!;
  }

  @override
  String toStringShort() => debugShortDescription;
}

/// A [RootRenderObjectElement] that is hosted by a [RenderObject].
///
/// This element class is the instantiation of a [RenderObjectToWidgetAdapter]
/// widget. It can be used only as the root of an [Element] tree (it cannot be
/// mounted into another [Element]; it's parent must be null).
///
/// In typical usage, it will be instantiated for a [RenderObjectToWidgetAdapter]
/// whose container is the [RenderView] that connects to the Flutter engine. In
/// this usage, it is normally instantiated by the bootstrapping logic in the
/// [WidgetsFlutterBinding] singleton created by [runApp].
class MyRenderObjectToWidgetElement<T extends RenderObject> extends RootRenderObjectElement {
  /// Creates an element that is hosted by a [RenderObject].
  ///
  /// The [RenderObject] created by this element is not automatically set as a
  /// child of the hosting [RenderObject]. To actually attach this element to
  /// the render tree, call [RenderObjectToWidgetAdapter.attachToRenderTree].
  MyRenderObjectToWidgetElement(MyRenderObjectToWidgetAdapter<T> widget) : super(widget);

  @override
  MyRenderObjectToWidgetAdapter<T> get widget => super.widget as MyRenderObjectToWidgetAdapter<T>;

  Element? _child;

  static const Object _rootChildSlot = Object();

  @override
  void visitChildren(ElementVisitor visitor) {
    if (_child != null) visitor(_child!);
  }

  @override
  void forgetChild(Element child) {
    assert(child == _child);
    _child = null;
    super.forgetChild(child);
  }

  @override
  void mount(Element? parent, dynamic newSlot) {
    assert(parent == null);
    super.mount(parent, newSlot);
    _rebuild();
  }

  @override
  void update(RenderObjectToWidgetAdapter<T> newWidget) {
    super.update(newWidget);
    _rebuild();
  }

  // When we are assigned a new widget, we store it here
  // until we are ready to update to it.
  Widget? _newWidget;

  @override
  void performRebuild() {
    if (_newWidget != null) {
      // _newWidget can be null if, for instance, we were rebuilt
      // due to a reassemble.
      final Widget newWidget = _newWidget!;
      _newWidget = null;
      update(newWidget as RenderObjectToWidgetAdapter<T>);
    }
    super.performRebuild();
    assert(_newWidget == null);
  }

  void _rebuild() {
    try {
      _child = updateChild(_child, widget.child, _rootChildSlot);
      assert(_child != null);
    } catch (exception, stack) {
      final FlutterErrorDetails details = FlutterErrorDetails(
        exception: exception,
        stack: stack,
        library: 'widgets library',
        context: ErrorDescription('attaching to the render tree'),
      );
      FlutterError.reportError(details);
      final Widget error = ErrorWidget.builder(details);
      _child = updateChild(null, error, _rootChildSlot);
    }
  }

  @override
  MyRenderObjectWithChildMixin<T> get renderObject => super.renderObject as MyRenderObjectWithChildMixin<T>;

  @override
  void insertChildRenderObject(RenderObject child, dynamic slot) {
    assert(slot == _rootChildSlot);
    assert(renderObject.debugValidateChild(child));
    renderObject.child = child as T;
    super.insertChildRenderObject(child, slot);
  }

  @override
  void moveChildRenderObject(RenderObject child, dynamic slot) {
    assert(false);
    super.moveChildRenderObject(child, slot);
  }

  @override
  void removeChildRenderObject(RenderObject child) {
    assert(renderObject.child == child);
    renderObject.child = null;
    super.removeChildRenderObject(child);
  }
}
