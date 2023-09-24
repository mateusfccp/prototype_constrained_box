import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// A widget that imposes additional constraints on its child, based on a [prototype].
///
/// For example, if you wanted [child] to be constrained to the exact size of a text,
/// you could do:
///
/// ```dart
/// const PrototypeConstrainedBox.tight(
///   prototype: Text('Lorem ipsum dolor'),
///   child: ColoredBox(
///     color: Color(0xFFFF0000),
///   ),
/// );
/// ```
///
/// See also:
///
///  * [ConstrainedBox](https://api.flutter.dev/flutter/widgets/ConstrainedBox-class.html), the equivalent class that receives a [BoxConstraints](https://api.flutter.dev/flutter/rendering/BoxConstraints-class.html) instead of a [prototype].
final class PrototypeConstrainedBox extends RenderObjectWidget {
  /// Constrains the given [child] to have the exact same size as [prototype].
  const PrototypeConstrainedBox.tight({
    super.key,
    required this.prototype,
    required this.child,
  })  : constrainMinWidth = true,
        constrainMaxWidth = true,
        constrainMinHeight = true,
        constrainMaxHeight = true;

  /// Constrains the given [child] to have the exact same size as [prototype].
  const PrototypeConstrainedBox.tightFor({
    super.key,
    bool width = false,
    bool height = false,
    required this.prototype,
    required this.child,
  })  : constrainMinWidth = width,
        constrainMaxWidth = width,
        constrainMinHeight = height,
        constrainMaxHeight = height;

  /// Constrains the given [child] to forbid it to be larger than [prototype].
  const PrototypeConstrainedBox.loose({
    super.key,
    required this.prototype,
    required this.child,
  })  : constrainMinWidth = false,
        constrainMaxWidth = true,
        constrainMinHeight = false,
        constrainMaxHeight = true;

  /// Creates a widget that imposes the [prototype] constraints on its [child].
  ///
  /// The [prototype] widget is used as a reference for applying constraints to
  /// the [child].
  ///
  /// The [horizontalConstraint] and [verticalConstraint] parameters allow you
  /// to specify the constraint type for each axis independently.
  const PrototypeConstrainedBox({
    super.key,
    required this.constrainMinWidth,
    required this.constrainMaxWidth,
    required this.constrainMinHeight,
    required this.constrainMaxHeight,
    required this.prototype,
    required this.child,
  });

  /// The widget whose constraints are going to be imposed in [child].
  ///
  /// This widget is never laid out, as we use [RenderBox.computeDryLayout] to
  /// compute its size.
  ///
  /// This widget is never painted.
  ///
  /// The semantics of this widget are not included in the semantics tree.
  final Widget prototype;

  /// The widget below this widget in the tree.
  final Widget? child;

  final bool constrainMinWidth;
  final bool constrainMaxWidth;
  final bool constrainMinHeight;
  final bool constrainMaxHeight;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderPrototypeConstrainedBox(
      constrainMinWidth,
      constrainMaxWidth,
      constrainMinHeight,
      constrainMaxHeight,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderPrototypeConstrainedBox renderObject) {
    renderObject.constrainMinWidth = constrainMinWidth;
    renderObject.constrainMaxWidth = constrainMaxWidth;
    renderObject.constrainMinHeight = constrainMinHeight;
    renderObject.constrainMaxHeight = constrainMaxHeight;
  }

  @override
  RenderObjectElement createElement() => _PrototypeConstrainedBoxElement(this);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Widget>('prototype', prototype));
    properties.add(DiagnosticsProperty<Widget>('child', child));
    properties.add(FlagProperty('constrainMinWidth', value: constrainMinWidth));
    properties.add(FlagProperty('constrainMaxWidth', value: constrainMaxWidth));
    properties.add(FlagProperty('constrainMinHeight', value: constrainMinHeight));
    properties.add(FlagProperty('constrainMaxHeight', value: constrainMaxHeight));
  }
}

final class RenderPrototypeConstrainedBox extends RenderProxyBox {
  RenderPrototypeConstrainedBox(
    this._constrainMinWidth,
    this._constrainMaxWidth,
    this._constrainMinHeight,
    this._constrainMaxHeight,
  );

  bool get constrainMinWidth => _constrainMinWidth;
  bool _constrainMinWidth;

  set constrainMinWidth(bool value) {
    if (_constrainMinWidth != value) {
      _constrainMinWidth = value;
      markNeedsLayout();
    }
  }

  bool get constrainMaxWidth => _constrainMaxWidth;
  bool _constrainMaxWidth;

  set constrainMaxWidth(bool value) {
    if (_constrainMaxWidth != value) {
      _constrainMaxWidth = value;
      markNeedsLayout();
    }
  }

  bool get constrainMinHeight => _constrainMinHeight;
  bool _constrainMinHeight;

  set constrainMinHeight(bool value) {
    if (_constrainMinHeight != value) {
      _constrainMinHeight = value;
      markNeedsLayout();
    }
  }

  bool get constrainMaxHeight => _constrainMaxHeight;
  bool _constrainMaxHeight;

  set constrainMaxHeight(bool value) {
    if (_constrainMaxHeight != value) {
      _constrainMaxHeight = value;
      markNeedsLayout();
    }
  }

  RenderBox? _prototype;

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

  BoxConstraints? _prototypeConstraints;

  void _computePrototypeConstraints() {
    final size = prototype!.getDryLayout(constraints);

    _prototypeConstraints = BoxConstraints(
      minWidth: constrainMinWidth ? size.width : 0.0,
      maxWidth: constrainMaxWidth ? size.width : double.infinity,
      minHeight: constrainMinHeight ? size.height : 0.0,
      maxHeight: constrainMaxHeight ? size.height : double.infinity,
    );
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    final constraints = _prototypeConstraints!;
    if (constraints.hasBoundedWidth && constraints.hasTightWidth) {
      return constraints.minWidth;
    } else {
      final width = super.computeMinIntrinsicWidth(height);

      assert(width.isFinite);

      if (constraints.hasInfiniteWidth) {
        return width;
      } else {
        return constraints.constrainWidth(width);
      }
    }
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final constraints = _prototypeConstraints!;
    if (constraints.hasBoundedWidth && constraints.hasTightWidth) {
      return constraints.minWidth;
    } else {
      final width = super.computeMaxIntrinsicWidth(height);

      assert(width.isFinite);

      if (constraints.hasInfiniteWidth) {
        return width;
      } else {
        return constraints.constrainWidth(width);
      }
    }
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final constraints = _prototypeConstraints!;
    if (constraints.hasBoundedHeight && constraints.hasTightHeight) {
      return constraints.minHeight;
    } else {
      final height = super.computeMinIntrinsicHeight(width);

      assert(height.isFinite);

      if (constraints.hasInfiniteHeight) {
        return height;
      } else {
        return constraints.constrainWidth(height);
      }
    }
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    final constraints = _prototypeConstraints!;
    if (constraints.hasBoundedHeight && constraints.hasTightHeight) {
      return constraints.minHeight;
    } else {
      final height = super.computeMaxIntrinsicHeight(width);

      assert(height.isFinite);

      if (constraints.hasInfiniteHeight) {
        return height;
      } else {
        return constraints.constrainWidth(height);
      }
    }
  }

  @override
  void performLayout() {
    _computePrototypeConstraints();

    final constraints = _prototypeConstraints!;

    if (child case final child?) {
      child.layout(
        constraints.enforce(this.constraints),
        parentUsesSize: true,
      );
      size = child.size;
    } else {
      size = _prototypeConstraints!.enforce(constraints).constrain(Size.zero);
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    if (child case final child?) {
      return child.getDryLayout(
        _prototypeConstraints!.enforce(constraints),
      );
    } else {
      return _prototypeConstraints!.enforce(constraints).constrain(Size.zero);
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
      if (prototype case final prototype?) prototype.toDiagnosticsNode(name: 'prototype'),
    ];
  }
}

final class _PrototypeConstrainedBoxElement extends RenderObjectElement {
  _PrototypeConstrainedBoxElement(super.widget);

  Element? _prototype;
  Element? _child;

  static final _prototypeSlot = Object();
  static final _childSlot = Object();

  @override
  void visitChildren(ElementVisitor visitor) {
    final prototype = _prototype;
    if (prototype != null) {
      visitor(prototype);
    }

    final child = _child;
    if (child != null) {
      visitor(child);
    }
  }

  @override
  void forgetChild(Element child) {
    if (child == _child) {
      _child = null;
    } else if (child == _prototype) {
      _prototype = null;
    } else {
      assert(false);
    }
    super.forgetChild(child);
  }

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    final widget = this.widget as PrototypeConstrainedBox;
    _prototype = updateChild(_prototype, widget.prototype, _prototypeSlot);
    _child = updateChild(_child, widget.child, _childSlot);
  }

  @override
  void update(RenderObjectWidget newWidget) {
    super.update(newWidget);
    final widget = this.widget as PrototypeConstrainedBox;
    assert(widget == newWidget);
    _prototype = updateChild(_prototype, widget.prototype, _prototypeSlot);
    _child = updateChild(_child, widget.child, _childSlot);
  }

  @override
  void insertRenderObjectChild(RenderBox child, Object? slot) {
    final renderObject = this.renderObject as RenderPrototypeConstrainedBox;
    if (slot == _childSlot) {
      renderObject.child = child;
    } else if (slot == _prototypeSlot) {
      renderObject.prototype = child;
    }
  }

  @override
  void moveRenderObjectChild(RenderObject child, Object? oldSlot, Object? newSlot) {
    assert(false);
  }

  @override
  void removeRenderObjectChild(RenderObject child, Object? slot) {
    final renderObject = this.renderObject as RenderPrototypeConstrainedBox;
    if (slot == _childSlot) {
      assert(renderObject.child == child);
      renderObject.child = null;
    } else if (slot == _prototypeSlot) {
      assert(renderObject.prototype == child);
      renderObject.prototype = null;
    } else {
      assert(false);
    }
    assert(renderObject == this.renderObject);
  }
}
