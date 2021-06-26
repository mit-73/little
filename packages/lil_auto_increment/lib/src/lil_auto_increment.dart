/// Function id type
typedef Id = int Function();

/// Auto increment
///
/// Example:
/// ```dart
/// final Id nextId = autoIncrement();
/// final Id testId = autoIncrement();
///
/// print(nextId()); // 1
/// print(nextId()); // 2
/// print(testId()); // 1
/// print(nextId()); // 3
/// ```
final Id Function() autoIncrement = () {
  int id = 0;
  return () => ++id;
};
