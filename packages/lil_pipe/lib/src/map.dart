part of lil_pipe;

extension MapPiping<T, K, V> on Map<K, V> {
  /// Places the left-side `Map x` into right-side `Function f` as single argument.
  /// Returns the function result `f(x)`
  T operator >>(T Function(Map<K, V>) f) => f(this);
}

extension HashMapPiping<T, K, V> on HashMap<K, V> {
  /// Places the left-side `HashMap x` into right-side `Function f` as single argument.
  /// Returns the function result `f(x)`
  T operator >>(T Function(HashMap<K, V>) f) => f(this);
}

extension LinkedHashMapPiping<T, K, V> on LinkedHashMap<K, V> {
  /// Places the left-side `LinkedHashMap x` into right-side `Function f` as single argument.
  /// Returns the function result `f(x)`
  T operator >>(T Function(LinkedHashMap<K, V>) f) => f(this);
}

extension SplayTreeMapPiping<T, K, V> on SplayTreeMap<K, V> {
  /// Places the left-side `SplayTreeMap x` into right-side `Function f` as single argument.
  /// Returns the function result `f(x)`
  T operator >>(T Function(SplayTreeMap<K, V>) f) => f(this);
}

extension UnmodifiableMapViewPiping<T, K, V> on UnmodifiableMapView<K, V> {
  /// Places the left-side `UnmodifiableMapView x` into right-side `Function f` as single argument.
  /// Returns the function result `f(x)`
  T operator >>(T Function(UnmodifiableMapView<K, V>) f) => f(this);
}
