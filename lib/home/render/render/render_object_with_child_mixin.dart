import 'package:flutter/rendering.dart';

/// Generic mixin for render objects with one child.
///
/// Provides a child model for a render object subclass that has
/// a unique child, which is accessible via the [child] getter.
///
/// This mixin is typically used to implement render objects created
/// in a [SingleChildRenderObjectWidget].
mixin MyRenderObjectWithChildMixin<ChildType extends RenderObject> on RenderObject {
  /// Checks whether the given render object has the correct [runtimeType] to be
  /// a child of this render object.
  ///
  /// Does nothing if assertions are disabled.
  ///
  /// Always returns true.
  bool debugValidateChild(RenderObject child) {
    return true;
  }

  ChildType? _child;

  /// The render object's unique child
  ChildType? get child => _child;
  set child(ChildType? value) {
    if (_child != null) dropChild(_child!);
    _child = value;
    if (_child != null) adoptChild(_child!);
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    if (_child != null) _child!.attach(owner);
  }

  @override
  void detach() {
    super.detach();
    if (_child != null) _child!.detach();
  }

  @override
  void redepthChildren() {
    if (_child != null) redepthChild(_child!);
  }

  @override
  void visitChildren(RenderObjectVisitor visitor) {
    if (_child != null) visitor(_child!);
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    return child != null ? <DiagnosticsNode>[child!.toDiagnosticsNode(name: 'child')] : <DiagnosticsNode>[];
  }
}
