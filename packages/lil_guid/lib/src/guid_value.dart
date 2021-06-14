part of '_guid.dart';

/// {@template guid_value}
///
/// {@endtemplate}
/// Tuple of guid value
class GuidValue {
  /// {@macro guid_value}
  const GuidValue(this.value, this.bytes);

  static const ListEquality<int> _equality = ListEquality<int>();

  /// guid string value
  final String value;

  /// guid byte value
  final Uint8List bytes;

  /// Compares this string to [other].
  ///
  /// Returns a negative value if `this` is ordered before `other`,
  /// a positive value if `this` is ordered after `other`,
  /// or zero if `this` and `other` are equivalent.
  int compareTo(GuidValue guid) {
    final int _value = value.compareTo(guid.value);
    final int _bytes = _compareList(bytes, guid.bytes);

    final int temp = _value + _bytes;

    if (temp > 0) return 1;
    if (temp < 0) return -1;
    return 0;
  }

  int _compareList(Uint8List first, Uint8List second) {
    if (first.length != second.length) {
      throw Exception(
          'First bytes (${first.length}) size does not equal the size of Second bytes (${second.length}) list');
    }

    int temp = 0;

    for (int i = 0; i < first.length; i++) {
      temp += first[i].compareTo(second[i]);
    }

    if (temp > 0) return 1;
    if (temp < 0) return -1;
    return 0;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GuidValue &&
        other.value == value &&
        _equality.equals(other.bytes, bytes);
  }

  @override
  int get hashCode => value.hashCode ^ _equality.hash(bytes);
}
