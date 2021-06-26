# lil_guid
[![pub package](https://img.shields.io/pub/v/lil_auto_increment.svg)](https://pub.dartlang.org/packages/lil_auto_increment)

The library for creating generator function that does auto increment value.

## Installation

Add on pubspec.yml:

```
dependencies:
  lil_auto_increment: ... // latest package version
```

## Usage

A simple usage example:

```dart
import 'dart:developer';

import 'package:lil_auto_increment/lil_auto_increment.dart';

void main() {
  final Id nextId1 = autoIncrement();
  final Id nextId2 = autoIncrement();

  for (int i = 0; i < 5; i++) {
    log(nextId1().toString(), name: 'nextId1'); // 1..5
  }
  for (int i = 0; i < 10; i++) {
    log(nextId2().toString(), name: 'nextId2'); // 1..10
  }
  for (int i = 0; i < 5; i++) {
    log(nextId1().toString(), name: 'nextId1'); // 5..10
  }
}
```

## Example
The [Example][example] is in the corresponding folder

[example]: https://github.com/mit-73/little/tree/main/packages/lil_auto_increment/example/main.dart
