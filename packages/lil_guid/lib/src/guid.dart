part of '_guid.dart';

/// A GUID is a 128-bit integer (16 bytes) that can be used across all computers and networks wherever a unique identifier is required.
/// Such an identifier has a very low probability of being duplicated.
///
/// Example with generation:
/// ```dart
/// Guid guid = Guid();
/// print(guid.toString());
/// print(guid.toBytes());
/// print(guid.toList());
/// ```
///
/// Example with parsing from a string
/// ```dart
/// Guid guid = Guid.parseString('ca761232-ed42-11ce-bacd-00aa0057b223');
/// print(guid.toString());
/// print(guid.toBytes());
/// print(guid.toList());
/// ```
///
/// Example with parsing from the list
/// ```dart
/// Guid guid = Guid.parseList(<int>[46,231,148,107,159,84,71,138,151,217,240,247,110,166,105,62]);
/// print(guid.toString());
/// print(guid.toBytes());
/// print(guid.toList());
/// ```
///
/// Example with parsing from a byte array
/// ```dart
/// Guid guid = Guid.parseBytes(Uint8List.fromList(<int>[46,231,148,107,159,84,71,138,151,217,240,247,110,166,105,62]));
/// print(guid.toString());
/// print(guid.toBytes());
/// print(guid.toList());
/// ```
class Guid {
  /// Initializes a new instance of the Guid structure.
  factory Guid() {
    return Guid._(_Guid.generate());
  }

  /// Initializes a new instance of the Guid structure by using the value represented by the specified string.
  ///
  /// If the [guid] does not contain a valid literal,
  /// optionally prefixed by a sign, a [FormatException] is thrown.
  ///
  /// Instead of throwing and immediately catching the [FormatException],
  /// instead use [tryParseString] to handle a parsing error.
  factory Guid.parseString(String guid) {
    if (guid.isEmpty) {
      throw FormatException('Value "$guid" is empty');
    }

    if (_Guid.isValidGUID(fromString: guid)) {
      return Guid._(GuidValue(guid, _Guid.parse(guid)));
    } else {
      throw FormatException('Value "$guid" is not a valid GUID');
    }
  }

  /// Initializes a new instance of the Guid structure by using the value represented by the specified string.
  ///
  /// Like [parseString] except that this function returns null where a similar call to [parse] would throw a [FormatException].
  factory Guid.tryParseString(String guid) {
    if (guid.isNotEmpty && _Guid.isValidGUID(fromString: guid)) {
      return Guid._(GuidValue(guid, _Guid.parse(guid)));
    }

    return Guid._();
  }

  /// Initializes a new instance of the Guid structure by using the specified List of int.
  ///
  /// If the [guid] does not contain a valid literal,
  /// optionally prefixed by a sign, a [FormatException] is thrown.
  ///
  /// Instead of throwing and immediately catching the [FormatException],
  /// instead use [tryParseList] to handle a parsing error.
  factory Guid.parseList(List<int> guid) {
    if (guid.isEmpty) {
      throw FormatException('Value "$guid" is empty');
    }

    final Uint8List bytes = Uint8List.fromList(guid);

    if (_Guid.isValidGUID(fromByteList: bytes)) {
      return Guid._(GuidValue(_Guid.unparse(bytes), bytes));
    } else {
      throw FormatException('Value "$guid" is not a valid GUID');
    }
  }

  /// Initializes a new instance of the Guid structure by using the specified List of int.
  ///
  /// Like [parseList] except that this function returns null where a similar call to [parse] would throw a [FormatException].
  factory Guid.tryParseList(List<int> guid) {
    final Uint8List bytes = Uint8List.fromList(guid);

    if (guid.isNotEmpty && _Guid.isValidGUID(fromByteList: bytes)) {
      return Guid._(GuidValue(_Guid.unparse(bytes), bytes));
    }

    return Guid._();
  }

  /// Initializes a new instance of the Guid structure by using the specified array of bytes.
  ///
  /// If the [guid] does not contain a valid literal,
  /// optionally prefixed by a sign, a [FormatException] is thrown.
  ///
  /// Instead of throwing and immediately catching the [FormatException],
  /// instead use [tryParseBytes] to handle a parsing error.
  factory Guid.parseBytes(Uint8List guid) {
    if (guid.isEmpty) {
      throw FormatException('Value "$guid" is empty');
    }

    if (_Guid.isValidGUID(fromByteList: guid)) {
      return Guid._(GuidValue(_Guid.unparse(guid), guid));
    } else {
      throw FormatException('Value "$guid" is not a valid GUID');
    }
  }

  /// Initializes a new instance of the Guid structure by using the specified array of bytes.
  ///
  /// Like [parseBytes] except that this function returns null where a similar call to [parse] would throw a [FormatException].
  factory Guid.tryParseBytes(Uint8List guid) {
    if (guid.isNotEmpty && _Guid.isValidGUID(fromByteList: guid)) {
      return Guid._(GuidValue(_Guid.unparse(guid), guid));
    }

    return Guid._();
  }

  Guid._([GuidValue? guidValue]) {
    if (guidValue != null) {
      _guidValue = guidValue;
      return;
    }

    _guidValue = GuidValue(
      _Guid.defaultGuid,
      _Guid.parse(_Guid.defaultGuid),
    );
  }

  /// Initializes a new instance of the Guid structure.
  static Guid get newGuid => Guid();

  /// A read-only instance of the Guid structure whose value is all zeros.
  static Guid get empty => Guid._();

  late GuidValue _guidValue;

  /// Returns a string representation of the value of this instance in registry format.
  @override
  String toString() => _guidValue.value;

  /// Returns a 16-element byte array that contains the value of this instance.
  Uint8List toBytes() => _guidValue.bytes;

  /// Returns a 16-element List that contains the value of this instance.
  List<int> toList() => _guidValue.bytes.toList();

  /// Compares this instance to a specified Guid object and returns an indication of their relative values.
  ///
  /// Returns a negative value if this is ordered before other,
  ///  a positive value if this is ordered after other, or zero if this and other are equivalent.
  int compareTo(Guid guid) => _guidValue.compareTo(guid._guidValue);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Guid && other._guidValue == _guidValue;
  }

  @override
  int get hashCode => _guidValue.hashCode;
}
