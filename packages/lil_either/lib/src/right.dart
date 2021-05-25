part of 'either.dart';

class Right<L, R> extends Either<L, R> {
  Right(this.value);

  final R value;

  @override
  void either({
    required EitherCallback<L> onLeft,
    required EitherCallback<R> onRight,
  }) =>
      onRight(value);

  @override
  T when<T>({
    required WhenCallback<T, L> onLeft,
    required WhenCallback<T, R> onRight,
  }) =>
      onRight(value);

  @override
  Future<T> whenAsync<T>({
    required AsyncWhenCallback<T, L> onLeft,
    required AsyncWhenCallback<T, R> onRight,
  }) async =>
      onRight(value);

  @override
  T maybeWhen<T>({
    WhenCallback<T, L>? onLeft,
    WhenCallback<T, R>? onRight,
    required MaybeCallback<T> orElse,
  }) =>
      onRight != null ? onRight(value) : orElse();

  @override
  Future<T> maybeWhenAsync<T>({
    AsyncWhenCallback<T, L>? onLeft,
    AsyncWhenCallback<T, R>? onRight,
    required AsyncMaybeCallback<T> orElse,
  }) async =>
      onRight != null ? onRight(value) : orElse();

  @override
  Either<L, R> map({
    required MapCallback<L> onLeft,
    required MapCallback<R> onRight,
  }) =>
      Right<L, R>(onRight(value));

  @override
  Future<Either<L, R>> mapAsync({
    required AsyncMapCallback<L> onLeft,
    required AsyncMapCallback<R> onRight,
  }) async =>
      Right<L, R>(await onRight(value));

  @override
  Either<F, S> cast<F, S>() => Right<F, S>(value as S);
}
