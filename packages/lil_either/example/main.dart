import 'dart:async';

import 'package:lil_either/lil_either.dart';

void main() async {
  final TestCase test = TestCase();

  print('//--------base--------//');
  final Either<MyException, MyResult> l = test.base(returnError: true);
  final Either<MyException, MyResult> r = test.base();

  print(l.isLeft);
  print(l.isRight);
  print(r.isLeft);
  print(r.isRight);
  print('//--------------//');
  print(l.left);
//   print(l.right); // Exception
//   print(r.left); // Exception
  print(r.right);
  print('//--------------//');
  l.either(onLeft: print, onRight: print);
  r.either(onLeft: print, onRight: print);
  print('//--------------//');
  print(l.when(
      onLeft: (v) => v.message + ' test', onRight: (v) => v.message + ' test'));
  print(r.when(
      onLeft: (v) => v.message + ' test', onRight: (v) => v.message + ' test'));
  print('//--------------//');
  print(l.maybeWhen(onRight: (v) => v, orElse: () => 'orElse'));
  print(r.maybeWhen(onLeft: (v) => v, orElse: () => 'orElse'));
  print('//--------------//');
  print(l.map(onLeft: (v) => v, onRight: (v) => v).isLeft);
  print(r.map(onLeft: (v) => v, onRight: (v) => v).isRight);
  print('//--------------//');
  print(l.swap().isLeft);
  print(r.swap().isRight);

  print('//--------async--------//');
  Future<Either<MyException, MyResult>> fl =
      test.future(returnError: true).toEither<MyException>();
  Future<Either<MyException, MyResult>> fr =
      test.future().toEither<MyException>();

  print(await fl.isEitherLeft);
  print(await fl.isEitherRight);
  print(await fr.isEitherLeft);
  print(await fr.isEitherRight);
  print('//--------------//');
  print(await fl.whenEither(
      onLeft: (v) => v.message + ' test', onRight: (v) => v.message + ' test'));
  print(await fr.whenEither(
      onLeft: (v) => v.message + ' test', onRight: (v) => v.message + ' test'));
  print('//--------------//');
  print(await fl.maybeWhenEither(onRight: (v) => v, orElse: () => 'orElse'));
  print(await fr.maybeWhenEither(onLeft: (v) => v, orElse: () => 'orElse'));
  print('//--------------//');
  print(await fl.mapEither(onLeft: (v) => v, onRight: (v) => v).isEitherLeft);
  print(await fr.mapEither(onLeft: (v) => v, onRight: (v) => v).isEitherRight);
  print('//--------------//');
  print(await fl.swapEither().isEitherLeft);
  print(await fr.swapEither().isEitherRight);

  print('//--------stream--------//');
  Stream<Either<MyException, MyResult>> s =
      test.stream(10).toEither<MyException>();

  s.listen(
    (e) {
      print(e.when(onLeft: (v) => v.message, onRight: (v) => v.message));
      print('|------|');
    },
    cancelOnError: false,
  );
}

class TestCase {
  Either<MyException, MyResult> base({bool returnError = false}) {
    if (returnError) {
      return Either.left(MyException());
    } else {
      return Either.right(MyResult());
    }
  }

  Future<MyResult> future({bool returnError = false}) async {
    if (returnError) {
      return Future<MyResult>.error(MyException());
    } else {
      return Future<MyResult>.value(MyResult());
    }
  }

  Stream<MyResult> stream(int count) {
    final StreamController<MyResult> controller = StreamController<MyResult>();
    for (var i = 0; i < count; i++) {
      if (i.isOdd) {
        controller.addError(MyException());
        continue;
      }
      controller.add(MyResult());
    }
    return controller.stream;
  }
}

class MyException implements Exception {
  MyException([this.message = 'left']);

  final String message;

  @override
  String toString() => message;

  @override
  int get hashCode => message.hashCode;

  @override
  bool operator ==(Object other) =>
      other is MyException && other.message == message;
}

class MyResult {
  MyResult([this.message = 'right']);

  final String message;

  @override
  String toString() => message;

  @override
  int get hashCode => message.hashCode;

  @override
  bool operator ==(Object other) =>
      other is MyResult && other.message == message;
}
