import 'dart:typed_data';

import 'utils.dart';

part 'guid.dart';
part 'guid_value.dart';

class _Guid {
  static const String defaultGuid = '00000000-0000-0000-0000-000000000000';

  static final List<String> _byteToHex = List<String>.generate(256, (int i) {
    return i.toRadixString(16).padLeft(2, '0');
  });

  /// Validates the provided [guid] to make sure it has all the necessary
  /// components and formatting and returns a [bool]
  /// You can choose to validate from a string or from a byte list based on
  /// which parameter is passed.
  static bool isValidGUID({
    String fromString = '',
    Uint8List? fromByteList,
  }) {
    String _fromString = fromString;

    if (fromByteList != null) {
      _fromString = unparse(fromByteList);
    }
    // GUID of all 0s is ok.
    if (_fromString == defaultGuid) {
      return true;
    }

    // If its not 36 characters in length, don't bother (including dashes).
    if (_fromString.length != 36) {
      return false;
    }

    // Make sure if it passes the above, that it's a valid GUID.
    const String pattern =
        r'^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[0-9a-f]{4}-[0-9a-f]{12}$';
    final RegExp regex = RegExp(pattern, caseSensitive: false, multiLine: true);
    final bool match = regex.hasMatch(_fromString);
    return match;
  }

  static GuidValue generate() {
    // Use provided values over RNG
    final Uint8List rnds = RNG.mathRNG();

    // per 4.4, set bits for version and clockSeq high and reserved
    rnds[6] = (rnds[6] & 0x0f) | 0x40;
    rnds[8] = (rnds[8] & 0x3f) | 0x80;

    return GuidValue(unparse(rnds), rnds);
  }

  static Uint8List parse(String guid, {Uint8List? buffer, int offset = 0}) {
    final int i = offset;
    int ii = 0;

    // Create a 16 item buffer if one hasn't been provided.
    final Uint8List _buffer = buffer ?? Uint8List(16);

    // Convert to lowercase and replace all hex with bytes then
    // string.replaceAll() does a lot of work that I don't need, and a manual
    // regex gives me more control.
    final RegExp regex = RegExp('[0-9a-f]{2}');
    for (final Match match in regex.allMatches(guid.toLowerCase())) {
      if (ii < 16) {
        final String hex = guid.toLowerCase().substring(match.start, match.end);
        _buffer[i + ii++] = int.parse(hex, radix: 16);
      }
    }

    // Zero out any left over bytes if the string was too short.
    while (ii < 16) {
      _buffer[i + ii++] = 0;
    }

    return _buffer;
  }

  static String unparse(Uint8List buffer, {int offset = 0}) {
    if (buffer.length != 16) {
      throw Exception('The provided buffer needs to have a length of 16.');
    }
    int i = offset;
    return '${_byteToHex[buffer[i++]]}${_byteToHex[buffer[i++]]}'
        '${_byteToHex[buffer[i++]]}${_byteToHex[buffer[i++]]}-'
        '${_byteToHex[buffer[i++]]}${_byteToHex[buffer[i++]]}-'
        '${_byteToHex[buffer[i++]]}${_byteToHex[buffer[i++]]}-'
        '${_byteToHex[buffer[i++]]}${_byteToHex[buffer[i++]]}-'
        '${_byteToHex[buffer[i++]]}${_byteToHex[buffer[i++]]}'
        '${_byteToHex[buffer[i++]]}${_byteToHex[buffer[i++]]}'
        '${_byteToHex[buffer[i++]]}${_byteToHex[buffer[i++]]}';
  }
}
