import 'dart:async';

import 'either.dart';

/// Stream Extension
extension StreamX<R> on Stream<R> {
  /// Mapping [Future] to [Either]
  Stream<Either<L, R>> toEither<L extends Object>() {
    return transform(
      StreamTransformer<R, Either<L, R>>.fromHandlers(
        handleData: (R data, EventSink<Either<L, R>> sink) =>
            sink.add(Either<L, R>.right(data)),
        handleError: (Object error, _, EventSink<Either<L, R>> sink) =>
            sink.add(Either<L, R>.left(error as L)),
      ),
    );
  }
}

/// Stream Either Extension
extension StreamEitherX<L, R> on Stream<Either<L, R>> {
  /// Represents the left side of [Either] class which by convention is a "Failure".
  Future<bool> get isEitherLeft =>
      every((Either<L, R> either) => either.isLeft);

  /// Represents the right side of [Either] class which by convention is a "Success"
  Future<bool> get isEitherRight =>
      every((Either<L, R> either) => either.isRight);

  /// Future on Stream Either type result on Callback
  ///
  /// if the result is an [left], it will be call in [onLeft],
  /// if it is a [right] it will be call in [onRight].
  Future<void> either({
    required EitherCallback<L> onLeft,
    required EitherCallback<R> onRight,
  }) =>
      forEach((Either<L, R> either) => either.either(
            onLeft: onLeft,
            onRight: onRight,
          ));

  /// Return the Stream result in one of these functions.
  ///
  /// if the result is an [Left], it will be returned in [onLeft],
  /// if it is a [Right] it will be returned in [onRight].
  Stream<T> whenEither<T>({
    required WhenCallback<T, L> onLeft,
    required WhenCallback<T, R> onRight,
  }) =>
      map((Either<L, R> either) => either.when(
            onLeft: onLeft,
            onRight: onRight,
          ));

  /// The [maybeWhenEither] method is equivalent to [whenEither], but doesn't require all callbacks to be specified.
  /// On the other hand, it adds an extra [orElse] required parameter, for fallback behavior.
  Stream<T> maybeWhenEither<T>({
    WhenCallback<T, L>? onLeft,
    WhenCallback<T, R>? onRight,
    required MaybeCallback<T> orElse,
  }) =>
      map((Either<L, R> either) => either.maybeWhen(
            onLeft: onLeft,
            onRight: onRight,
            orElse: orElse,
          ));

  /// Return the Stream [Either] result in one of these functions.
  ///
  /// if the result is an [Left], it will be returned in [onLeft],
  /// if it is a [Right] it will be returned in [onRight].
  Stream<Either<L, R>> mapEither({
    required MapCallback<L> onLeft,
    required MapCallback<R> onRight,
  }) =>
      map((Either<L, R> either) =>
          either.map(onLeft: onLeft, onRight: onRight));

  /// Future Cast to new [Left] & [Right] type
  Stream<Either<F, S>> castEither<F, S>() =>
      map((Either<L, R> either) => either.cast());

  /// Future Swap [Left] and [Right]
  Stream<Either<R, L>> swapEither() =>
      map((Either<L, R> either) => either.swap());
}
