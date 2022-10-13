import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'element.dart';
import 'prototype_constraint_type.dart';
import 'rendering.dart';

class PrototypeConstrainedBox extends RenderObjectWidget {
  const PrototypeConstrainedBox.tight({
    super.key,
    required this.prototype,
    required this.child,
  })  : _horizontalConstraint = PrototypeConstraintType.tight,
        _verticalConstraint = PrototypeConstraintType.tight;

  const PrototypeConstrainedBox.tightHorizontal({
    super.key,
    required this.prototype,
    required this.child,
  })  : _horizontalConstraint = PrototypeConstraintType.tight,
        _verticalConstraint = PrototypeConstraintType.unconstrained;

  const PrototypeConstrainedBox.tightVertical({
    super.key,
    required this.prototype,
    required this.child,
  })  : _horizontalConstraint = PrototypeConstraintType.unconstrained,
        _verticalConstraint = PrototypeConstraintType.tight;

  const PrototypeConstrainedBox.loose({
    super.key,
    required this.prototype,
    required this.child,
  })  : _horizontalConstraint = PrototypeConstraintType.loose,
        _verticalConstraint = PrototypeConstraintType.loose;

  const PrototypeConstrainedBox.looseHorizontal({
    super.key,
    required this.prototype,
    required this.child,
  })  : _horizontalConstraint = PrototypeConstraintType.loose,
        _verticalConstraint = PrototypeConstraintType.unconstrained;

  const PrototypeConstrainedBox.looseVertical({
    super.key,
    required this.prototype,
    required this.child,
  })  : _horizontalConstraint = PrototypeConstraintType.unconstrained,
        _verticalConstraint = PrototypeConstraintType.loose;

  final Widget prototype;
  final Widget? child;

  final PrototypeConstraintType _horizontalConstraint;
  final PrototypeConstraintType _verticalConstraint;

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
    properties.add(DiagnosticsProperty<PrototypeConstraintType>('horizontal constraint', _horizontalConstraint));
    properties.add(DiagnosticsProperty<PrototypeConstraintType>('vertical constraint', _verticalConstraint));
  }

  @override
  RenderObjectElement createElement() => PrototypeConstrainedBoxElement(this);
}
