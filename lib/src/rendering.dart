import 'dart:math';

import 'package:flutter/rendering.dart';

/// A render box that imposes additional constraints on its [child] based on a
/// [prototype].
///
/// A [RenderPrototypeConstrainedBox] proxies most callbacks to its [child],
/// except that when laying out or computing intrinsics, it constrains the
/// [child] based on the dimensions of [prototype] according to
/// [constrainMinWidth], [constrainMaxWidth], [constrainMinHeight], and
/// [constrainMaxHeight].
///
/// See also:
///
///  * [RenderConstrainedBox](https://api.flutter.dev/flutter/rendering/RenderConstrainedBox-class.html), the equivalent class that receives a [BoxConstraints](https://api.flutter.dev/flutter/rendering/BoxConstraints-class.html) instead of a [prototype].
final class RenderPrototypeConstrainedBox extends RenderProxyBox {
  /// Creates a render box that imposes the [prototype] constraints on its
  /// [child].
  ///
  /// The [constrainMinWidth], [constrainMaxWidth], [constrainMinHeight], and
  /// [constrainMaxHeight] parameters allow you to specify which bounds of the
  /// [prototype] size are imposed on each axis independently.
  RenderPrototypeConstrainedBox(
    this._constrainMinWidth,
    this._constrainMaxWidth,
    this._constrainMinHeight,
    this._constrainMaxHeight,
  );

  /// Whether the [child]'s minimum width should be constrained.
  bool get constrainMinWidth => _constrainMinWidth;
  bool _constrainMinWidth;

  set constrainMinWidth(bool value) {
    if (_constrainMinWidth != value) {
      _constrainMinWidth = value;
      markNeedsLayout();
    }
  }

  /// Whether the [child]'s maximum width should be constrained.
  bool get constrainMaxWidth => _constrainMaxWidth;
  bool _constrainMaxWidth;

  set constrainMaxWidth(bool value) {
    if (_constrainMaxWidth != value) {
      _constrainMaxWidth = value;
      markNeedsLayout();
    }
  }

  /// Whether the [child]'s minimum height should be constrained.
  bool get constrainMinHeight => _constrainMinHeight;
  bool _constrainMinHeight;

  set constrainMinHeight(bool value) {
    if (_constrainMinHeight != value) {
      _constrainMinHeight = value;
      markNeedsLayout();
    }
  }

  /// Whether the [child]'s maximum height should be constrained.
  bool get constrainMaxHeight => _constrainMaxHeight;
  bool _constrainMaxHeight;

  set constrainMaxHeight(bool value) {
    if (_constrainMaxHeight != value) {
      _constrainMaxHeight = value;
      markNeedsLayout();
    }
  }

  RenderBox? _prototype;

  /// The render box whose constraints are going to be imposed in [child].
  ///
  /// This render box is never laid out, as we use [RenderBox.getDryLayout] to
  /// compute its size.
  ///
  /// This render box is never painted.
  ///
  /// The semantics of this render box are not included in the semantics tree.
  RenderBox? get prototype => _prototype;

  set prototype(RenderBox? value) {
    if (_prototype != null) {
      dropChild(_prototype!);
    }
    _prototype = value;
    if (_prototype != null) {
      adoptChild(_prototype!);
    }
    markNeedsLayout();
  }

  BoxConstraints _computePrototypeConstraints(BoxConstraints constraints) {
    if (!constrainMinWidth &&
        !constrainMaxWidth &&
        !constrainMinHeight &&
        !constrainMaxHeight) {
      return const BoxConstraints();
    }

    final size = prototype!.getDryLayout(constraints);

    return BoxConstraints(
      minWidth: constrainMinWidth ? size.width : 0.0,
      maxWidth: constrainMaxWidth ? size.width : double.infinity,
      minHeight: constrainMinHeight ? size.height : 0.0,
      maxHeight: constrainMaxHeight ? size.height : double.infinity,
    );
  }

  @pragma('vm:prefer-inline')
  @pragma('wasm:prefer-inline')
  @pragma('dart2js:tryInline')
  double _computeIntrinsic({
    required double extent,
    required bool constrainMin,
    required bool constrainMax,
    required double Function(double extent) computeChildIntrinsic,
    required double Function(double extent) computePrototypeIntrinsic,
  }) {
    final childExtent = computeChildIntrinsic(extent);
    if (!constrainMin && !constrainMax) return childExtent;

    final prototypeExtent = computePrototypeIntrinsic(extent);

    if (constrainMin && constrainMax) {
      return prototypeExtent;
    } else {
      return constrainMax
          ? min(childExtent, prototypeExtent)
          : max(childExtent, prototypeExtent);
    }
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return _computeIntrinsic(
      extent: height,
      constrainMin: constrainMinWidth,
      constrainMax: constrainMaxWidth,
      computeChildIntrinsic: super.computeMinIntrinsicWidth,
      computePrototypeIntrinsic: prototype!.getMinIntrinsicWidth,
    );
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return _computeIntrinsic(
      extent: height,
      constrainMin: constrainMinWidth,
      constrainMax: constrainMaxWidth,
      computeChildIntrinsic: super.computeMaxIntrinsicWidth,
      computePrototypeIntrinsic: prototype!.getMaxIntrinsicWidth,
    );
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return _computeIntrinsic(
      extent: width,
      constrainMin: constrainMinHeight,
      constrainMax: constrainMaxHeight,
      computeChildIntrinsic: super.computeMinIntrinsicHeight,
      computePrototypeIntrinsic: prototype!.getMinIntrinsicHeight,
    );
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return _computeIntrinsic(
      extent: width,
      constrainMin: constrainMinHeight,
      constrainMax: constrainMaxHeight,
      computeChildIntrinsic: super.computeMaxIntrinsicHeight,
      computePrototypeIntrinsic: prototype!.getMaxIntrinsicHeight,
    );
  }

  @override
  void performLayout() {
    final prototypeConstraints = _computePrototypeConstraints(constraints);

    if (child case final child?) {
      child.layout(
        prototypeConstraints.enforce(constraints),
        parentUsesSize: true,
      );
      size = child.size;
    } else {
      size = prototypeConstraints.enforce(constraints).constrain(Size.zero);
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final prototypeConstraints = _computePrototypeConstraints(constraints);

    if (child case final child?) {
      return child.getDryLayout(
        prototypeConstraints.enforce(constraints),
      );
    } else {
      return prototypeConstraints.enforce(constraints).constrain(Size.zero);
    }
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    prototype?.attach(owner);
  }

  @override
  void detach() {
    super.detach();
    prototype?.detach();
  }

  @override
  void redepthChildren() {
    super.redepthChildren();
    if (prototype case final prototype?) {
      redepthChild(prototype);
    }
  }

  @override
  void visitChildren(RenderObjectVisitor visitor) {
    if (child case final child?) {
      visitor(child);
    }
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    return [
      ...super.debugDescribeChildren(),
      if (prototype case final prototype?)
        prototype.toDiagnosticsNode(
          name: 'prototype',
          style: DiagnosticsTreeStyle.offstage,
        ),
    ];
  }
}
