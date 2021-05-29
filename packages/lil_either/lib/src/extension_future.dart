import 'dart:async';

import 'either.dart';

/// Future Extension
extension FutureX<R> on Future<R> {
  /// Mapping [Future] to [Either]
  Future<Either<L, R>> toEither<L extends Exception>() async {
    try {
      return Either<L, R>.right(await this);
    } on Exception catch (e) {
      return Either<L, R>.left(e as L);
    }
  }
}

/// Either FutureOr Extension
extension EitherFutureX<L, R> on Either<FutureOr<L>, FutureOr<R>> {
  /// Wait Either on async function
  Future<Either<L, R>> waitEither() => when(
        onLeft: (FutureOr<L> v) async => Either<L, R>.left(await v),
        onRight: (FutureOr<R> v) async => Either<L, R>.right(await v),
      );
}

/// Future Either Extension
extension FutureEitherX<L, R> on Future<Either<L, R>> {
  /// Represents the left side of [Either] class which by convention is a "Failure".
  Future<bool> get isEitherLeft => then((Either<L, R> either) => either.isLeft);

  /// Represents the right side of [Either] class which by convention is a "Success"
  Future<bool> get isEitherRight =>
      then((Either<L, R> either) => either.isRight);

  /// Future Either type result on Callback
  ///
  /// if the result is an [left], it will be call in [onLeft],
  /// if it is a [right] it will be call in [onRight].
  Future<void> either({
    required EitherCallback<L> onLeft,
    required EitherCallback<R> onRight,
  }) async =>
      (await this).either(
        onLeft: onLeft,
        onRight: onRight,
      );

  /// Return the Future result in one of these functions.
  ///
  /// if the result is an [Left], it will be returned in [onLeft],
  /// if it is a [Right] it will be returned in [onRight].
  Future<T> whenEither<T>({
    required WhenCallback<T, L> onLeft,
    required WhenCallback<T, R> onRight,
  }) =>
      then((Either<L, R> either) => either.when(
            onLeft: onLeft,
            onRight: onRight,
          ));

  /// Return the async Future result in one of these async functions.
  ///
  /// if the result is an [Left], it will be returned in [onLeft],
  /// if it is a [Right] it will be returned in [onRight].
  Future<T> whenEitherAsync<T>({
    required AsyncWhenCallback<T, L> onLeft,
    required AsyncWhenCallback<T, R> onRight,
  }) async =>
      (await this).whenAsync(
        onLeft: onLeft,
        onRight: onRight,
      );

  /// The [maybeWhenEither] method is equivalent to [whenEither], but doesn't require all callbacks to be specified.
  /// On the other hand, it adds an extra [orElse] required parameter, for fallback behavior.
  Future<T> maybeWhenEither<T>({
    WhenCallback<T, L>? onLeft,
    WhenCallback<T, R>? onRight,
    required MaybeCallback<T> orElse,
  }) =>
      then((Either<L, R> either) => either.maybeWhen(
            onLeft: onLeft,
            onRight: onRight,
            orElse: orElse,
          ));

  /// The [maybeWhenEitherAsync] method is equivalent to [whenEitherAsync], but doesn't require all callbacks to be specified.
  /// On the other hand, it adds an extra [orElse] required parameter, for fallback behavior.
  Future<T> maybeWhenEitherAsync<T>({
    AsyncWhenCallback<T, L>? onLeft,
    AsyncWhenCallback<T, R>? onRight,
    required AsyncMaybeCallback<T> orElse,
  }) async =>
      (await this).maybeWhenAsync(
        onLeft: onLeft,
        onRight: onRight,
        orElse: orElse,
      );

  /// Return the Future [Either] result in one of these functions.
  ///
  /// if the result is an [Left], it will be returned in [onLeft],
  /// if it is a [Right] it will be returned in [onRight].
  Future<Either<L, R>> mapEither({
    required MapCallback<L> onLeft,
    required MapCallback<R> onRight,
  }) =>
      then((Either<L, R> either) => either.map(
            onLeft: onLeft,
            onRight: onRight,
          ));

  /// Return the async Future [Either] result in one of these async functions.
  ///
  /// if the result is an [Left], it will be returned in [onLeft],
  /// if it is a [Right] it will be returned in [onRight].
  Future<Either<L, R>> mapEitherAsync({
    required AsyncMapCallback<L> onLeft,
    required AsyncMapCallback<R> onRight,
  }) async =>
      (await this).mapAsync(
        onLeft: onLeft,
        onRight: onRight,
      );

  /// Future Cast to new [Left] & [Right] type
  Future<Either<F, S>> castEither<F, S>() =>
      then((Either<L, R> either) => either.cast());

  /// Future Swap [Left] and [Right]
  Future<Either<R, L>> swapEither() =>
      then((Either<L, R> either) => either.swap());
}
