import 'package:flutter/rendering.dart';

import 'prototype_constraint_type.dart';

class RenderPrototypeConstrainedBox extends RenderBox
    with RenderObjectWithChildMixin<RenderBox>, RenderProxyBoxMixin<RenderBox> {
  RenderPrototypeConstrainedBox(
    this._horizontalConstraint,
    this._verticalConstraint,
  );

  PrototypeConstraintType _horizontalConstraint;

  PrototypeConstraintType get horizontalConstraint => _horizontalConstraint;

  set horizontalConstraint(PrototypeConstraintType value) {
    if (_horizontalConstraint != value) {
      _horizontalConstraint = value;
      markNeedsLayout();
    }
  }

  PrototypeConstraintType _verticalConstraint;

  PrototypeConstraintType get verticalConstraint => _verticalConstraint;

  set verticalConstraint(PrototypeConstraintType value) {
    if (_verticalConstraint != value) {
      _verticalConstraint = value;
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

  BoxConstraints? get _constraints {
    final prototype = this.prototype;

    if (prototype == null) {
      return null;
    } else {
      return BoxConstraints(
        minWidth: horizontalConstraint.applyForMinimum(prototype.size.width),
        maxWidth: horizontalConstraint.applyForMaximum(prototype.size.width),
        minHeight: verticalConstraint.applyForMinimum(prototype.size.height),
        maxHeight: verticalConstraint.applyForMaximum(prototype.size.height),
      );
    }
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    final constraints = _constraints!;
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
    final constraints = _constraints!;
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
    final constraints = _constraints!;
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
    final constraints = _constraints!;
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
    final child = this.child;
    prototype!.layout(this.constraints, parentUsesSize: true);

    final constraints = _constraints!;

    if (child != null) {
      child.layout(constraints.enforce(this.constraints), parentUsesSize: true);
      size = child.size;
    } else {
      size = _constraints!.enforce(constraints).constrain(Size.zero);
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final child = this.child;

    if (child != null) {
      return child.getDryLayout(_constraints!.enforce(constraints));
    } else {
      return _constraints!.enforce(constraints).constrain(Size.zero);
    }
  }

  @override
  void visitChildren(RenderObjectVisitor visitor) {
    final prototype = this.prototype;
    if (prototype != null) {
      visitor(prototype);
    }

    final child = this.child;
    if (child != null) {
      visitor(child);
    }
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    final child = this.child;
    if (child != null) {
      visitor(child);
    }
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);

    final prototype = this.prototype;
    if (prototype != null) {
      prototype.attach(owner);
    }
  }

  @override
  void detach() {
    super.detach();

    final prototype = this.prototype;
    if (prototype != null) {
      prototype.detach();
    }
  }

  @override
  void redepthChildren() {
    final prototype = this.prototype;
    if (prototype != null) {
      redepthChild(prototype);
    }
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    final prototype = this.prototype;
    return [
      if (prototype != null) prototype.toDiagnosticsNode(name: 'prototype'),
      ...super.debugDescribeChildren(),
    ];
  }
}
