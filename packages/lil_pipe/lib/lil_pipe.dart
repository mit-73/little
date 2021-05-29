library lil_pipe;

import 'dart:collection';

part 'src/set.dart';
part 'src/list.dart';
part 'src/map.dart';

/// Iterable extension
extension IterablePiping<T, E> on Iterable<E> {
  /// Places the left-side `Iterable x` into right-side `Function f` as single argument.
  /// Returns the function result `f(x)`
  T operator >>(T Function(Iterable<E>) f) => f(this);
}