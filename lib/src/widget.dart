import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'element.dart';
import 'constraint_type.dart';
import 'rendering.dart';

/// A widget that imposes additional constraints on its child, based on a [prototype].
///
/// For example, if you wanted [child] to be constrained to the exact size of a text,
/// you could do:
///
/// ```dart
/// PrototypeConstrainedBox.tight(
///   prototype: Text('Lorem ipsum dolor'),
///   child: ColoredBox(color: Color(0xFFFF0000)),
/// );
/// ```
///
/// See also:
///
///  * [ConstrainedBox](https://api.flutter.dev/flutter/widgets/ConstrainedBox-class.html), the equivalent class that receives a [BoxConstraints](https://api.flutter.dev/flutter/rendering/BoxConstraints-class.html) instead of a [prototype].
class PrototypeConstrainedBox extends RenderObjectWidget {
  /// Constrains the given [child] to have the exact same size as [prototype].
  const PrototypeConstrainedBox.tight({
    super.key,
    required this.prototype,
    required this.child,
  })  : _horizontalConstraint = ConstraintType.tight,
        _verticalConstraint = ConstraintType.tight;

  /// Constrains the given [child] to have the exact same width as [prototype].
  const PrototypeConstrainedBox.tightHorizontal({
    super.key,
    required this.prototype,
    required this.child,
  })  : _horizontalConstraint = ConstraintType.tight,
        _verticalConstraint = ConstraintType.unconstrained;

  /// Constrains the given [child] to have the exact same height as [prototype].
  const PrototypeConstrainedBox.tightVertical({
    super.key,
    required this.prototype,
    required this.child,
  })  : _horizontalConstraint = ConstraintType.unconstrained,
        _verticalConstraint = ConstraintType.tight;

  /// Constrains the given [child] to forbid it to be larger than [prototype].
  const PrototypeConstrainedBox.loose({
    super.key,
    required this.prototype,
    required this.child,
  })  : _horizontalConstraint = ConstraintType.loose,
        _verticalConstraint = ConstraintType.loose;

  /// Constrains the given [child] to forbid it to be wider than [prototype].
  const PrototypeConstrainedBox.looseHorizontal({
    super.key,
    required this.prototype,
    required this.child,
  })  : _horizontalConstraint = ConstraintType.loose,
        _verticalConstraint = ConstraintType.unconstrained;

  /// Constrains the given [child] to forbid it to be taller than [prototype].
  const PrototypeConstrainedBox.looseVertical({
    super.key,
    required this.prototype,
    required this.child,
  })  : _horizontalConstraint = ConstraintType.unconstrained,
        _verticalConstraint = ConstraintType.loose;

  /// The widget whose constraints are going to be imposed in [child].
  ///
  /// This widget pass through the layout phase, as it needs to be laid out for we to know it's constraints.
  /// However, it does not pass through the paint phase, and is, thus, not visible in any way.
  final Widget prototype;

  /// The widget below this widget in the tree.
  final Widget? child;

  final ConstraintType _horizontalConstraint;
  final ConstraintType _verticalConstraint;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderPrototypeConstrainedBox(
      _horizontalConstraint,
      _verticalConstraint,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderPrototypeConstrainedBox renderObject) {
    renderObject.horizontalConstraint = _horizontalConstraint;
    renderObject.verticalConstraint = _verticalConstraint;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Widget>('prototype', prototype));
    properties.add(DiagnosticsProperty<Widget>('child', child));
    properties.add(
      DiagnosticsProperty<ConstraintType>('horizontal constraint', _horizontalConstraint),
    );
    properties.add(
      DiagnosticsProperty<ConstraintType>('vertical constraint', _verticalConstraint),
    );
  }

  @override
  RenderObjectElement createElement() => PrototypeConstrainedBoxElement(this);
}
