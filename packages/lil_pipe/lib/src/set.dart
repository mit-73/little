part of lil_pipe;

extension SetPiping<T, E> on Set<E> {
  /// Places the left-side `Set x` into right-side `Function f` as single argument.
  /// Returns the function result `f(x)`
  T operator >>(T Function(Set<E>) f) => f(this);
}

extension HashSetPiping<T, E> on HashSet<E> {
  /// Places the left-side `HashSet x` into right-side `Function f` as single argument.
  /// Returns the function result `f(x)`
  T operator >>(T Function(HashSet<E>) f) => f(this);
}

extension LinkedHashSetPiping<T, E> on LinkedHashSet<E> {
  /// Places the left-side `LinkedHashSet x` into right-side `Function f` as single argument.
  /// Returns the function result `f(x)`
  T operator >>(T Function(LinkedHashSet<E>) f) => f(this);
}

extension SplayTreeSetPiping<T, E> on SplayTreeSet<E> {
  /// Places the left-side `SplayTreeSet x` into right-side `Function f` as single argument.
  /// Returns the function result `f(x)`
  T operator >>(T Function(SplayTreeSet<E>) f) => f(this);
}

extension UnmodifiableSetViewPiping<T, E> on UnmodifiableSetView<E> {
  /// Places the left-side `UnmodifiableSetView x` into right-side `Function f` as single argument.
  /// Returns the function result `f(x)`
  T operator >>(T Function(UnmodifiableSetView<E>) f) => f(this);
}