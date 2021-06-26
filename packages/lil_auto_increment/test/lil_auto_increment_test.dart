import 'package:lil_auto_increment/lil_auto_increment.dart';
import 'package:test/test.dart';

void main() {
  final Id nextId1 = autoIncrement();
  final Id nextId2 = autoIncrement();

  test('First Test', () {
    for (int i = 0; i < 5; i++) {
      expect(nextId1(), i + 1);
    }
    for (int i = 0; i < 10; i++) {
      expect(nextId2(), i + 1);
    }
  });

  test('Second Test', () {
    expect(nextId1(), 6);
    expect(nextId2(), 11);
  });
}
