enum ConstraintType {
  unconstrained,
  loose,
  tight;

  double applyForMinimum(double value) {
    return switch (this) {
      tight => value,
      _ => 0.0,
    };
  }

  double applyForMaximum(double value) {
    return switch (this) {
      unconstrained => double.infinity,
      _ => value,
    };
  }
}
