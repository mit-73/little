import 'dart:developer';

import 'package:lil_auto_increment/lil_auto_increment.dart';

void main() {
  final Id nextId1 = autoIncrement();
  final Id nextId2 = autoIncrement();

  for (int i = 0; i < 5; i++) {
    log(nextId1().toString(), name: 'nextId1');
  }
  for (int i = 0; i < 5; i++) {
    log(nextId2().toString(), name: 'nextId2');
  }
  for (int i = 0; i < 5; i++) {
    log(nextId1().toString(), name: 'nextId1');
  }
}
