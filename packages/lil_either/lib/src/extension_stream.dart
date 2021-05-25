import 'dart:async';

import 'either.dart';

extension StreamEitherX<L, R> on Stream<Either<L, R>> {
  Future<bool> get isEitherLeft =>
      every((Either<L, R> either) => either.isLeft);
  Future<bool> get isEitherRight =>
      every((Either<L, R> either) => either.isRight);

  Future<void> either({
    required EitherCallback<L> onLeft,
    required EitherCallback<R> onRight,
  }) =>
      forEach((Either<L, R> either) => either.either(
            onLeft: onLeft,
            onRight: onRight,
          ));

  Stream<T> whenEither<T>({
    required WhenCallback<T, L> onLeft,
    required WhenCallback<T, R> onRight,
  }) =>
      map((Either<L, R> either) => either.when(
            onLeft: onLeft,
            onRight: onRight,
          ));

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

  Stream<Either<L, R>> mapEither({
    required MapCallback<L> onLeft,
    required MapCallback<R> onRight,
  }) =>
      map((Either<L, R> either) =>
          either.map(onLeft: onLeft, onRight: onRight));

  Stream<Either<R, L>> swapEither() =>
      map((Either<L, R> either) => either.swap());

  Stream<Either<F, S>> castEither<F, S>() =>
      map((Either<L, R> either) => either.cast());
}
