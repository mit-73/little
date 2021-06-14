import 'dart:math';
import 'dart:typed_data';

/// Random number generator
class RNG {
  static final Random _random = Random();

  /// Math.Random()-based RNG. All platforms, fast, not cryptographically
  /// strong. Optional Seed passable.
  static Uint8List mathRNG({int seed = -1}) {
    final Uint8List b = Uint8List(16);
    final Random rand = (seed == -1) ? _random : Random(seed);

    for (int i = 0; i < 16; i++) {
      b[i] = rand.nextInt(256);
    }

    return b;
  }
}

const int _hashMask = 0x7fffffff;

/// {@template equality}
/// A generic equality relation on objects.
/// {@endtemplate}
abstract class Equality<E> {
  /// {@macro equality}
  const factory Equality() = DefaultEquality<E>;

  /// Compare two elements for being equal.
  ///
  /// This should be a proper equality relation.
  bool equals(E e1, E e2);

  /// Get a hashcode of an element.
  ///
  /// The hashcode should be compatible with [equals], so that if
  /// `equals(a, b)` then `hash(a) == hash(b)`.
  int hash(E e);

  /// Test whether an object is a valid argument to [equals] and [hash].
  ///
  /// Some implementations may be restricted to only work on specific types
  /// of objects.
  bool isValidKey(Object? o);
}

/// {@template default_equality}
/// Equality of objects that compares only the natural equality of the objects.
///
/// This equality uses the objects' own [Object.==] and [Object.hashCode] for
/// the equality.
///
/// Note that [equals] and [hash] take `Object`s rather than `E`s. This allows
/// `E` to be inferred as `Null` in const contexts where `E` wouldn't be a
/// compile-time constant, while still allowing the class to be used at runtime.
/// {@endtemplate}
class DefaultEquality<E> implements Equality<E> {
  /// {@macro default_equality}
  const DefaultEquality();
  @override
  bool equals(Object? e1, Object? e2) => e1 == e2;
  @override
  int hash(Object? e) => e.hashCode;
  @override
  bool isValidKey(Object? o) => true;
}

/// {@template list_equality}
/// Equality on lists.
///
/// Two lists are equal if they have the same length and their elements
/// at each index are equal.
///
/// This is effectively the same as [IterableEquality] except that it
/// accesses elements by index instead of through iteration.
///
/// The [equals] and [hash] methods accepts `null` values,
/// even if the [isValidKey] returns `false` for `null`.
/// The [hash] of `null` is `null.hashCode`.
/// {@endtemplate}
class ListEquality<E> implements Equality<List<E>> {
  /// {@macro list_equality}
  const ListEquality(
      [Equality<E> elementEquality = const DefaultEquality<Never>()])
      : _elementEquality = elementEquality;

  final Equality<E> _elementEquality;

  @override
  bool equals(List<E>? list1, List<E>? list2) {
    if (identical(list1, list2)) return true;
    if (list1 == null || list2 == null) return false;
    final int length = list1.length;
    if (length != list2.length) return false;
    for (int i = 0; i < length; i++) {
      if (!_elementEquality.equals(list1[i], list2[i])) return false;
    }
    return true;
  }

  @override
  int hash(List<E>? list) {
    if (list == null) return null.hashCode;
    // Jenkins's one-at-a-time hash function.
    // This code is almost identical to the one in IterableEquality, except
    // that it uses indexing instead of iterating to get the elements.
    int hash = 0;
    for (int i = 0; i < list.length; i++) {
      final int c = _elementEquality.hash(list[i]);
      hash = (hash + c) & _hashMask;
      hash = (hash + (hash << 10)) & _hashMask;
      hash ^= hash >> 6;
    }
    hash = (hash + (hash << 3)) & _hashMask;
    hash ^= hash >> 11;
    hash = (hash + (hash << 15)) & _hashMask;
    return hash;
  }

  @override
  bool isValidKey(Object? o) => o is List<E>;
}
