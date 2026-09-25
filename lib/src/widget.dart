import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'rendering.dart';

/// A widget that imposes additional constraints on its child based on a [prototype].
///
/// For example, if you wanted [child] to be constrained to the exact size of a
/// text, you could do:
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
  ///
  /// If [constrain] is `false`, no constraints from [prototype] are imposed on
  /// [child].
  const PrototypeConstrainedBox.tight({
    super.key,
    bool constrain = true,
    required this.prototype,
    required this.child,
  })  : constrainMinWidth = constrain,
        constrainMaxWidth = constrain,
        constrainMinHeight = constrain,
        constrainMaxHeight = constrain;

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
  ///
  /// If [constrain] is `false`, no constraints from [prototype] are imposed on
  /// [child].
  const PrototypeConstrainedBox.loose({
    super.key,
    bool constrain = true,
    required this.prototype,
    required this.child,
  })  : constrainMinWidth = false,
        constrainMaxWidth = constrain,
        constrainMinHeight = false,
        constrainMaxHeight = constrain;

  /// Creates a widget that imposes the [prototype] constraints on its [child].
  ///
  /// The [prototype] widget is used as a reference for applying constraints to
  /// the [child].
  ///
  /// The [horizontalConstraint] and [verticalConstraint] parameters allow you
  /// to specify the constraint type for each axis independently.
  const PrototypeConstrainedBox({
    super.key,
    required this.prototype,
    required this.child,
    this.constrainMinWidth = false,
    this.constrainMaxWidth = false,
    this.constrainMinHeight = false,
    this.constrainMaxHeight = false,
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
  void updateRenderObject(
      BuildContext context, RenderPrototypeConstrainedBox renderObject) {
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
    properties
        .add(DiagnosticsProperty<bool>('constrainMinWidth', constrainMinWidth));
    properties
        .add(DiagnosticsProperty<bool>('constrainMaxWidth', constrainMaxWidth));
    properties.add(
        DiagnosticsProperty<bool>('constrainMinHeight', constrainMinHeight));
    properties.add(
        DiagnosticsProperty<bool>('constrainMaxHeight', constrainMaxHeight));
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
  void moveRenderObjectChild(
      RenderObject child, Object? oldSlot, Object? newSlot) {
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
