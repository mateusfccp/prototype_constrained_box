enum PrototypeConstraintType {
  unconstrained,
  loose,
  tight;

  // TODO(mateusfccp): User proper destructuring with records when available
  double applyForMinimum(double x) {
    switch (this) {
      case unconstrained:
        return 0.0;
      case loose:
        return 0.0;
      case tight:
        return x;
    }
  }

  // TODO(mateusfccp): User proper destructuring with records when available
  double applyForMaximum(double x) {
    switch (this) {
      case unconstrained:
        return double.infinity;
      case loose:
        return x;
      case tight:
        return x;
    }
  }
}
