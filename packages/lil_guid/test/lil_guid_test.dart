import 'package:test/test.dart';
import 'package:lil_guid/lil_guid.dart';

void main() {
  test('RuntimeType test', () {
    final Guid v0 = Guid();

    expect(v0.runtimeType, Guid);
  });

  test('Empty test', () {
    final Guid v0 = Guid.empty;
    const String v1 = '00000000-0000-0000-0000-000000000000';

    expect(v0.toString(), v1);
  });

  test('Parse String & List test', () {
    final Guid v0 = Guid.parseString('ca761232-ed42-11ce-bacd-00aa0057b223');
    final Guid v1 = Guid.parseList(<int>[
      202,
      118,
      18,
      50,
      237,
      66,
      17,
      206,
      186,
      205,
      0,
      170,
      0,
      87,
      178,
      35
    ]);

    expect(v0, v1);
    expect(v0 == v1, true);
    expect(v0.hashCode, v1.hashCode);
  });

  test('Compare test', () {
    final Guid base = Guid.parseString('01e75c83-c6f5-4192-b57e-7427cec5560d');
    final Guid positive =
        Guid.parseString('01e75c83-c6f5-4192-b57e-7427cec5560c');
    final Guid negative =
        Guid.parseString('01e75c84-c6f5-4192-b57e-7427cec5560d');

    expect(base.compareTo(positive), 1);
    expect(base.compareTo(base), 0);
    expect(base.compareTo(negative), -1);
  });

  test("Make sure that really fast GUID doesn't produce duplicates", () {
    final List<Guid> list =
        List<Object?>.filled(1000, null).map<Guid>((_) => Guid()).toList();
    final Set<Guid> setList = list.toSet();

    expect(list.length, setList.length);
  });

  test(
      "Another round of testing Guid to make sure it doesn't produce duplicates on high amounts of entries.",
      () {
    const int numToGenerate = 3 * 1000 * 1000;
    final Set<String> values = <String>{}; // set of strings

    int numDuplicates = 0;
    for (int i = 0; i < numToGenerate; i++) {
      final Guid uuid = Guid();

      if (!values.contains(uuid.toString())) {
        values.add(uuid.toString());
      } else {
        numDuplicates++;
      }
    }

    expect(numDuplicates, 0, reason: 'duplicate GUIDs generated');
  });

  test('Check if Guid supports Microsoft Guid', () {
    const String guidString = '2400ee73-282c-4334-e153-08d8f922d1f9';
    final Guid isValidNonStrict = Guid.parseString(guidString);

    expect(isValidNonStrict.toString(), guidString);
  });
}
