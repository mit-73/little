import 'dart:async';

import 'package:test/test.dart';

import 'package:lil_either/lil_either.dart';

class TestCase {
  Either<MyException, MyResult> base({bool returnError = false}) {
    if (returnError) {
      return Either<MyException, MyResult>.left(MyException());
    } else {
      return Either<MyException, MyResult>.right(MyResult());
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
    for (int i = 0; i < count; i++) {
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

void main() {
  final TestCase testCase = TestCase();

  group('Either base test', () {
    final Either<MyException, MyResult> left = testCase.base(returnError: true);
    final Either<MyException, MyResult> right = testCase.base();

    test('is', () {
      expect(left.isLeft, true);
      expect(left.isRight, false);
      expect(right.isLeft, false);
      expect(right.isRight, true);
    });

    test('type', () {
      expect(left.left, MyException());
      // expect(left.right, Exception()); // Exception
      // expect(right.left, Exception()); // Exception
      expect(right.right, MyResult());
    });

    test('either', () {
      left.either(
        onLeft: (MyException v) => expect(v.runtimeType, MyException),
        onRight: (MyResult v) => fail('Not be executed'),
      );
      right.either(
        onLeft: (MyException v) => fail('Not be executed'),
        onRight: (MyResult v) => expect(v.runtimeType, MyResult),
      );
    });

    test('when', () {
      expect(
        left.when<String>(
          onLeft: (MyException v) => '${v.message} test',
          onRight: (MyResult v) => '${v.message} test',
        ),
        'left test',
      );
      expect(
        right.when<String>(
          onLeft: (MyException v) => '${v.message} test',
          onRight: (MyResult v) => '${v.message} test',
        ),
        'right test',
      );
    });

    test('maybeWhen', () {
      expect(
        left.maybeWhen<String>(
          // onLeft: (MyException v) => v.message,
          onRight: (MyResult v) => v.message,
          orElse: () => 'orElse',
        ),
        'orElse',
      );
      expect(
        right.maybeWhen<String>(
          onLeft: (MyException v) => v.message,
          // onRight: (MyResult v) => v.message,
          orElse: () => 'orElse',
        ),
        'orElse',
      );
    });

    test('map', () {
      expect(
        left
            .map(
              onLeft: (MyException v) => v,
              onRight: (MyResult v) => v,
            )
            .isLeft,
        true,
      );
      expect(
        left
            .map(
              onLeft: (MyException v) => v,
              onRight: (MyResult v) => v,
            )
            .isRight,
        false,
      );
      expect(
        right
            .map(
              onLeft: (MyException v) => v,
              onRight: (MyResult v) => v,
            )
            .isRight,
        true,
      );
      expect(
        right
            .map(
              onLeft: (MyException v) => v,
              onRight: (MyResult v) => v,
            )
            .isLeft,
        false,
      );
    });

    test('swap', () {
      final Either<MyResult, MyException> _left = left.swap();
      final Either<MyResult, MyException> _right = right.swap();

      expect(_left.isLeft, false);
      expect(_left.isRight, true);
      expect(_right.isLeft, true);
      expect(_right.isRight, false);
    });
  });

  group('Either future test', () {});

  group('Either stream test', () {});
}
