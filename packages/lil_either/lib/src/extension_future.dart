import 'dart:async';

import 'either.dart';

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

extension EitherFutureX<L, R> on Either<FutureOr<L>, FutureOr<R>> {
  Future<Either<L, R>> waitEither() => when(
        onLeft: (FutureOr<L> v) async => Either<L, R>.left(await v),
        onRight: (FutureOr<R> v) async => Either<L, R>.right(await v),
      );
}

extension FutureEitherX<L, R> on Future<Either<L, R>> {
  /// Represents the left side of [Either] class which by convention is a "Failure".
  Future<bool> get isEitherLeft => then((Either<L, R> either) => either.isLeft);

  /// Represents the right side of [Either] class which by convention is a "Success"
  Future<bool> get isEitherRight =>
      then((Either<L, R> either) => either.isRight);

  Future<void> either({
    required Callback<L> onLeft,
    required Callback<R> onRight,
  }) async =>
      (await this).either(
        onLeft: onLeft,
        onRight: onRight,
      );

  Future<T> whenEither<T>({
    required TypeCallback<T, L> onLeft,
    required TypeCallback<T, R> onRight,
  }) =>
      then((Either<L, R> either) => either.when(
            onLeft: onLeft,
            onRight: onRight,
          ));

  Future<T> whenEitherAsync<T>({
    required AsyncTypeCallback<T, L> onLeft,
    required AsyncTypeCallback<T, R> onRight,
  }) async =>
      (await this).whenAsync(
        onLeft: onLeft,
        onRight: onRight,
      );

  Future<T> maybeWhenEither<T>({
    TypeCallback<T, L>? onLeft,
    TypeCallback<T, R>? onRight,
    required MaybeTypeCallback<T> orElse,
  }) =>
      then((Either<L, R> either) => either.maybeWhen(
            onLeft: onLeft,
            onRight: onRight,
            orElse: orElse,
          ));

  Future<T> maybeWhenEitherAsync<T>({
    AsyncTypeCallback<T, L>? onLeft,
    AsyncTypeCallback<T, R>? onRight,
    required AsyncMaybeTypeCallback<T> orElse,
  }) async =>
      (await this).maybeWhenAsync(
        onLeft: onLeft,
        onRight: onRight,
        orElse: orElse,
      );

  Future<Either<L, R>> mapEither({
    required MapCallback<L> onLeft,
    required MapCallback<R> onRight,
  }) =>
      then((Either<L, R> either) => either.map(
            onLeft: onLeft,
            onRight: onRight,
          ));

  Future<Either<L, R>> mapEitherAsync({
    required AsyncMapCallback<L> onLeft,
    required AsyncMapCallback<R> onRight,
  }) async =>
      (await this).mapAsync(
        onLeft: onLeft,
        onRight: onRight,
      );

  Future<Either<R, L>> swapEither() =>
      then((Either<L, R> either) => either.swap());

  Future<Either<F, S>> castEither<F, S>() =>
      then((Either<L, R> either) => either.cast());
}
